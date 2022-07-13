Class {
	#name : #BrSequenceableCollectionItemsProvider,
	#superclass : #BrItemsProvider,
	#instVars : [
		'collection'
	],
	#category : #'Brick-! Core - Item Providers'
}

{ #category : #'instance creation' }
BrSequenceableCollectionItemsProvider class >> forCollection: aSequenceableCollection [
	^ self new collection: aSequenceableCollection
]

{ #category : #accessing }
BrSequenceableCollectionItemsProvider >> attachToListModel: aListModel [
	super attachToListModel: aListModel.

	self notifyItemsChangedSynchronously: true
]

{ #category : #accessing }
BrSequenceableCollectionItemsProvider >> collection [

	^ collection
]

{ #category : #accessing }
BrSequenceableCollectionItemsProvider >> collection: aSequenceableCollection [
	self
		assert: [
			[ aSequenceableCollection size isZero
				or: [ aSequenceableCollection at: 1 ]. true ]
			on: Error do: [ :e | false ] ]
		description: [ 'Collection must be indexable but was {1}' format: { aSequenceableCollection class } ].

	collection := aSequenceableCollection
]

{ #category : #accessing }
BrSequenceableCollectionItemsProvider >> currentItems [
	^ collection
]

{ #category : #initialization }
BrSequenceableCollectionItemsProvider >> initialize [
	super initialize.
	
	collection := #()
]

{ #category : #accessing }
BrSequenceableCollectionItemsProvider >> isDone [
	^ true
]

{ #category : #accessing }
BrSequenceableCollectionItemsProvider >> itemAt: anIndex [
	^ self collection at: anIndex
]

{ #category : #accessing }
BrSequenceableCollectionItemsProvider >> itemCount [
	<return: #Number>

	^ self collection size
]

{ #category : #'api - loading' }
BrSequenceableCollectionItemsProvider >> preloadUntilFoundSuchThat: aBlock [
	<return: #TAsyncPromise>

	^ AsyncFulfilledPromise new value: (collection
		detectIndex: aBlock
		ifNone: [ 0 ])
]
