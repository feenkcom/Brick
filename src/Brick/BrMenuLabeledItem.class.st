Class {
	#name : #BrMenuLabeledItem,
	#superclass : #BrMenuItem,
	#traits : 'TBrMenuWithLabelModel',
	#classTraits : 'TBrMenuWithLabelModel classTrait',
	#category : #'Brick-Menu - Model'
}

{ #category : #testing }
BrMenuLabeledItem class >> isAbstract [
	^ self name = #BrMenuLabeledItem
]

{ #category : #visiting }
BrMenuLabeledItem >> acceptVisitor: aVisitor [
	^ aVisitor visitMenuLabeledItem: self
]

{ #category : #initialization }
BrMenuLabeledItem >> initialize [
	super initialize.
	self initializeLabelModel
]
