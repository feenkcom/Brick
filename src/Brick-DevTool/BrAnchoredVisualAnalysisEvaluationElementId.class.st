Class {
	#name : #BrAnchoredVisualAnalysisEvaluationElementId,
	#superclass : #BlElementId,
	#instVars : [
		'evaluation'
	],
	#category : #'Brick-DevTool-Anchored'
}

{ #category : #comparing }
BrAnchoredVisualAnalysisEvaluationElementId >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].

	self class = anObject class
		ifFalse: [ ^ false ].

	^ self evaluation = anObject evaluation
]

{ #category : #converting }
BrAnchoredVisualAnalysisEvaluationElementId >> asSymbol [
	^ #'anchored--strategy-evaluation-', self name
]

{ #category : #accessing }
BrAnchoredVisualAnalysisEvaluationElementId >> evaluation [
	^ evaluation
]

{ #category : #accessing }
BrAnchoredVisualAnalysisEvaluationElementId >> evaluation: anObject [
	evaluation := anObject
]

{ #category : #comparing }
BrAnchoredVisualAnalysisEvaluationElementId >> hash [
	^ self evaluation hash
]

{ #category : #accessing }
BrAnchoredVisualAnalysisEvaluationElementId >> name [
	^ self evaluation ifNotNil: #name ifNil: [ '?' ]
]
