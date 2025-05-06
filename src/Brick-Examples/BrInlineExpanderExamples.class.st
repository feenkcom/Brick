Class {
	#name : #BrInlineExpanderExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Triangle'
}

{ #category : #basic }
BrInlineExpanderExamples >> basicExpander [
	<gtExample>
	<return: #BrInlineExpanderElement>
	| aTriangle |
	aTriangle := BrInlineExpanderElement new.
	^ aTriangle
]

{ #category : #glamorous }
BrInlineExpanderExamples >> glamorousInCircle [
	<gtExample>
	<return: #BrInlineExpanderElement>
	| aTriangle |
	aTriangle := self basicExpander.
	aTriangle aptitude: BrGlamorousTriangleInCircleExpanderAptitude.
	^ aTriangle
]

{ #category : #glamorous }
BrInlineExpanderExamples >> glamorousInCircleCollapsed [
	<gtExample>
	<return: #BrInlineExpanderElement>
	| aTriangle |
	aTriangle := self glamorousInCircleExpanded.
	aTriangle collapse.
	self assert: aTriangle isCollapsed.
	^ aTriangle
]

{ #category : #glamorous }
BrInlineExpanderExamples >> glamorousInCircleDisabled [
	<gtExample>
	<return: #BrInlineExpanderElement>
	| aTriangle |
	aTriangle := self glamorousInCircle.
	aTriangle aptitude: BrGlamorousTriangleInCircleExpanderAptitude.
	aTriangle disable.
	self assert: aTriangle isDisabled.
	^ aTriangle
]

{ #category : #glamorous }
BrInlineExpanderExamples >> glamorousInCircleExpanded [
	<gtExample>
	<return: #BrInlineExpanderElement>
	| aTriangle |
	aTriangle := self glamorousInCircle.
	aTriangle expand.
	self assert: aTriangle isExpanded.
	^ aTriangle
]

{ #category : #glamorous }
BrInlineExpanderExamples >> glamorousInCircleHidden [
	<gtExample>
	<return: #BrInlineExpanderElement>
	| aTriangle |
	aTriangle := self glamorousInCircle.
	aTriangle hide.
	^ aTriangle
]

{ #category : #glamorous }
BrInlineExpanderExamples >> glamorousInCircleVisible [
	<gtExample>
	<return: #BrInlineExpanderElement>
	| aTriangle |
	aTriangle := self glamorousInCircleHidden.
	aTriangle show.
	^ aTriangle
]

{ #category : #glamorous }
BrInlineExpanderExamples >> glamorousInCircleWithAction [
	<gtExample>
	<return: #BrInlineExpanderElement>
	| aTriangle theActions |
	theActions := OrderedCollection new.

	aTriangle := self glamorousInCircle.
	aTriangle toggleAction: [ :aButton | theActions add: aButton isExpanded ].

	BlSpace simulateClickOn: aTriangle.

	self assert: aTriangle isExpanded description: 'Triangle must be expanded'.
	self assert: theActions size equals: 1.
	self assert: theActions first description: 'Triangle action must be expanded'.

	aTriangle userData at: #example put: theActions.

	^ aTriangle
]

{ #category : #basic }
BrInlineExpanderExamples >> triangle [
	<gtExample>
	<return: #BrInlineExpanderElement>
	| aTriangle |
	aTriangle := self basicExpander.
	aTriangle aptitude: BrTriangleExpanderAptitude.
	^ aTriangle
]
