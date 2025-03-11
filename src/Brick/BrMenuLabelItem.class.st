Class {
	#name : #BrMenuLabelItem,
	#superclass : #BrMenuLabeledItem,
	#category : #'Brick-Menu - Model'
}

{ #category : #visiting }
BrMenuLabelItem >> acceptVisitor: aVisitor [
	^ aVisitor visitMenuLabelItem: self
]
