Class {
	#name : #BrListItemDataBinderRequest,
	#superclass : #BrRequest,
	#category : #'Brick-List-Ungrouped-Events'
}

{ #category : #initialization }
BrListItemDataBinderRequest >> responseClass [
	^ BrListItemDataBinderChangedEvent
]
