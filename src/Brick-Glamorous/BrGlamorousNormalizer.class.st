"
I am an abstract superclass for several classes that can ""normalize"" values to fall within a certain range.
The target range may be an explicit set of values (`BrIdentityNormalizer`), a numeric range (`BrNumberLinearNormalizer`), or a set of colours (`BrColorLinearNormalizer`).
There are numerous examples in `BrNormalizerExamples`, for example:

{{gtMethod:name=BrNormalizerExamples>>#numberLinearNormalizer}}


"
Class {
	#name : #BrGlamorousNormalizer,
	#superclass : #Object,
	#instVars : [
		'command'
	],
	#category : #'Brick-Glamorous-Normalizer'
}

{ #category : #accessing }
BrGlamorousNormalizer >> command [
	
	^command
]

{ #category : #accessing }
BrGlamorousNormalizer >> command: aBlock [
	
	command := aBlock
]

{ #category : #accessing }
BrGlamorousNormalizer >> cull: anEntity [
	^ self value: anEntity
]

{ #category : #accessing }
BrGlamorousNormalizer >> value: anEntity [
	
	self subclassResponsibility
]
