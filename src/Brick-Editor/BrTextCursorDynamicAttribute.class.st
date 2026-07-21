"
# Cursor attribute
Allows users to react to the cursor movement within the editor. 
{{gtExample:BrTextCursorAttributeExamples>>#changingForeground|previewExpanded=true|previewShow=#gtTextFor:|previewHeight=100}}

"
Class {
	#name : #BrTextCursorDynamicAttribute,
	#superclass : #BrTextCursorProtoAttribute,
	#instVars : [
		'enterAction',
		'leaveAction'
	],
	#category : 'Brick-Editor-Attributes'
}

{ #category : #accessing }
BrTextCursorDynamicAttribute >> enterAction [
	^ enterAction
]

{ #category : #accessing }
BrTextCursorDynamicAttribute >> enterAction: aBlock [
	"A Block in a form [ :aTextEditor :anEvent :aTextStart :aTextEnd | ]"
	self 
		assert: [ aBlock notNil ] 
		description: [ 'Leave action should be initialized' ].
	
	enterAction := aBlock
]

{ #category : #'as yet unclassified' }
BrTextCursorDynamicAttribute >> initialize [
	super initialize.

	enterAction := [ :aTextEditor :anEvent :aTextStart :aTextEnd | ].
	leaveAction := [ :aTextEditor :anEvent :aTextStart :aTextEnd | ].
]

{ #category : #accessing }
BrTextCursorDynamicAttribute >> leaveAction [
	^ leaveAction
]

{ #category : #accessing }
BrTextCursorDynamicAttribute >> leaveAction: aBlock [
	"A Block in a form [ :aTextEditor :anEvent :aTextStart :aTextEnd | ]"
	self 
		assert: [ aBlock notNil ] 
		description: [ 'Leave action should be initialized' ].

	leaveAction := aBlock
]

{ #category : #private }
BrTextCursorDynamicAttribute >> performEnterAction: anEvent in: aTextEditor [
	isInside = true
		ifTrue: [ ^ self ].

	isInside := true.
	
	enterAction gtValueWithArgs: {
		aTextEditor. "then the whole editor element"
		anEvent. "the event itself"
		anEvent attributeStart.
		anEvent attributeEnd }
]

{ #category : #private }
BrTextCursorDynamicAttribute >> performLeaveAction: anEvent in: aTextEditor [
	isInside = false
		ifTrue: [ ^ self ].

	isInside := false.

	leaveAction gtValueWithArgs: {
		aTextEditor. "then the whole editor element"
		anEvent. "the event itself"
		anEvent attributeStart.
		anEvent attributeEnd }
]
