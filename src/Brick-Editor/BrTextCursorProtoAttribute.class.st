Class {
	#name : #BrTextCursorProtoAttribute,
	#superclass : #BrTextEventHandlerAttribute,
	#instVars : [
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

	isInside := nil
]

{ #category : #private }
BrTextCursorProtoAttribute >> performEnterAction: anEvent in: aTextEditor [
	self subclassResponsibility
]

{ #category : #private }
BrTextCursorProtoAttribute >> performLeaveAction: anEvent in: aTextEditor [
	self subclassResponsibility
]

{ #category : #events }
BrTextCursorProtoAttribute >> wantsEvent: anEvent [
	"Return true if I am interested in a given event and want to handle it,
	false otherwise"
	<return: #Boolean>

	^ (anEvent isKindOf: BrTextCursorAttributeEnterEvent)
		or: [ anEvent isKindOf: BrTextCursorAttributeLeaveEvent ]
]
