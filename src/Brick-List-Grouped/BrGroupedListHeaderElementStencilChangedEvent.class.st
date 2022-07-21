Class {
	#name : #BrGroupedListHeaderElementStencilChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'headerElementStencil'
	],
	#category : #'Brick-List-Grouped-Events'
}

{ #category : #accessing }
BrGroupedListHeaderElementStencilChangedEvent >> headerElementStencil [
	^ headerElementStencil
]

{ #category : #accessing }
BrGroupedListHeaderElementStencilChangedEvent >> headerElementStencil: anObject [
	headerElementStencil := anObject
]
