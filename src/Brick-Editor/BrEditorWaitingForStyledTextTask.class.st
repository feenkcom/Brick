Class {
	#name : #BrEditorWaitingForStyledTextTask,
	#superclass : #BlTask,
	#instVars : [
		'isStyling'
	],
	#category : #'Brick-Editor-Styler'
}

{ #category : #initialization }
BrEditorWaitingForStyledTextTask >> initialize [
	super initialize.
	
	isStyling := true
]

{ #category : #'api - running' }
BrEditorWaitingForStyledTextTask >> markAsFinished [
	isStyling := false
]

{ #category : #'api - running' }
BrEditorWaitingForStyledTextTask >> requeueTaskAfterExecution [
	"Answer a boolean indicating whether the receiver should be requeued after execution."

	^ isStyling
]

{ #category : #'api - running' }
BrEditorWaitingForStyledTextTask >> run [
]
