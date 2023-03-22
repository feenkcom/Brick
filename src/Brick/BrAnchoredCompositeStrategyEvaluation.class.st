"
I am a result of an {{gtClass: BrAnchoredSingleStrategy}} evaluation.
I am created and used by {{gtClass: BrAnchoredCompositeStrategyFinder}}. 

"
Class {
	#name : #BrAnchoredCompositeStrategyEvaluation,
	#superclass : #Object,
	#instVars : [
		'strategy',
		'bounds',
		'rectangle',
		'isAppropriate'
	],
	#category : #'Brick-Anchored - Support'
}

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> bounds [
	^ bounds
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> bounds: anObject [
	bounds := anObject
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> extent [
	^ self bounds extent
]

{ #category : #'gt - extensions' }
BrAnchoredCompositeStrategyEvaluation >> gtStrategiesNameText [
	^ self strategy gtStrategiesNameText
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> isAppropriate [
	^ isAppropriate
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> isAppropriate: anObject [
	isAppropriate := anObject
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> rectangle [
	^ rectangle
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> rectangle: anObject [
	rectangle := anObject
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> strategy [
	^ strategy
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> strategy: anObject [
	strategy := anObject
]
