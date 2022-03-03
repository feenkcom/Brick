Class {
	#name : #BrAsyncWidgetExamples,
	#superclass : #Object,
	#category : #'Brick-Async-Examples'
}

{ #category : #accessing }
BrAsyncWidgetExamples >> asyncWidgetWithContents [
	<noTest>
	<gtExample>
	| widget |
	widget := self basicAsyncWidget.
	widget stencil: [ 
		1 seconds wait.
		BrLabel new
			aptitude: BrGlamorousLabelAptitude;
			text: 'hi' ].
	^ widget
]

{ #category : #accessing }
BrAsyncWidgetExamples >> basicAsyncWidget [

	<gtExample>
	| widget |
	widget := BrAsyncWidget new.
	self assert: widget errorBlock compiledBlock
		= widget defaultErrorBlock compiledBlock.
	self assert: widget pendingBlock compiledBlock
		= widget defaultPendingBlock compiledBlock.
	^ widget
]
