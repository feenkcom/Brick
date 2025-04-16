"
I am a {{gtClass:BrMenuInitialStencilBuilder}}'s parameter. I hold information that can be used to build the first {{gtClass:BrMenu}} element displayed in {{gtClass:BrMenuSteppedElement}}.
See {{gtMethod:BrWithExplicitPopoverAptitude>>#showIn:dueToEvent:}} for more details.

"
Class {
	#name : #BrMenuInitialContext,
	#superclass : #Object,
	#instVars : [
		'anchorElement',
		'menuAptitude',
		'positionInSpace',
		'elementBuilder',
		'dueToEvent'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #accessing }
BrMenuInitialContext >> anchorElement [
	"Return an element to which a menu aptitude is attached to."

	<return: #BlElement>
	^ anchorElement
]

{ #category : #accessing }
BrMenuInitialContext >> anchorElement: anElement [
	"Set an element to which a menu aptitude is attached to."

	anchorElement := anElement
]

{ #category : #accessing }
BrMenuInitialContext >> childrenPositionDo: aPositionBlock ifAbsentDo: anAbsentBlock [
	"Call aPositionBlock with an event position in children coordinates where a click (an open menu request) happened.
	Call anAbsentBlock if the position is unknown or the open menu request happened by other means."

	^ self
		dueToEventDo: [ :anEvent | aPositionBlock cull: anEvent childrenPosition ]
		ifAbsentDo: anAbsentBlock
]

{ #category : #accessing }
BrMenuInitialContext >> childrenPositionIfAbsent: anAbsentBlock [
	"Return an event position in children coordinates where a click (an open menu request) happened.
	Call anAbsentBlock if the position is unknown or the open menu request happened by other means."

	<return: #Point>
	^ self
		dueToEventDo: [ :anEvent | anEvent childrenPosition ]
		ifAbsentDo: anAbsentBlock
]

{ #category : #accessing }
BrMenuInitialContext >> dueToEvent [
	^ dueToEvent
]

{ #category : #accessing }
BrMenuInitialContext >> dueToEvent: anEvent [ 
	anEvent ifNil: [ ^ self ].
	
	"TODO: Do I need to do something like: 
		`self root globalPointToLocal: anEvent position`?
	Source: `BrWithContextMenuAptitude>>#onMouseUp:`
	Note: Handle is not properly positioned in `BrAnchoredExamples>>#contextMenu`
		using the new context menu implementation."
	dueToEvent := anEvent.
	self positionInSpace: anEvent position
]

{ #category : #accessing }
BrMenuInitialContext >> dueToEventDo: aBlock ifAbsentDo: anAbsentBlock [
	^ dueToEvent ifNotNil: aBlock ifNil: anAbsentBlock
]

{ #category : #accessing }
BrMenuInitialContext >> elementBuilder [
	"Return an element builder which knows how to build menu elements."

	<return: #BrMenuElementBuilder>
	^ elementBuilder
]

{ #category : #accessing }
BrMenuInitialContext >> elementBuilder: aBrMenuElementBuilder [
	"Set an element builder which knows how to build menu elements."

	elementBuilder := aBrMenuElementBuilder
]

{ #category : #accessing }
BrMenuInitialContext >> menuAptitude [
	"Return a menu aptitude which handles menu (context menu, dropdown, or tooltip)."

	<return: #BrWithExplicitPopoverAptitude>
	^ menuAptitude
]

{ #category : #accessing }
BrMenuInitialContext >> menuAptitude: aBrWithExplicitMenuAptitude [
	"Set a menu aptitude which handles menu (context menu, dropdown, or tooltip)."
	
	menuAptitude := aBrWithExplicitMenuAptitude
]

{ #category : #accessing }
BrMenuInitialContext >> positionInSpace [
	"Return a position in space where a click (an open menu request) happened.
	Return nil if the position is unknown or the open menu request happened by other means."

	<return: #Point or: nil>
	^ positionInSpace
]

{ #category : #accessing }
BrMenuInitialContext >> positionInSpace: aPointOrNil [
	"Set a position in space where a click (an open menu request) happened.
	Set nil if the position is unknown or the open menu request happened by other means."

	positionInSpace := aPointOrNil
]
