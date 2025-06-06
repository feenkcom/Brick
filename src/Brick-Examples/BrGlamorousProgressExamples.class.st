"
# Progress bar
I exemplify {{gtClass:BrProgress}} with glamorous looks.
## Progress Bar Only 
{{gtExample:BrGlamorousProgressExamples>>#barOnly_MainUsage|codeExpanded=false|previewExpanded=true|previewHeight=180}}
## Progress Bar With Text Above 
{{gtExample:BrGlamorousProgressExamples>>#barAndTextAbove_MainUsage|codeExpanded=false|previewExpanded=true|previewHeight=180}}

## Progress Bar With Text Below 
{{gtExample:BrGlamorousProgressExamples>>#barAndTextBelow_MainUsage|codeExpanded=false|previewExpanded=true|previewHeight=180}}


"
Class {
	#name : #BrGlamorousProgressExamples,
	#superclass : #Object,
	#instVars : [
		'progressExamples'
	],
	#category : #'Brick-Examples-Progress'
}

{ #category : #'examples - basic compositions' }
BrGlamorousProgressExamples >> barAndTextAbove [
	<gtExample>
	<return: #BrProgress>
	| aProgress |
	aProgress := self thirtyPercentProgress.
	aProgress
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].
	aProgress
		aptitude: BrGlamorousProgressLabelAptitude + BrGlamorousProgressBarAptitude.
	^ aProgress
]

{ #category : #'examples - main compositions' }
BrGlamorousProgressExamples >> barAndTextAbove_MainUsage [
	<gtExample>
	<return: #BrProgress>
	| aProgress |
	aProgress := self thirtyPercentProgress.
	aProgress aptitude: BrGlamorousProgressWithLabelAndBarAptitude.
	^ aProgress
]

{ #category : #'examples - main compositions' }
BrGlamorousProgressExamples >> barAndTextBelow_MainUsage [
	<gtExample>
	<return: #BrProgress>
	| aProgress |
	aProgress := self thirtyPercentProgress.
	aProgress aptitude: BrGlamorousProgressWithBarAndLabelAptitude.
	^ aProgress
]

{ #category : #'examples - basic compositions' }
BrGlamorousProgressExamples >> barOnly [
	<gtExample>
	<return: #BrProgress>
	| aProgress |
	aProgress := self thirtyPercentProgress.
	aProgress aptitude: BrGlamorousProgressBarAptitude.
	^ aProgress
]

{ #category : #'examples - main compositions' }
BrGlamorousProgressExamples >> barOnly_MainUsage [
	<gtExample>
	<return: #BrProgress>
	| aProgress |
	aProgress := self thirtyPercentProgress.
	aProgress aptitude: BrGlamorousProgressWithBarAptitude.
	^ aProgress
]

{ #category : #initialization }
BrGlamorousProgressExamples >> initialize [
	super initialize.
	progressExamples := BrProgressExamples new.
]

{ #category : #'examples - basic widget' }
BrGlamorousProgressExamples >> thirtyPercentProgress [
	<gtExample>
	<return: #BrProgress>
	^ progressExamples thirtyPercentProgress
		constraintsDo: [ :c | c horizontal matchParent ];
		patternLabel: '{1}% out of {2}% is finished'
]
