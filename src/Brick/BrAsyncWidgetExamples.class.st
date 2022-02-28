Class {
	#name : #BrAsyncWidgetExamples,
	#superclass : #Object,
	#category : #'Brick-Async-Examples'
}

{ #category : #accessing }
BrAsyncWidgetExamples >> asyncWidgetWithContents [

	<gtExample>
	| widget |
	widget := self basicAsyncWidget.
	widget successBlock: [ :aFrame :aValue | 
		aFrame addChild: (BrLabel new
				 aptitude: BrGlamorousLabelAptitude;
				 text: aValue) ].
	^ widget
]

{ #category : #accessing }
BrAsyncWidgetExamples >> asyncWidgetWithContents_withFuture [

	<gtExample>
	| widget |
	widget := self asyncWidgetWithContents.
	widget asyncFuture future: [ 
		1 seconds wait.
		'hi' ].
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
