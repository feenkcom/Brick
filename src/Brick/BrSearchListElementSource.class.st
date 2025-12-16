Class {
	#name : #BrSearchListElementSource,
	#superclass : #BrSearchSource,
	#instVars : [
		'listElement',
		'cache',
		'itemText'
	],
	#category : #'Brick-List - Search Model'
}

{ #category : #'api - search' }
BrSearchListElementSource >> findAllItems: aMarkContext using: aMarker [
	<return: #TAsyncPromise of: #Array of: #BrSearchFoundItem>
	| allItems allItemsPromise |
	allItems := AsyncSharedOrderedCollection new.
	allItemsPromise := AsyncManualPromise new.
	listElement
			itemSuchThat: [ :eachItem | 
				| aText foundIndexes |
				aText := itemText value: eachItem.
				foundIndexes := aMarkContext pattern findAllIndexesInText: aText.
				cache at: eachItem put: foundIndexes.
				allItems addAll: foundIndexes.	"we need to iterate all items"
				false ]
			ifFound: [ :anIndex :isSynchronous |
				allItemsPromise fulfillWithValue: allItems asArray ]
			ifNone: [ :isSynchronous |
				allItemsPromise fulfillWithValue: allItems asArray ].
	
	listElement enqueueTask: (BlPromiseTask new 
		promise: allItemsPromise).
	
	^ allItemsPromise
]

{ #category : #'api - search' }
BrSearchListElementSource >> findVisibleItems: aMarkContext using: aMarker [
	<return: #Array of: #BrSearchFoundItem>
	^ listElement
		childWithId: #scrollable
		ifFound: [ :anInfiniteElement | 
			aMarker
				findVisibleItems: aMarkContext
				inElements: anInfiniteElement children
				cache: cache ]
		ifNone: [ ^ #() ]
]

{ #category : #'api - testing' }
BrSearchListElementSource >> hasSource [
	<return: #Boolean>
	^ listElement isNotNil
]

{ #category : #'api - testing' }
BrSearchListElementSource >> hasVisibleSource [
	<return: #Boolean>
	^ self hasSource
		and: [ self listElement
				childWithId: #scrollabel
				ifFound: [ :anInfiniteElement | anInfiniteElement hasChildren ]
				ifNone: [ false ] ]
]

{ #category : #initialization }
BrSearchListElementSource >> initialize [
	super initialize.
	cache := AsyncSharedWeakIdentityKeyDictionary new.
	itemText := [ :anItem | anItem gtDisplayText ]
]

{ #category : #accessing }
BrSearchListElementSource >> itemText [
	^ itemText
]

{ #category : #accessing }
BrSearchListElementSource >> itemText: anObject [
	itemText := anObject
]

{ #category : #accessing }
BrSearchListElementSource >> listElement [
	<return: #BrList>
	^ listElement
]

{ #category : #accessing }
BrSearchListElementSource >> listElement: aBrList [
	self assert: [ aBrList isKindOf: BrList ].

	listElement := aBrList
]
