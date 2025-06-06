"
I exemplify {{gtClass:BrProgress}}.
See also {{gtClass:BrGlamorousProgressExamples}} for glamorous examples.

## Static Progress Bar

{{gtExample:BrProgressExamples>>#barOnly|codeExpanded=false|previewExpanded=true|previewHeight=180}}

## Animated Progress Bar

{{gtExample:BrProgressExamples>>#animatedBar|codeExpanded=false|previewExpanded=true|previewHeight=180}}

## Progress Bar With Text Above

{{gtExample:BrProgressExamples>>#barAndTextAbove|codeExpanded=false|previewExpanded=true|previewHeight=180}}

## Animated Progress Bar With Text Above

{{gtExample:BrProgressExamples>>#animatedBarAndTextAbove|codeExpanded=false|previewExpanded=true|previewHeight=180}}

## Progress Bar With Text Inside

{{gtExample:BrProgressExamples>>#barAndTextInside|codeExpanded=false|previewExpanded=true|previewHeight=180}}

## Progress Bar With Text Below

{{gtExample:BrProgressExamples>>#barAndTextBelow|codeExpanded=false|previewExpanded=true|previewHeight=180}}


"
Class {
	#name : #BrProgressExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Progress'
}

{ #category : #'examples - bar and text compositions' }
BrProgressExamples >> animatedBar [
	<gtExample>
	<return: #BrProgress>
	| aProgress |
	aProgress := self thirtyPercentProgress.
	aProgress
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		aptitude: self animatedBarLook.
	self assert: aProgress childrenCount equals: 1.
	self assert: aProgress children first layout class equals: BlFrameLayout.
	self assert: aProgress children first childrenCount equals: 1.
	self
		assert: aProgress children first children first constraints frame horizontal weight
		equals: 0.3.
	^ aProgress
]

{ #category : #'examples - bar and text compositions' }
BrProgressExamples >> animatedBarAndTextAbove [
	<gtExample>
	<return: #BrProgress>
	| aProgress |
	aProgress := self thirtyPercentProgress.
	aProgress
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		aptitude: self textLook + self animatedBarLook.
	self assert: aProgress childrenCount equals: 2.
	self assert: aProgress children second layout class equals: BlFrameLayout.
	self assert: aProgress children second childrenCount equals: 1.
	self
		assert: aProgress children second children first constraints frame horizontal weight
		equals: 0.3.
	self
		assert: aProgress children first text asString
		equals: 'Out of 100%, 30% transfered'.
	^ aProgress
]

{ #category : #'examples - looks' }
BrProgressExamples >> animatedBarLook [
	<gtExample>
	<return: #BrProgressAnimatedBarAptitude>
	^ BrProgressAnimatedBarAptitude new
		beGradientAnimationBaseColor: Color white
			highlightColor: Color blue muchLighter;
		barDo: [ :aBar | 
			aBar background: Color blue.
			aBar geometry: (BlRoundedRectangleGeometry cornerRadius: 8).
			aBar constraintsDo: [ :c | c vertical exact: 20 ] ];
		containerDo: [ :aBarContainer | aBarContainer geometry: (BlRoundedRectangleGeometry cornerRadius: 8) ]
]

{ #category : #'examples - text formats' }
BrProgressExamples >> asIsValues [
	<gtExample>
	<return: #BrProgress>
	| aProgress |
	aProgress := self barAndTextInside.
	aProgress amount: 300 * 1024 / 13 total: 8 * 1024 * 1024.
	aProgress patternLabel: '{1} out of {2} bytes downloaded'.
	aProgress asIsValues.
	self
		assert: aProgress label asString
		equals: '(307200/13) out of 8388608 bytes downloaded'.
	^ aProgress
]

{ #category : #'examples - bar and text compositions' }
BrProgressExamples >> barAndTextAbove [
	<gtExample>
	<return: #BrProgress>
	| aProgress |
	aProgress := self thirtyPercentProgress.
	aProgress
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		aptitude: self textLook + self barLook.
	self assert: aProgress childrenCount equals: 2.
	self assert: aProgress children second layout class equals: BlFrameLayout.
	self assert: aProgress children second childrenCount equals: 1.
	self
		assert: aProgress children second children first constraints frame horizontal weight
		equals: 0.3.
	self
		assert: aProgress children first text asString
		equals: 'Out of 100%, 30% transfered'.
	^ aProgress
]

{ #category : #'examples - bar and text compositions' }
BrProgressExamples >> barAndTextBelow [
	<gtExample>
	<return: #BrProgress>
	| aProgress |
	aProgress := self thirtyPercentProgress.
	aProgress
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		aptitude: self barLook + self textLook.
	self assert: aProgress childrenCount equals: 2.
	self assert: aProgress children first layout class equals: BlFrameLayout.
	self assert: aProgress children first childrenCount equals: 1.
	self
		assert: aProgress children first children first constraints frame horizontal weight
		equals: 0.3.
	self
		assert: aProgress children second text asString
		equals: 'Out of 100%, 30% transfered'.
	^ aProgress
]

{ #category : #'examples - bar and text compositions' }
BrProgressExamples >> barAndTextInside [
	<gtExample>
	<return: #BrProgress>
	| aProgress |
	aProgress := self thirtyPercentProgress.
	aProgress
		layout: BlLinearLayout new;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		aptitude: self barLook
				+ (self textLook
						foreground: Color white;
						labelDo: [ :aLabel | aLabel constraintsDo: [ :c | c ignoreByLayout ] ]).
	self assert: aProgress childrenCount equals: 2.
	self assert: aProgress children first layout class equals: BlFrameLayout.
	self assert: aProgress children first childrenCount equals: 1.
	self
		assert: aProgress children first children first constraints frame horizontal weight
		equals: 0.3.
	self
		assert: aProgress children second text asString
		equals: 'Out of 100%, 30% transfered'.
	self assert: aProgress children second constraints ignoredByLayout.
	^ aProgress
]

{ #category : #'examples - looks' }
BrProgressExamples >> barLook [
	<gtExample>
	<return: #BrProgressBarAptitude>
	^ BrProgressBarAptitude new
		barDo: [ :aBar | 
			aBar background: Color blue.
			aBar geometry: (BlRoundedRectangleGeometry cornerRadius: 8).
			aBar constraintsDo: [ :c | c vertical exact: 20 ] ];
		containerDo: [ :aBarContainer | 
			aBarContainer background: Color blue muchLighter.
			aBarContainer geometry: (BlRoundedRectangleGeometry cornerRadius: 8) ]
]

{ #category : #'examples - bar and text compositions' }
BrProgressExamples >> barOnly [
	<gtExample>
	<return: #BrProgress>
	| aProgress |
	aProgress := self thirtyPercentProgress.
	aProgress
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		aptitude: self barLook.
	self assert: aProgress childrenCount equals: 1.
	self assert: aProgress children first layout class equals: BlFrameLayout.
	self assert: aProgress children first childrenCount equals: 1.
	self
		assert: aProgress children first children first constraints frame horizontal weight
		equals: 0.3.
	^ aProgress
]

{ #category : #'examples - paint stencils' }
BrProgressExamples >> basicGradientPaintStencil [
	<gtExample>
	<return: #BrProgressGradientPaintStencil>
	| aPaint |
	aPaint := BrProgressGradientPaintStencil new.
	self assert: aPaint stop isNumber.
	self assert: aPaint step isNumber.
	self assert: aPaint startColor isNotNil.
	self assert: aPaint stopColor isNotNil.
	^ aPaint
]

{ #category : #'examples - paint stencils' }
BrProgressExamples >> blueGradientPaintStencil [
	<gtExample>
	<return: #BrProgressGradientPaintStencil>
	| aPaint |
	aPaint := self basicGradientPaintStencil.
	aPaint startColor: Color green.
	aPaint stopColor: Color blue.
	self assert: aPaint startColor equals: Color green.
	self assert: aPaint stopColor equals: Color blue.
	^ aPaint
]

{ #category : #accessing }
BrProgressExamples >> demo [
	"A demo of how to use it."

	<gtExample>
	<noTest>
	| progressBar |
	progressBar := BrProgress new.
	progressBar
		percentage: 0;
		constraintsDo: [ :c | c horizontal matchParent ];
		patternLabel: '{1}% out of {2}% is finished';
		aptitude: BrGlamorousProgressWithLabelAndBarAptitude.
	[ 1
		to: 20
		do: [ :n | 
			(n * 20) milliSeconds asDelay wait.
			progressBar percentage: n * 5 ] ] fork.
	^ progressBar
]

{ #category : #'examples - text formats' }
BrProgressExamples >> fileSizeValues [
	<gtExample>
	<return: #BrProgress>
	| aProgress |
	aProgress := self barAndTextInside.
	aProgress amount: 300 total: 8 * 1024 * 1024.
	aProgress patternLabel: '{1} out of {2} has been downloaded'.
	aProgress fileSizeLabelValues.
	self
		assert: aProgress label asString
		equals: '300 bytes out of 8192 KB has been downloaded'.
	^ aProgress
]

{ #category : #'examples - text formats' }
BrProgressExamples >> fixedLabel [
	<gtExample>
	<return: #BrProgress>
	| aProgress |
	aProgress := self barAndTextInside.
	aProgress amount: 1024 * 1024 total: 8 * 1024 * 1024.
	aProgress fixedLabel: 'downloading...'.
	self assert: aProgress label asString equals: 'downloading...'.
	^ aProgress
]

{ #category : #'examples - text formats' }
BrProgressExamples >> floatValues [
	<gtExample>
	<return: #BrProgress>
	| aProgress |
	aProgress := self barAndTextInside.
	aProgress amount: 300 total: 8 * 1024.
	aProgress patternLabel: '{1} kbytes out of {2} kbytes'.
	aProgress floatLabelValuesWithDecimals: 1.
	self
		assert: aProgress label asString
		equals: '300.0 kbytes out of 8192.0 kbytes'.
	^ aProgress
]

{ #category : #'examples - text formats' }
BrProgressExamples >> integerValues [
	<gtExample>
	<return: #BrProgress>
	| aProgress |
	aProgress := self barAndTextInside.
	aProgress amount: 300 * 1024 / 13 total: 8 * 1024 * 1024.
	aProgress patternLabel: '{1} out of {2} bytes downloaded'.
	aProgress integerLabelValues.
	self
		assert: aProgress label asString
		equals: '23630 out of 8388608 bytes downloaded'.
	^ aProgress
]

{ #category : #'examples - basic widget' }
BrProgressExamples >> progress [
	<gtExample>
	<return: #BrProgress>
	| aProgress |
	aProgress := BrProgress new.
	self assert: aProgress viewModel isNotNil.
	self assert: aProgress childrenCount equals: 0.
	self assert: aProgress percentage equals: 0.
	self assert: aProgress amount equals: 0.
	self assert: aProgress total equals: 100.
	self assert: aProgress percentage equals: 0.
	self assert: aProgress fraction equals: 0.
	self assert: aProgress label asString equals: 'Preparing...'.
	^ aProgress
]

{ #category : #'examples - model' }
BrProgressExamples >> progressModel [
	<gtExample>
	<return: #BrProgressModel>
	| aModel |
	aModel := BrProgressModel new.
	self assert: aModel percentage isZero.
	self assert: aModel amount equals: 0.
	self assert: aModel total equals: 100.
	^ aModel
]

{ #category : #'examples - looks' }
BrProgressExamples >> textLook [
	<gtExample>
	<return: #BrTextLabelAptitude>
	^ BrTextLabelAptitude new
		foreground: Color lightGray;
		labelDo: [ :aWidget | 
			aWidget
				constraintsDo: [ :c | 
					c margin: (BlInsets all: 3).
					c linear horizontal alignCenter.
					c ignored horizontal alignCenter.
					c ignored vertical alignCenter ] ]
]

{ #category : #'examples - basic widget' }
BrProgressExamples >> thirtyPercentProgress [
	<gtExample>
	<return: #BrProgress>
	| aProgress |
	aProgress := self progress.
	aProgress percentage: 30.
	aProgress patternLabel: 'Out of {2}%, {1}% transfered'.
	self assert: aProgress percentage equals: 30.
	self assert: aProgress label asString equals: 'Out of 100%, 30% transfered'.
	^ aProgress
]

{ #category : #'examples - basic widget' }
BrProgressExamples >> thirtyPercentStaticLabelProgress [
	<gtExample>
	<return: #BrProgress>
	| aProgress |
	aProgress := self progress.
	aProgress percentage: 30.
	aProgress fixedLabel: 'Processing...'.
	self assert: aProgress percentage equals: 30.
	self assert: aProgress label asString equals: 'Processing...'.
	^ aProgress
]
