"
# Button model examples

{{gtClass:BrButtonModel}} is one of the most essential parts of the brick. It allows users to create clickable widgets and attach a custom action that will be executed on {{gtClass:BlClickEvent}}.

By default {{gtClass:BrButtonModel}} has an empty action that does nothing:
{{gtExample:BrButtonModelExamples>>#default|expanded=true|noCode|previewShow=#gtActionFor:|previewHeight=100}}

Every button model creates a corresponding event handler that responds to {{gtClass:BlClickEvent}}:
{{gtExample:BrButtonModelExamples>>#default|expanded=true|noCode|previewShow=#gtHandlersFor:|previewHeight=50}}

The following example shows how to create a new button model and attach an action. In this particular case we set `#clicked` as an inner domain model to be able to assert that the action  was indeed executed and also inform users about it:

{{gtExample:BrButtonModelExamples>>#buttonModelWithAction}}

The instantiated button model can be attached to any visual {{gtClass:BlElement}} as its view model. Once attached, the visual element becomes clickable, as the following example shows:
{{gtExample:BrButtonModelExamples>>#elementWithButtonModel|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=70}}

To test the behaviour of the button model we can simulate a click on the element with attached button model and make sure that the action was performed:
{{gtExample:BrButtonModelExamples>>#clickOnElementWithButtonModel}}

"
Class {
	#name : #BrButtonModelExamples,
	#superclass : #Object,
	#traits : 'TBrExamplesUtility',
	#classTraits : 'TBrExamplesUtility classTrait',
	#category : #'Brick-Examples-Button'
}

{ #category : #'examples - model' }
BrButtonModelExamples >> buttonModelWithAction [
	<gtExample>
	<return: #BrButtonModel>
	^ self default
		action: [ :aButtonElement :aButtonModel | 
			aButtonModel model: #clicked.
			self inform: 'clicked' ]
]

{ #category : #'examples - with element' }
BrButtonModelExamples >> clickOnElementWithButtonModel [
	<gtExample>
	<return: #BlElement>
	| anElement |
	anElement := self elementWithButtonModel.
	BlSpace simulateClickOn: anElement.

	self assert: anElement viewModel model equals: #clicked.

	^ anElement
]

{ #category : #'examples - model' }
BrButtonModelExamples >> default [
	<gtExample>
	<return: #BrButtonModel>
	| aButtonModel |
	aButtonModel := BrButtonModel new.

	self assertEventTarget: aButtonModel hasEventHandlerOn: BlClickEvent.
	self assert: aButtonModel isAttachedToWidget not.
	self assert: aButtonModel widgetModels isEmpty.

	^ aButtonModel
]

{ #category : #'examples - with element' }
BrButtonModelExamples >> elementWithButtonModel [
	<gtExample>
	<return: #BlElement>
	| anElement aButtonModel |
	aButtonModel := self buttonModelWithAction.

	anElement := BlElement new
			size: 60 @ 30;
			background: Color veryLightGray.

	self assertEventTarget: anElement hasNoEventHandlerOn: BlClickEvent.

	anElement viewModel: aButtonModel.

	self assertEventTarget: aButtonModel hasNoEventHandlerOn: BlClickEvent.
	self assertEventTarget: anElement hasEventHandlerOn: BlClickEvent.

	^ anElement
]
