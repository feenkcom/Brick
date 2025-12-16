Class {
	#name : #BrSearchMarkableAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'itemId',
		'cache'
	],
	#category : #'Brick-List - Search Aptitude'
}

{ #category : #'private - search' }
BrSearchMarkableAptitude >> cacheDo: aBlock [
	^ cache ifNotNil: aBlock 
]

{ #category : #'private - search' }
BrSearchMarkableAptitude >> findItems: aMarkContext using: aMarker [
	self subclassResponsibility
]

{ #category : #'private - search' }
BrSearchMarkableAptitude >> foundItemsDo: aFoundBlock ifAbsent: anAbsentBlock [
	^ self
		cacheDo: [ :aCache | 
			self
				itemIdDo: [ :anItemId | 
					aCache
						at: anItemId
						ifPresent: aFoundBlock
						ifAbsent: anAbsentBlock ] ]
]

{ #category : #initialization }
BrSearchMarkableAptitude >> initializeListeners [
	super initializeListeners.

	self when: BrSearchFoundItemsWish do: [ :anEvent | self onBrSearchFoundItemsWish: anEvent ].
	self when: BrSearchItemIdWish do: [ :anEvent | self onBrSearchItemIdWish: anEvent ]
]

{ #category : #'private - search' }
BrSearchMarkableAptitude >> itemIdDo: aBlock [
	^ itemId ifNotNil: aBlock 
]

{ #category : #'private - event handling' }
BrSearchMarkableAptitude >> onBrSearchFoundItemsWish: anEvent [
	| foundItems |
	anEvent consumed: true.

	foundItems := self findItems: anEvent context using: anEvent marker.
	anEvent foundItems: foundItems.
	
	anEvent cacheDo: [ :aCache | 
		cache := aCache.
		self itemIdDo: [ :anItemId | 
			aCache at: anItemId put: foundItems ] ]
]

{ #category : #'private - event handling' }
BrSearchMarkableAptitude >> onBrSearchItemIdWish: anEvent [
	anEvent consumed: true.

	itemId = anEvent itemId ifTrue: [ ^ self ].
	
	itemId := anEvent itemId.
	self onItemIdChanged
]

{ #category : #'private - event handling' }
BrSearchMarkableAptitude >> onItemIdChanged [
]
