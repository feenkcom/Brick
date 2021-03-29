"
!Working with Aptitude
${class:BrAptitude|label=Aptitudes}$ affect and endow an element with looks and behavior. They can be dynamically added and removed. They can be composed. In short, a powerful mechanism for dynamic scenes.

Let's consider an example: a simple label. Constructing 

${example:BrWorkingWithAptitudeExplanation>>#labelWithoutAptitude|previewExpanded=|previewShow=#gtLiveFor:|previewHeight=100}$


"
Class {
	#name : #BrWorkingWithAptitudeExplanation,
	#superclass : #Object,
	#category : #'Brick-Examples-Explanations'
}

{ #category : #accessing }
BrWorkingWithAptitudeExplanation >> labelWithAptitude [
	<gtExample>
	| label |
	label := self labelWithoutAptitude.
	label aptitude: BrGlamorousLabelAptitude new bold.
	self assert: label hasChildren.
	self assert: label children size = 1.
	self assert: (label children first isKindOf: BlTextElement).
	^ label
]

{ #category : #accessing }
BrWorkingWithAptitudeExplanation >> labelWithCompositeVisualAndBehaviorAptitude [
	<gtExample>
	| label |
	label := self labelWithoutAptitude.
	label aptitude: 
			BrGlamorousLabelAptitude new bold +
			BrShadowAptitude new + 
			BrGlamorousWithMaximizerAptitude new.
	self assert: label hasChildren.
	self assert: label children size = 2.
	self assert: (label children first isKindOf: BlTextElement).
	self assert: (label children second isKindOf: BrButton).
	self assert: label effect notNil.
	^ label
]

{ #category : #accessing }
BrWorkingWithAptitudeExplanation >> labelWithCompositeVisualAptitude [
	<gtExample>
	| label |
	label := self labelWithoutAptitude.
	label aptitude: 
			BrGlamorousLabelAptitude new bold +
			BrShadowAptitude new.
	self assert: label hasChildren.
	self assert: label children size = 1.
	self assert: (label children first isKindOf: BlTextElement).
	self assert: label effect notNil.
	^ label
]

{ #category : #accessing }
BrWorkingWithAptitudeExplanation >> labelWithoutAptitude [
	<gtExample>
	| label |
	label := BrLabel new
		text: 'glamorous toolkit';
		background: Color white;
		padding: (BlInsets all: 20);
		alignCenter;
		relocate: 20@30.
	self assert: label hasChildren not.
	self assert: label effect isNullEffect.
	^ label
]
