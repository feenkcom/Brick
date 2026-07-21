"
# Cursor attribute
Allows users to react to the cursor movement within the editor. 
{{gtExample:BrTextCursorAttributeExamples>>#changingForeground|previewExpanded=true|previewShow=#gtTextFor:|previewHeight=100}}

"
Class {
	#name : #BrTextCursorDynamicAttribute,
	#superclass : #BrTextCursorProtoAttribute,
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
