Class {
	#name : #BrInteractiveModelExamples,
	#superclass : #Object,
	#traits : 'TBrExamplesUtility',
	#classTraits : 'TBrExamplesUtility classTrait',
	#category : #'Brick-Examples-! Model - Interactive'
}

{ #category : #'examples - instance creation' }
BrInteractiveModelExamples >> default [
	<gtExample>
	<return: #BrInteractiveModel>
	| anInteractiveModel |
	anInteractiveModel := BrInteractiveModel new.

	self
		assertEventTarget: anInteractiveModel
		hasEventHandlerOn: BrInteractionRequest.
	self assert: anInteractiveModel stateModels isEmpty.

	^ anInteractiveModel
]

{ #category : #'examples - activation' }
BrInteractiveModelExamples >> withEnablement [
	<gtExample>
	<return: #BrInteractiveModel>
	| anInteractiveModel anActivationModel |
	anActivationModel := BrEnablementModel new.

	anInteractiveModel := self default.
	anInteractiveModel addState: anActivationModel.

	^ anInteractiveModel
]
