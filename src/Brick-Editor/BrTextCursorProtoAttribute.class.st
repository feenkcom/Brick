Class {
	#name : #BrTextCursorProtoAttribute,
	#superclass : #BrTextEventHandlerAttribute,
	#instVars : [
		'enterAction',
		'leaveAction',
		'isInside'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #events }
BrTextCursorProtoAttribute >> handleEvent: anEvent in: aTextEditor on: aTBrTextEditorTextualPiece [
	"Handle a given event or dispatch it using #sendTo:"

	(anEvent isKindOf: BrTextCursorAttributeEnterEvent)
		ifTrue: [ self performEnterAction: anEvent in: aTextEditor ].

	(anEvent isKindOf: BrTextCursorAttributeLeaveEvent)
		ifTrue: [ self performLeaveAction: anEvent in: aTextEditor ]
]

{ #category : #initialization }
BrTextCursorProtoAttribute >> initialize [
	super initialize.

	enterAction := [ :aTextEditor :anEvent :aTextStart :aTextEnd | ].
	leaveAction := [ :aTextEditor :anEvent :aTextStart :aTextEnd | ].
	isInside := nil
]

{ #category : #private }
BrTextCursorProtoAttribute >> performEnterAction: anEvent in: aTextEditor [
	isInside = true
		ifTrue: [ ^ self ].

	isInside := true.
	
	self enterAction gtValueWithArgs: {
		aTextEditor. "then the whole editor element"
		anEvent. "the event itself"
		anEvent attributeStart.
		anEvent attributeEnd }
]

{ #category : #private }
BrTextCursorProtoAttribute >> performLeaveAction: anEvent in: aTextEditor [
	isInside = false
		ifTrue: [ ^ self ].

	isInside := false.

	self leaveAction gtValueWithArgs: {
		aTextEditor. "then the whole editor element"
		anEvent. "the event itself"
		anEvent attributeStart.
		anEvent attributeEnd }
]

{ #category : #events }
BrTextCursorProtoAttribute >> wantsEvent: anEvent [
	"Return true if I am interested in a given event and want to handle it,
	false otherwise"
	<return: #Boolean>

	^ (anEvent isKindOf: BrTextCursorAttributeEnterEvent)
		or: [ anEvent isKindOf: BrTextCursorAttributeLeaveEvent ]
]
