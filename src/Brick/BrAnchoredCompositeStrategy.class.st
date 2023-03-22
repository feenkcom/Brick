Class {
	#name : #BrAnchoredCompositeStrategy,
	#superclass : #BrAnchoredStrategy,
	#instVars : [
		'strategies'
	],
	#category : #'Brick-Anchored - Support'
}

{ #category : #accessing }
BrAnchoredCompositeStrategy class >> builder [
	^ BrAnchoredCompositeStrategyBuilder new
]

{ #category : #'as yet unclassified' }
BrAnchoredCompositeStrategy class >> strategies: anOrderedCollection [
	^ self new
		initializeStrategies: anOrderedCollection;
		yourself
]

{ #category : #accessing }
BrAnchoredCompositeStrategy >> availableBoundsIn: aReferenceElement forPreferredExtent: aPoint [
	^ (self strategyIn: aReferenceElement forPreferredExtent: aPoint)
		availableBoundsIn: aReferenceElement
		forPreferredExtent: aPoint
]

{ #category : #'private - finding' }
BrAnchoredCompositeStrategy >> finderWithElement: aReferenceElement andPreferredExtent: aPreferredExtent [
	^ BrAnchoredCompositeStrategyFinder new 
		strategies: strategies;
		referenceElement: aReferenceElement;
		preferredExtent: aPreferredExtent
]

{ #category : #initialization }
BrAnchoredCompositeStrategy >> initializeStrategies: anOrderedCollection [
	self assert: [ strategies isNil ].
	self assert: [ anOrderedCollection isNotEmpty ].
	strategies := anOrderedCollection
]

{ #category : #accessing }
BrAnchoredCompositeStrategy >> invalidate: anElement forPreferredExtent: aPoint [
	(self strategyIn: anElement parent forPreferredExtent: aPoint)
		invalidate: anElement
		forPreferredExtent: aPoint
]

{ #category : #'private - finding' }
BrAnchoredCompositeStrategy >> strategyIn: aReferenceElement forPreferredExtent: aPreferredExtent [
	^ (self
		finderWithElement: aReferenceElement
		andPreferredExtent: aPreferredExtent) 
			find
]
