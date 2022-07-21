Class {
	#name : #BrGroupedListHeaderElementStencilRequest,
	#superclass : #BrRequest,
	#category : #'Brick-List-Grouped-Events'
}

{ #category : #initialization }
BrGroupedListHeaderElementStencilRequest >> responseClass [
	^ BrGroupedListHeaderElementStencilChangedEvent
]
