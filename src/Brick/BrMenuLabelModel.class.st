Class {
	#name : #BrMenuLabelModel,
	#superclass : #Object,
	#category : #'Brick-Menu - Model'
}

{ #category : #visiting }
BrMenuLabelModel >> acceptVisitor: aVisitor [
	^ aVisitor visitMenuLabelModel: self
]

{ #category : #accessing }
BrMenuLabelModel >> id [
	"Compatibility with menu model.
	It may happen if BrMenuInvalidItemElement is used."

	^ nil
]
