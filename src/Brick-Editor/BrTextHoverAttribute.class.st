Class {
	#name : #BrTextHoverAttribute,
	#superclass : #BrTextEventHandlerAttribute,
	#instVars : [
		'enterAction',
		'leaveAction',
		'isHovered'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #accessing }
BrTextHoverAttribute >> enterAction [
	^ enterAction
]

{ #category : #accessing }
BrTextHoverAttribute >> enterAction: anObject [
	enterAction := anObject
]

{ #category : #events }
BrTextHoverAttribute >> handleEvent: anEvent in: aTextEditor on: aTBrTextEditorTextualPiece [
	"Handle a given event or dispatch it using #sendTo:"

	(anEvent isKindOf: BlMouseMoveEvent)
		ifTrue: [ self performMoveAction: anEvent in: aTextEditor ].

	(anEvent isKindOf: BlMouseLeaveEvent)
		ifTrue: [ self performLeaveAction: anEvent in: aTextEditor ].
]

{ #category : #initialization }
BrTextHoverAttribute >> initialize [
	super initialize.

	enterAction := [ :aText :aTextElement :aTextEditor :anEvent | ].
	leaveAction := [ :aText :aTextElement :aTextEditor :anEvent | ].
	isHovered := false
]

{ #category : #accessing }
BrTextHoverAttribute >> leaveAction [
	^ leaveAction
]

{ #category : #accessing }
BrTextHoverAttribute >> leaveAction: aBlock [
	self 
		assert: [ aBlock notNil ] 
		description: [ 'Leave action should be initialized' ].

	leaveAction := aBlock
]

{ #category : #private }
BrTextHoverAttribute >> performEnterAction: anEvent in: aTextEditor [
	isHovered ifTrue: [ ^ self ].

	isHovered := true.

	anEvent currentTarget text
		findAttribute: self
		indicesDo: [ :st :nd | 
			self enterAction
				gtValueWithArgs: {anEvent currentTarget text from: st to: nd.
						anEvent currentTarget.
						aTextEditor.
						anEvent} ]
]

{ #category : #private }
BrTextHoverAttribute >> performLeaveAction: anEvent in: aTextEditor [	
	isHovered
		ifFalse: [ ^ self ].

	isHovered := false.
	
	anEvent currentTarget text
		findAttribute: self
		indicesDo: [ :st :nd | 
			self leaveAction
				gtValueWithArgs: {
						anEvent currentTarget text from: st to: nd. "first we pass text"
						anEvent currentTarget. "then the text piece (word) element"
						aTextEditor. "then the whole editor element"
						anEvent} "the event itself" ]
]

{ #category : #events }
BrTextHoverAttribute >> performMoveAction: anEvent in: aTextEditor [
	self performEnterAction: anEvent in: aTextEditor
]

{ #category : #events }
BrTextHoverAttribute >> wantsEvent: anEvent [
	"Return true if I am interested in a given event and want to handle it,
	false otherwise"
	<return: #Boolean>

	^ (anEvent isKindOf: BlMouseMoveEvent)
		or: [ anEvent isKindOf: BlMouseLeaveEvent ]
]
