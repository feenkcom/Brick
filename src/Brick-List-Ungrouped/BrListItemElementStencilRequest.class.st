Class {
	#name : #BrListItemElementStencilRequest,
	#superclass : #BrRequest,
	#category : #'Brick-List-Ungrouped-Events'
}

{ #category : #initialization }
BrListItemElementStencilRequest >> responseClass [
	^ BrListItemElementStencilChangedEvent
]
