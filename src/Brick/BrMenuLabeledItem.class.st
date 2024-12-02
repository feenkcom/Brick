Class {
	#name : #BrMenuLabeledItem,
	#superclass : #BrMenuItem,
	#traits : 'TBrMenuWithTextLabelModel',
	#classTraits : 'TBrMenuWithTextLabelModel classTrait',
	#category : #'Brick-Menu - Model'
}

{ #category : #testing }
BrMenuLabeledItem class >> isAbstract [
	^ self name = #BrMenuLabeledItem
]

{ #category : #initialization }
BrMenuLabeledItem >> initialize [
	super initialize.
	self initializeLabelModel
]
