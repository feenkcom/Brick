Class {
	#name : #BrAnchoredStrategy,
	#superclass : #Object,
	#category : #'Brick-Anchored - Support'
}

{ #category : #accessing }
BrAnchoredStrategy >> availableBoundsIn: aReferenceElement forPreferredExtent: aPoint [
	self subclassResponsibility
]

{ #category : #'gt - extensions' }
BrAnchoredStrategy >> gtConfigurePreferredExtentPreviewElement: anElement [
	"do nothing"
]

{ #category : #'gt - extensions' }
BrAnchoredStrategy >> gtStrategiesNameText [
	^ self printString
]

{ #category : #accessing }
BrAnchoredStrategy >> invalidate: anElement forPreferredExtent: aPoint [
	self subclassResponsibility
]
