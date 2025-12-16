Class {
	#name : #BrSearchMarker,
	#superclass : #Object,
	#instVars : [
		'computation',
		'announcer'
	],
	#category : #'Brick-List - Search Model'
}

{ #category : #'api - markers' }
BrSearchMarker >> asyncMarkFoundItem: aFoundItem context: aMarkContext [
	self flag: #todo
]

{ #category : #'api - markers' }
BrSearchMarker >> asyncMarkFoundItems: foundItems context: aMarkContext [
	foundItems
		withIndexDo: [ :eachFoundItem :eachIndex | 
			eachFoundItem index: eachIndex.
			eachFoundItem isSelected: (aMarkContext isSelectedItem: eachFoundItem index: eachIndex).
			self asyncMarkFoundItem: eachFoundItem context: aMarkContext ]
]

{ #category : #'api - search' }
BrSearchMarker >> findVisibleItems: aMarkContext inElement: anElement cache: aCache [
	<return: #Array of: #BrSearchFoundItem>
	| aWish |
	aWish := BrSearchFoundItemsWish new
			context: aMarkContext;
			marker: self.
	anElement dispatchEvent: aWish.

	^ aWish foundItems
]

{ #category : #'api - search' }
BrSearchMarker >> findVisibleItems: aMarkContext inElements: aCollection cache: aCache [
	<return: #Array of: #BrSearchFoundItem>
	^ aCollection
		flatCollect: [ :eachElement | 
			self
				findVisibleItems: aMarkContext
				inElement: eachElement
				cache: aCache ]
]

{ #category : #initialization }
BrSearchMarker >> initialize [
	super initialize.
	announcer := Announcer new
]

{ #category : #'api - markers' }
BrSearchMarker >> mark: aMarkContext [
	"It must be called from a UI process"

	| foundItems |
	aMarkContext hasSource ifFalse: [ ^ self ].

	foundItems := BrSearchVisibleArea new
			findItems: aMarkContext
			using: self.

	self markFoundItems: foundItems context: aMarkContext.
	aMarkContext foundItems: foundItems.
	self notifyProgressItems: foundItems context: aMarkContext.

	BrSearchEverything new 
		mark: aMarkContext 
		using: self.
	
	"computation markText: aMarkContext using: self"
]

{ #category : #'api - markers' }
BrSearchMarker >> markFoundItem: aFoundItem context: aMarkContext [ 
	aFoundItem mark: aMarkContext using: self
]

{ #category : #'api - markers' }
BrSearchMarker >> markFoundItems: foundItems context: aMarkContext [
	foundItems
		withIndexDo: [ :eachFoundItem :eachIndex | 
			eachFoundItem index: eachIndex.
			eachFoundItem isSelected: eachIndex = 1.
			self markFoundItem: eachFoundItem context: aMarkContext ]
]

{ #category : #'api - markers' }
BrSearchMarker >> markFoundTextItem: aFoundItem context: aMarkContext [
	| anAttribute |
	anAttribute := BrSearchTextMarkAttribute new
			index: aFoundItem index;
			isSelected: false;
			paint: (self newTextMarkPaint: aFoundItem isSelected).

	(aFoundItem text 
		from: aFoundItem startIndex 
		to: aFoundItem stopIndex)
			attribute: anAttribute.
	aFoundItem textAttribute: anAttribute
]

{ #category : #'api - markers' }
BrSearchMarker >> markNext: aContext [
	self flag: #todo
]

{ #category : #'api - markers' }
BrSearchMarker >> markPrevious: aContext [
	self flag: #todo
]

{ #category : #'api - markers' }
BrSearchMarker >> markVisibleSource: aMarkContext [ 
]

{ #category : #'api - markers' }
BrSearchMarker >> newTextMarkPaint: isCurrentItem [
	^ isCurrentItem
		ifTrue: [ BrGlamorousColors failureBackgroundColor ]
		ifFalse: [ BrGlamorousColors disabledButtonTextColor ]
]

{ #category : #'api - notifying' }
BrSearchMarker >> notifyException: anException context: aMarkContext [
	"Notification may be called from a non-UI process."

	announcer
		announce: (BrSearchExceptionAnnouncement new
				exception: anException;
				context: aMarkContext)
]

{ #category : #'api - notifying' }
BrSearchMarker >> notifyFoundItems: foundItems context: aMarkContext [
	"Notification may be called from a non-UI process."

	announcer
		announce: (BrSearchFinishedAnnouncement new
				items: foundItems;
				selectedIndex: aMarkContext selectedIndex; 
				context: aMarkContext)
]

{ #category : #'api - notifying' }
BrSearchMarker >> notifyProgressItems: someFoundItems context: aMarkContext [
	"Notification may be called from a non-UI process."

	announcer
		announce: (BrSearchProgressAnnouncement new
				items: someFoundItems;
				selectedIndex: aMarkContext selectedIndex; 
				context: aMarkContext)
]

{ #category : #'api - markers' }
BrSearchMarker >> unmark: aMarkContext [
	"It must be called from a UI process"

	aMarkContext foundItems do: [ :eachFoundItem |
		eachFoundItem unmark: aMarkContext ].

	self notifyFoundItems: #() context: aMarkContext
]

{ #category : #'api - subscriptions' }
BrSearchMarker >> unsubscribe: anObject [
	^ announcer unsubscribe: anObject
]

{ #category : #'api - subscriptions' }
BrSearchMarker >> when: anEventSelector send: aMessageSelector to: anObject [
	^ announcer weak
		when: anEventSelector
		send: aMessageSelector
		to: anObject
]
