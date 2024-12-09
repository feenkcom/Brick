Class {
	#name : #BrMenuAnchorWithPinnedElementHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'pinnedElement',
		'pinnedElementParent',
		'positionShift',
		'anchorElement',
		'aboutToBeClosedHandler'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #'private - updating' }
BrMenuAnchorWithPinnedElementHandler >> computeDistanceTo: anElement [
	pinnedElement ifNil: [ ^ self ].

	positionShift := anElement positionInSpace - pinnedElement positionInSpace.
	NonInteractiveTranscript stdout show: 'Anchor distance: '; show: positionShift; cr.
]

{ #category : #'event handling' }
BrMenuAnchorWithPinnedElementHandler >> elementAddedToSceneGraphEvent: anEvent [
	self showPinnedElementOn: anEvent
]

{ #category : #'event handling' }
BrMenuAnchorWithPinnedElementHandler >> elementPositionInSpaceChangedEvent: anEvent [
	self relocatePinnedElementOn: anEvent
]

{ #category : #'event handling' }
BrMenuAnchorWithPinnedElementHandler >> elementRemovedFromSceneGraphEvent: anEvent [
	self hidePinnedElement
]

{ #category : #'api - accessing' }
BrMenuAnchorWithPinnedElementHandler >> eventsToHandle [
	^ {BlElementAddedToSceneGraphEvent.
		BlElementRemovedFromSceneGraphEvent.
		BlElementPositionInSpaceChangedEvent}
]

{ #category : #'private - updating' }
BrMenuAnchorWithPinnedElementHandler >> hidePinnedElement [
	pinnedElement removeFromParent
]

{ #category : #accessing }
BrMenuAnchorWithPinnedElementHandler >> onAboutToBeClosed: anEvent [ 
	pinnedElement removeEventHandler: aboutToBeClosedHandler.
	anchorElement removeEventHandler: self.
	pinnedElement := nil.
	pinnedElementParent := nil.
]

{ #category : #'api - hooks' }
BrMenuAnchorWithPinnedElementHandler >> onInstalledIn: anElement [
	super onInstalledIn: anElement.

	self
		assert: [ anElement isKindOf: BlElement ]
		description: [ 'I can be installed only on elements: {1}' format: {anElement} ].
	self 
		assert: [ anchorElement isNil ]
		description: [ 'I can be installed only on one element. Already installed on {1}. New request: {2}' format: { anchorElement. anElement } ].
		
	anchorElement := anElement.
		
	BlTaskAction
		enqueueElement: anElement
		action: [ self computeDistanceTo: anElement ]
]

{ #category : #accessing }
BrMenuAnchorWithPinnedElementHandler >> pinnedElement [
	^ pinnedElement
]

{ #category : #accessing }
BrMenuAnchorWithPinnedElementHandler >> pinnedElement: anElement [
	self
		assert: [ pinnedElement isNil ]
		description: [ 'Pinned element can be initialized only once' ].
	self
		assert: [ anElement parent isNotNil ]
		description: [ 'Pinned element must have a parent' ].
	
	pinnedElement := anElement.
	pinnedElementParent := anElement parent.
	
	aboutToBeClosedHandler := (BlEventHandler 
		on: BrMenuPinnedElementAboutToBeClosed 
		do: [ :anEvent | self onAboutToBeClosed: anEvent ]).
	anElement addEventHandler: aboutToBeClosedHandler.
]

{ #category : #'private - updating' }
BrMenuAnchorWithPinnedElementHandler >> relocatePinnedElementOn: anEvent [
	| aCurrentShift aDelta aNewPosition |
	positionShift ifNil: [ ^ self ].
	
	aCurrentShift := anEvent currentTarget positionInSpace - pinnedElement positionInSpace.
	(aCurrentShift closeTo: positionShift precision: 1) ifTrue: [ ^ self ].
	
	aDelta := positionShift - aCurrentShift.
	aNewPosition := pinnedElement positionInSpace - aDelta.
	
	pinnedElement relocate: aNewPosition
]

{ #category : #'private - updating' }
BrMenuAnchorWithPinnedElementHandler >> showPinnedElementOn: anEvent [
	anEvent currentTarget space == pinnedElementParent space
		ifFalse: [ pinnedElementParent := anEvent currentTarget space root ].
	
	pinnedElementParent addChild: pinnedElement
]

{ #category : #'api - event managing' }
BrMenuAnchorWithPinnedElementHandler >> wantsEvent: anEvent [
	^ (super wantsEvent: anEvent) and: [ pinnedElement isNotNil ]
]
