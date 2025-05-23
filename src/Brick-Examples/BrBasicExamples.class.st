Class {
	#name : #BrBasicExamples,
	#superclass : #Object,
	#category : #'Brick-Examples'
}

{ #category : #'examples - events' }
BrBasicExamples >> widgetModelAttachedEvent [
	<gtExample>
	<return: #BlElement>
	| aWidgetElement aWidgetModel viewModelAttachedElement |
	aWidgetElement := BlElement new.

	aWidgetModel := BrWidgetModel new.

	viewModelAttachedElement := nil.
	aWidgetModel
		whenAttachedDo: [ :anElement | viewModelAttachedElement := anElement ].

	aWidgetElement viewModel: aWidgetModel.
	aWidgetElement aptitude: BrAptitude new.

	self assert: viewModelAttachedElement == aWidgetElement.

	^ viewModelAttachedElement
]
