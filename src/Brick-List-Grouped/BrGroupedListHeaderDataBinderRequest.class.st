Class {
	#name : #BrGroupedListHeaderDataBinderRequest,
	#superclass : #BrRequest,
	#category : #'Brick-List-Grouped-Events'
}

{ #category : #initialization }
BrGroupedListHeaderDataBinderRequest >> responseClass [
	^ BrGroupedListHeaderDataBinderChangedEvent
]
