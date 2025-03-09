Class {
	#name : #BrMenuIconTextLabelModel,
	#superclass : #BrMenuTextLabelModel,
	#instVars : [
		'icon'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #visiting }
BrMenuIconTextLabelModel >> acceptVisitor: aVisitor [
	^ aVisitor visitMenuIconTextLabelModel: self
]

{ #category : #accessing }
BrMenuIconTextLabelModel >> icon [
	<return: #BrStencil>
	^ icon
]

{ #category : #accessing }
BrMenuIconTextLabelModel >> icon: aStencil [
	icon := aStencil
]
