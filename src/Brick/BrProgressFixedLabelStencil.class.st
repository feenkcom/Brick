"
I return always a same progress label regardless of the progress status (amount and total values):

{{gtExample:BrProgressExamples>>#fixedLabel|codeExpanded=false|previewExpanded=true|previewHeight=180}}


"
Class {
	#name : #BrProgressFixedLabelStencil,
	#superclass : #BrProgressLabelStencil,
	#instVars : [
		'label'
	],
	#category : #'Brick-Progress - Model'
}

{ #category : #'api - instantiation' }
BrProgressFixedLabelStencil >> create [
	<return: #BlRunRopedText>
	^ self label
]

{ #category : #initialization }
BrProgressFixedLabelStencil >> initialize [
	super initialize.
	self label: 'Preparing...'.
]

{ #category : #accessing }
BrProgressFixedLabelStencil >> label [
	<return: #BlRunRopedText>
	^ label
]

{ #category : #accessing }
BrProgressFixedLabelStencil >> label: aStringOrText [
	label := aStringOrText asRopedText
]
