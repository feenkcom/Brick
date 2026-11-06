Class {
	#name : #BrToggle,
	#superclass : #BrAbstractToggle,
	#instVars : [
		'labelModel',
		'iconModel'
	],
	#category : #'Brick-Toggle - UI'
}

{ #category : #'api - widget' }
BrToggle >> icon [
	<return: #BlElement>

	^ iconModel icon
]

{ #category : #'api - widget' }
BrToggle >> icon: anElement [
	iconModel icon: anElement
]

{ #category : #initialization }
BrToggle >> initialize [
	super initialize.
	self hFitContent.
	self viewModel
		add: (labelModel := BrLabelModel new);
		add: (iconModel := BrIconModel new)
]

{ #category : #'api - widget' }
BrToggle >> label [
	<return: #BlText>

	^ labelModel text
]

{ #category : #'api - widget' }
BrToggle >> label: aStringOrBrText [
	labelModel text: aStringOrBrText
]
