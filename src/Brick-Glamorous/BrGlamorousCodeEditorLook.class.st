Class {
	#name : #BrGlamorousCodeEditorLook,
	#superclass : #BrGlamorousEditorLook,
	#category : #'Brick-Glamorous-Editor'
}

{ #category : #initialization }
BrGlamorousCodeEditorLook >> initialize [
	super initialize.
	self 
		glamorousCodeFont;
		fontSize: 1 fontEm
]
