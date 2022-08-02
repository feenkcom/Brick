"
I am an animated {{gtClass:BrProgressBarAptitude}}. I add an animated background to the progress bar widget: 

{{gtExample:BrProgressExamples>>#animatedBar|codeExpanded=false|previewExpanded=true|previewHeight=180}}

I use {{gtClass:BrProgressPaintStencil}} to compute new progress bar background on every animation step.


"
Class {
	#name : #BrProgressAnimatedBarAptitude,
	#superclass : #BrProgressBarAptitude,
	#instVars : [
		'paintStencil'
	],
	#category : #'Brick-Progress - Look'
}

{ #category : #accessing }
BrProgressAnimatedBarAptitude >> animationDelay [
	^ 121 milliSeconds
]

{ #category : #configuration }
BrProgressAnimatedBarAptitude >> beGradientAnimation [
	self paintStencil: BrProgressGradientPaintStencil new
]

{ #category : #configuration }
BrProgressAnimatedBarAptitude >> beGradientAnimationBaseColor: aStartColor highlightColor: aStopColor [
	self paintStencil: (BrProgressGradientPaintStencil new
		startColor: aStartColor;
		stopColor: aStopColor)
]

{ #category : #configuration }
BrProgressAnimatedBarAptitude >> beGradientAnimationColor: aStopColor [
	self paintStencil: (BrProgressGradientPaintStencil new
		stopColor: aStopColor)
]

{ #category : #initialization }
BrProgressAnimatedBarAptitude >> defaultPaintStencil [
	^ BrProgressGradientPaintStencil new
]

{ #category : #initialization }
BrProgressAnimatedBarAptitude >> initialize [
	super initialize.
	self paintStencil: self defaultPaintStencil.
	self container enqueueTask: self newAnimationTask.
]

{ #category : #'instance creation' }
BrProgressAnimatedBarAptitude >> newAnimationTask [
	^ BlRepeatedTaskAction new
		delay: self animationDelay;
		action: [ self updateContainerBackground ].
]

{ #category : #accessing }
BrProgressAnimatedBarAptitude >> paintStencil [
	<return: #BrProgressPaintStencil>
	^ paintStencil
]

{ #category : #accessing }
BrProgressAnimatedBarAptitude >> paintStencil: aBrProgressPaintStencil [
	paintStencil := aBrProgressPaintStencil
]

{ #category : #updating }
BrProgressAnimatedBarAptitude >> updateContainerBackground [
	"do nothing"
	self container background: self paintStencil create.
]
