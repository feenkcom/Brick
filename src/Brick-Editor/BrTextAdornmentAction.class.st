Class {
	#name : #BrTextAdornmentAction,
	#superclass : #Object,
	#category : #'Brick-Editor-Attributes'
}

{ #category : #'api - action' }
BrTextAdornmentAction >> executeOnEditorElement: anEditorElement fromAdornmentAttribute: anAdornmentAttribute [
	self subclassResponsibility
]
