Class {
	#name : #BrNormalizerExamples,
	#superclass : #Object,
	#category : #'Brick-Glamorous-Normalizer'
}

{ #category : #'explicit identity' }
BrNormalizerExamples >> explicitIdentity [
	<gtExample>
	<return: #BrExplicitIdentityNormalizer>
	| normalizer colors |
	colors := Array
			with: Color blue
			with: Color white
			with: Color red.
	normalizer := BrExplicitIdentityNormalizer
			withCommand: #yourself
			withColors: colors
			withDefaultColor: Color green.

	self assert: (normalizer value: 1) = Color blue.
	self assert: (normalizer value: 2) = Color white.
	self assert: (normalizer value: 3) = Color red.
	self assert: (normalizer value: 4) = Color green.
	^ normalizer
]

{ #category : #tests }
BrNormalizerExamples >> explicitIdentityWithNumbers [
	<gtExample>
	<return: #BrExplicitIdentityNormalizer>
	| normalizer |
	normalizer := BrExplicitIdentityNormalizer
			withCommand: #yourself
			withColors: (Array
					with: Color blue
					with: Color white
					with: Color red)
			withDefaultColor: Color green.

	self assert: (normalizer value: 1) = Color blue.
	self assert: (normalizer value: 2) = Color white.
	self assert: (normalizer value: 3) = Color red.
	self assert: (normalizer value: -1) = Color green.
	self assert: (normalizer value: 1000) = Color green.
	^ normalizer
]

{ #category : #linear }
BrNormalizerExamples >> gradient [
	<gtExample>
	<return: #BrColorLinearNormalizer>
	| normalizer |
	normalizer := BrColorLinearNormalizer
			inContext: #(0 1 2 3 4 5 6 7 8 9 10)
			lowColor: Color yellow
			highColor: Color red.
	self
		assert: (normalizer value: 10)
				= (Color
						r: 1.0
						g: 0.0
						b: 0.0).
	self
		assert: (normalizer value: 1)
				= (Color
						r: 1.0
						g: 0.900012
						b: 0.0).
	self
		assert: (normalizer value: 0)
				= (Color
						r: 1.0
						g: 1.0
						b: 0.0).
	^ normalizer
]

{ #category : #identity }
BrNormalizerExamples >> identity [
	<gtExample>
	<return: #BrIdentityNormalizer>
	| colorOne colorTwo normalizer |
	normalizer := BrIdentityNormalizer new.
	colorOne := normalizer value: 1.
	colorTwo := normalizer value: 2.
	self assert: colorOne ~= colorTwo.

	colorOne := normalizer value: 12.
	colorTwo := normalizer value: 12.
	self assert: colorOne = colorTwo.
	^ normalizer
]

{ #category : #identity }
BrNormalizerExamples >> identityWithCommand [
	<gtExample>
	<return: #BrNormalizerExamples>
	| colorOne colorTwo normalizer |
	normalizer := BrIdentityNormalizer withCommand: #last.
	colorOne := normalizer value: 'bob'.
	colorTwo := normalizer value: 'tom'.
	self assert: colorOne ~= colorTwo.

	colorOne := normalizer value: 'anna'.
	colorTwo := normalizer value: 'maria'.
	self assert: colorOne = colorTwo
]

{ #category : #identity }
BrNormalizerExamples >> identityWithMoreObjectsThanColors [
	<gtExample>
	<return: #BrNormalizerExamples>
	1 to: 150 do: [ :index | BrIdentityNormalizer new value: index ]
]

{ #category : #multiple }
BrNormalizerExamples >> multipleLinearNormalizer [
	<gtExample>
	<return: #BrMultipleColorLinearNormalizer>
	| normalizer |
	normalizer := BrMultipleColorLinearNormalizer
			valueRange: #(5 10 15)
			colorRange: (Array
					with: Color blue
					with: Color white
					with: Color red).
	self
		assert: (normalizer value: 5)
				= (Color
						r: 0.0
						g: 0.0
						b: 1.0).
	self
		assert: (normalizer value: 6)
				= (Color
						r: 0.2
						g: 0.2
						b: 1.0).
	self
		assert: (normalizer value: 15)
				= (Color
						r: 1.0
						g: 0.0
						b: 0.0).
	^ normalizer
]

{ #category : #linear }
BrNormalizerExamples >> numberLinearNormalizer [
	<gtExample>
	<return: #BrNormalizerExamples>
	| normalizer |
	normalizer := BrNumberLinearNormalizer
			inContext: (1 to: 10)
			withCommand: [ :entity | entity * 1000 ].
	self assert: (normalizer value: 100) = 10.

	normalizer := BrNumberLinearNormalizer
			inContext: (1 to: 100)
			withCommand: [ :entity | entity * 1000 ].
	self assert: (normalizer value: 100) = 1.

	normalizer := BrNumberLinearNormalizer
			inContext: (1 to: 100)
			withCommand: [ :entity | entity ].
	self assert: (normalizer value: 100) = 1
]
