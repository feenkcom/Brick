Class {
	#name : #BrTextHoverProtoAttribute,
	#superclass : #BrTextEventHandlerAttribute,
	#instVars : [
		'enterAction',
		'leaveAction',
		'isHovered'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #views }
BrTextHoverProtoAttribute >> gtEnterActionFor: aView [
	<gtView>
	^ aView forward
		title: 'Enter action';
		priority: 10;
		object: [ enterAction ];
		view: #gtSourceCodeFor:
]

{ #category : #views }
BrTextHoverProtoAttribute >> gtLeaveActionFor: aView [
	<gtView>
	^ aView forward
		title: 'Leave action';
		priority: 11;
		object: [ leaveAction ];
		view: #gtSourceCodeFor:
]

{ #category : #events }
BrTextHoverProtoAttribute >> handleEvent: anEvent in: aTextEditor on: aTBrTextEditorTextualPiece [
	"Handle a given event or dispatch it using #sendTo:"

	(anEvent isKindOf: BlMouseMoveEvent)
		ifTrue: [ self performMoveAction: anEvent in: aTextEditor ].

	(anEvent isKindOf: BlMouseLeaveEvent)
		ifTrue: [ self performLeaveAction: anEvent in: aTextEditor ].
]

{ #category : #initialization }
BrTextHoverProtoAttribute >> initialize [
	super initialize.

	enterAction := [ :aText :aTextElement :aTextEditor :anEvent | ].
	leaveAction := [ :aText :aTextElement :aTextEditor :anEvent | ].
	isHovered := false
]

{ #category : #private }
BrTextHoverProtoAttribute >> performEnterAction: anEvent in: aTextEditor [
	isHovered ifTrue: [ ^ self ].

	isHovered := true.

	anEvent currentTarget text
		findAttribute: self
		indicesDo: [ :st :nd | 
			enterAction
				gtValueWithArgs: {anEvent currentTarget text from: st to: nd.
						anEvent currentTarget.
						aTextEditor.
						anEvent} ]
]

{ #category : #private }
BrTextHoverProtoAttribute >> performLeaveAction: anEvent in: aTextEditor [	
	isHovered
		ifFalse: [ ^ self ].

	isHovered := false.
	
	anEvent currentTarget text
		findAttribute: self
		indicesDo: [ :st :nd | 
			leaveAction
				gtValueWithArgs: {
						anEvent currentTarget text from: st to: nd. "first we pass text"
						anEvent currentTarget. "then the text piece (word) element"
						aTextEditor. "then the whole editor element"
						anEvent} "the event itself" ]
]

{ #category : #events }
BrTextHoverProtoAttribute >> performMoveAction: anEvent in: aTextEditor [
	self performEnterAction: anEvent in: aTextEditor
]

{ #category : #events }
BrTextHoverProtoAttribute >> wantsEvent: anEvent [
	"Return true if I am interested in a given event and want to handle it,
	false otherwise"
	<return: #Boolean>

	^ (anEvent isKindOf: BlMouseMoveEvent)
		or: [ anEvent isKindOf: BlMouseLeaveEvent ]
]
