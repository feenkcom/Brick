Class {
	#name : #BrLabelModelExamples,
	#superclass : #Object,
	#traits : 'TBrExamplesUtility',
	#classTraits : 'TBrExamplesUtility classTrait',
	#category : #'Brick-Examples-Label'
}

{ #category : #'example - with element' }
BrLabelModelExamples >> elementWithLabelModel [
	<gtExample>
	<return: #BlElement>
	| anElement aLabelModel |
	aLabelModel := self labelModel.

	anElement := BlElement new.
	anElement viewModel: aLabelModel.	"all event targets where transfered to the element"
	self assertEventTarget: aLabelModel hasNoEventHandlerOn: BrLabelRequest.
	self assertEventTarget: anElement hasEventHandlerOn: BrLabelRequest.

	^ anElement
]

{ #category : #'example - with element' }
BrLabelModelExamples >> elementWithLabelModel_requestElement [
	<gtExample>
	<return: #BlElement>
	| anElement aRequest aResponse aResponseEvent |
	anElement := self elementWithLabelModel.

	anElement when: BrLabelChanged do: [ :anEvent | aResponseEvent := anEvent ].

	anElement dispatchEvent: (aRequest := BrLabelRequest new).
	aResponse := aRequest response.

	self assert: aResponse text asString equals: 'Label'.
	self assert: aResponseEvent text asString equals: 'Label'.

	^ anElement
]

{ #category : #'example - with element' }
BrLabelModelExamples >> elementWithLabelModel_requestElement_oneWay [
	<gtExample>
	<return: #BlElement>
	| anElement aRequest aResponse aResponseEvent |
	anElement := self elementWithLabelModel.

	anElement when: BrLabelChanged do: [ :anEvent | aResponseEvent := anEvent ].

	anElement dispatchEvent: (aRequest := BrLabelRequest new oneWay).
	aResponse := aRequest response.

	self assert: aResponse text asString equals: 'Label'.
	self assert: aResponseEvent isNil.

	^ anElement
]

{ #category : #'example - with element' }
BrLabelModelExamples >> elementWithLabelModel_requestModel [
	<gtExample>
	<return: #BlElement>
	| anElement aLabelModel aResponse aResponseEvent |
	anElement := self elementWithLabelModel.
	aLabelModel := anElement viewModel.

	anElement when: BrLabelChanged do: [ :anEvent | aResponseEvent := anEvent ].

	aResponse := aLabelModel request: BrLabelRequest new.

	self assert: aResponse text asString equals: 'Label'.
	self assert: aResponseEvent text asString equals: 'Label'.

	^ anElement
]

{ #category : #'example - with element' }
BrLabelModelExamples >> elementWithLabelModel_requestModel_oneWay [
	<gtExample>
	<return: #BlElement>
	| anElement aLabelModel aResponse aResponseEvent |
	anElement := self elementWithLabelModel.
	aLabelModel := anElement viewModel.	"when request is one way the changed event is not sent"
	anElement when: BrLabelChanged do: [ :anEvent | aResponseEvent := anEvent ].

	aResponse := aLabelModel request: BrLabelRequest new oneWay.

	self assert: aResponse text asString equals: 'Label'.
	self assert: aResponseEvent isNil.

	^ anElement
]

{ #category : #'example - instance creation' }
BrLabelModelExamples >> labelModel [
	<gtExample>
	<return: #BrLabelModel>
	| aLabelModel |
	aLabelModel := BrLabelModel new.
	self assert: aLabelModel text asString equals: 'Label'.
	self assertEventTarget: aLabelModel hasEventHandlerOn: BrLabelRequest.

	^ aLabelModel
]

{ #category : #'example - instance creation' }
BrLabelModelExamples >> labelModelRequest [
	<gtExample>
	<return: #BrLabelChanged>
	| aLabelModel aResponse |
	aLabelModel := self labelModel.

	aResponse := aLabelModel request: BrLabelRequest new.
	self assert: aResponse text asString equals: 'Label'.

	^ aResponse
]
