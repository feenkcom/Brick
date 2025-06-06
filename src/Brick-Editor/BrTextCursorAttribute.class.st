"
# Cursor attribute
Allows users to react to the cursor movement within the editor. 
{{gtExample:BrTextCursorAttributeExamples>>#changingForeground|previewExpanded=true|previewShow=#gtTextFor:|previewHeight=100}}

"
Class {
	#name : #BrTextCursorAttribute,
	#superclass : #BrTextEventHandlerAttribute,
	#instVars : [
		'enterAction',
		'leaveAction',
		'isInside'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #accessing }
BrTextCursorAttribute >> enterAction [
	^ enterAction
]

{ #category : #accessing }
BrTextCursorAttribute >> enterAction: aBlock [
	"A Block in a form [ :aTextEditor :anEvent :aTextStart :aTextEnd | ]"
	self 
		assert: [ aBlock notNil ] 
		description: [ 'Leave action should be initialized' ].
	
	enterAction := aBlock
]

{ #category : #events }
BrTextCursorAttribute >> handleEvent: anEvent in: aTextEditor on: aTBrTextEditorTextualPiece [
	"Handle a given event or dispatch it using #sendTo:"

	(anEvent isKindOf: BrTextCursorAttributeEnterEvent)
		ifTrue: [ self performEnterAction: anEvent in: aTextEditor ].

	(anEvent isKindOf: BrTextCursorAttributeLeaveEvent)
		ifTrue: [ self performLeaveAction: anEvent in: aTextEditor ]
]

{ #category : #initialization }
BrTextCursorAttribute >> initialize [
	super initialize.

	enterAction := [ :aTextEditor :anEvent :aTextStart :aTextEnd | ].
	leaveAction := [ :aTextEditor :anEvent :aTextStart :aTextEnd | ].
	isInside := nil
]

{ #category : #accessing }
BrTextCursorAttribute >> leaveAction [
	^ leaveAction
]

{ #category : #accessing }
BrTextCursorAttribute >> leaveAction: aBlock [
	"A Block in a form [ :aTextEditor :anEvent :aTextStart :aTextEnd | ]"
	self 
		assert: [ aBlock notNil ] 
		description: [ 'Leave action should be initialized' ].

	leaveAction := aBlock
]

{ #category : #private }
BrTextCursorAttribute >> performEnterAction: anEvent in: aTextEditor [
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
BrTextCursorAttribute >> performLeaveAction: anEvent in: aTextEditor [
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
BrTextCursorAttribute >> wantsEvent: anEvent [
	"Return true if I am interested in a given event and want to handle it,
	false otherwise"
	<return: #Boolean>

	^ (anEvent isKindOf: BrTextCursorAttributeEnterEvent)
		or: [ anEvent isKindOf: BrTextCursorAttributeLeaveEvent ]
]
