"
I am a {{gtClass:BrProgress}} glamorous look.
I display a progress bar with text above. 
See {{gtClass:BrGlamorousProgressExamples}} class comment for spefic glamorous examples.

"
Class {
	#name : #BrGlamorousProgressWithLabelAndBarAptitude,
	#superclass : #BrAptitude,
	#traits : 'TBlTextStyleable',
	#classTraits : 'TBlTextStyleable classTrait',
	#instVars : [
		'labelLook'
	],
	#category : #'Brick-Glamorous-Progress'
}

{ #category : #accessing }
BrGlamorousProgressWithLabelAndBarAptitude >> attributesBuilder [
	<return: #BlTextAttributesBuilder>
	
	^ labelLook attributesBuilder
]

{ #category : #initialization }
BrGlamorousProgressWithLabelAndBarAptitude >> initialize [
	super initialize.
	
	self addChangeProperty: #(widget layout) with: [ BlLinearLayout vertical ].
	self addChangeProperty: #(widget constraints horizontal resizer) with: [ BlLayoutResizer matchParent ].
	self addChangeProperty: #(widget constraints vertical resizer) with: [ BlLayoutResizer fitContent ].
	
	self addAll: {
		labelLook := BrGlamorousProgressLabelAptitude new.
		BrGlamorousProgressBarAptitude new.
	}
]
