"
I return a progress label that includes exact status information (amount and total values):

{{gtExample:BrProgressExamples>>#fileSizeValues|codeExpanded=false|previewExpanded=true|previewHeight=180}}

The pattern can be defined as follows: {{gtMethod:BrProgressExactProgressLabelStencil>>#pattern:|expanded=true}}.

The default pattern is {{gtMethod:BrProgressExactProgressLabelStencil>>#defaultPattern|expanded=true|expanded=true}}}$

## Human Readable Progress Status 

{{gtExample:BrProgressExamples>>#fileSizeValues|codeExpanded=false|previewExpanded=true|previewHeight=180}}


"
Class {
	#name : #BrProgressExactProgressLabelStencil,
	#superclass : #BrProgressLabelStencil,
	#instVars : [
		'pattern'
	],
	#category : #'Brick-Progress - Model'
}

{ #category : #'api - instantiation' }
BrProgressExactProgressLabelStencil >> create [
	<return: #BlRopedText>
	^ (self pattern format: { self amount. self total }) asRopedText
]

{ #category : #initialization }
BrProgressExactProgressLabelStencil >> defaultPattern [
	^ '{1} out of {2} is ready...'
]

{ #category : #initialization }
BrProgressExactProgressLabelStencil >> initialize [
	super initialize.
	pattern := self defaultPattern.
]

{ #category : #accessing }
BrProgressExactProgressLabelStencil >> pattern [
	<return: #String>
	^ pattern
]

{ #category : #accessing }
BrProgressExactProgressLabelStencil >> pattern: aString [
	"The input string can include two place holders called {1} and {2},
	where {1} is transfered amount, and {2} is total to transfer.
	Example: 'Out of {2}%, {1}% has been transfered...'"
	pattern := aString
]
