Class {
	#name : #BrEditorRequest,
	#superclass : #BrRequest,
	#category : #'Brick-Editor - Events'
}

{ #category : #initialization }
BrEditorRequest >> initialize [
	super initialize.
	
	canBePropagated := false
]
