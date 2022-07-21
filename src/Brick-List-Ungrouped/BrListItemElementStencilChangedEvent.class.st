Class {
	#name : #BrListItemElementStencilChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'itemElementStencil'
	],
	#category : #'Brick-List-Ungrouped-Events'
}

{ #category : #accessing }
BrListItemElementStencilChangedEvent >> itemElementStencil [
	^ itemElementStencil
]

{ #category : #accessing }
BrListItemElementStencilChangedEvent >> itemElementStencil: anObject [
	itemElementStencil := anObject
]
