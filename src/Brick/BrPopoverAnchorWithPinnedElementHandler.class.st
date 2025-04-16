Class {
	#name : #BrPopoverAnchorWithPinnedElementHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'pinnedElement',
		'pinnedElementParent',
		'positionShift',
		'anchorElement',
		'aboutToBeClosedHandler',
		'pinnedElementPullEndEventHandler'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #'private - updating' }
BrPopoverAnchorWithPinnedElementHandler >> computeDistanceTo: anElement [
	pinnedElement ifNil: [ ^ self ].

	positionShift := anElement positionInSpace - pinnedElement positionInSpace.
]

{ #category : #'event handling' }
BrPopoverAnchorWithPinnedElementHandler >> elementAddedToSceneGraphEvent: anEvent [
	self showPinnedElementOn: anEvent
]

{ #category : #'event handling' }
BrPopoverAnchorWithPinnedElementHandler >> elementPositionInSpaceChangedEvent: anEvent [
	self relocatePinnedElementOn: anEvent
]

{ #category : #'event handling' }
BrPopoverAnchorWithPinnedElementHandler >> elementRemovedFromSceneGraphEvent: anEvent [
	self hidePinnedElement
]

{ #category : #'api - accessing' }
BrPopoverAnchorWithPinnedElementHandler >> eventsToHandle [
	^ {BlElementAddedToSceneGraphEvent.
		BlElementRemovedFromSceneGraphEvent.
		BlElementPositionInSpaceChangedEvent}
]

{ #category : #'private - updating' }
BrPopoverAnchorWithPinnedElementHandler >> hidePinnedElement [
	pinnedElement removeFromParent
]

{ #category : #'api - hooks' }
BrPopoverAnchorWithPinnedElementHandler >> onInstalledIn: anElement [
	super onInstalledIn: anElement.

	self
		assert: [ anElement isKindOf: BlElement ]
		description: [ 'I can be installed only on elements: {1}' format: {anElement} ].
	self 
		assert: [ anchorElement isNil ]
		description: [ 'I can be installed only on one element. Already installed on {1}. New request: {2}' format: { anchorElement. anElement } ].
	self 
		assert: [ pinnedElement isNotNil ]
		description: [ 'Pinned element must be initialized' ].
		
	anchorElement := anElement.
	
	pinnedElement dispatchEvent: (BrPopoverAnchorElementChanged new
		anchorElement: anElement).
		
	BlTaskAction
		enqueueElement: anElement
		action: [ self computeDistanceTo: anElement ]
]

{ #category : #accessing }
BrPopoverAnchorWithPinnedElementHandler >> onPinnedElementAboutToBeClosed: anEvent [ 
	"Uninstall event handlers on the pinned element close action."

	pinnedElement dispatchEvent: (BrPopoverAnchorElementChanged new
		anchorElement: nil).
	
	pinnedElement removeEventHandler: aboutToBeClosedHandler.
	pinnedElement removeEventHandler: pinnedElementPullEndEventHandler.
	anchorElement removeEventHandler: self.
	pinnedElement := nil.
	pinnedElementParent := nil.
]

{ #category : #'event handling' }
BrPopoverAnchorWithPinnedElementHandler >> onPinnedElementPullEndEvent: anEvent [
	"Recompute pinned element distance when it is dragged by a user"

	anchorElement ifNotNil: [ :anElement | 
		self computeDistanceTo: anElement ]
]

{ #category : #'api - hooks' }
BrPopoverAnchorWithPinnedElementHandler >> onUninstalledIn: anElement [
	super onUninstalledIn: anElement.

	anchorElement := nil.
	positionShift := nil.
]

{ #category : #accessing }
BrPopoverAnchorWithPinnedElementHandler >> pinnedElement [
	^ pinnedElement
]

{ #category : #accessing }
BrPopoverAnchorWithPinnedElementHandler >> pinnedElement: anElement [
	self
		assert: [ pinnedElement isNil ]
		description: [ 'Pinned element can be initialized only once' ].
	self
		assert: [ anElement parent isNotNil ]
		description: [ 'Pinned element must have a parent' ].
	
	pinnedElement := anElement.
	pinnedElementParent := anElement parent.
	
	aboutToBeClosedHandler := (BlEventHandler 
		on: BrPopoverPinnedElementAboutToBeClosed 
		do: [ :anEvent | self onPinnedElementAboutToBeClosed: anEvent ]).
	pinnedElementPullEndEventHandler := (BlEventHandler 
		on: BlPullEndEvent 
		do: [ :anEvent | self onPinnedElementPullEndEvent: anEvent ]).
	anElement addEventHandler: aboutToBeClosedHandler.
	anElement addEventHandler: pinnedElementPullEndEventHandler.
]

{ #category : #'private - updating' }
BrPopoverAnchorWithPinnedElementHandler >> relocatePinnedElementOn: anEvent [
	| aCurrentShift aDelta aNewPosition |
	positionShift ifNil: [ ^ self ].
	
	aCurrentShift := anEvent currentTarget positionInSpace - pinnedElement positionInSpace.
	(aCurrentShift closeTo: positionShift precision: 1) ifTrue: [ ^ self ].
	
	aDelta := positionShift - aCurrentShift.
	aNewPosition := pinnedElement positionInSpace - aDelta.
	
	pinnedElement relocate: aNewPosition
]

{ #category : #'private - updating' }
BrPopoverAnchorWithPinnedElementHandler >> showPinnedElementOn: anEvent [
	anEvent currentTarget space == pinnedElementParent space
		ifFalse: [ pinnedElementParent := anEvent currentTarget space root ].
	
	pinnedElement parent == pinnedElementParent ifTrue: [ ^ self ].
	
	pinnedElement removeFromParent.
	pinnedElementParent addChild: pinnedElement
]

{ #category : #'api - event managing' }
BrPopoverAnchorWithPinnedElementHandler >> wantsEvent: anEvent [
	^ (super wantsEvent: anEvent) and: [ pinnedElement isNotNil ]
]
