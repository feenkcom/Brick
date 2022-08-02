"
I convert {{gtMethod:BrProgressModel>>#amount|label=#selector}} and {{gtMethod:BrProgressModel>>#total|label=#selector}} values to an {{gtClass:Float}} with a given number of decimals defined using {{gtMethod:BrProgressFloatValueStencil>>#numberOfDecimals:|label=#selector}}:

{{gtExample:BrProgressExamples>>#floatValues|codeExpanded=false|previewExpanded=true|previewHeight=180}}


"
Class {
	#name : #BrProgressFloatValueStencil,
	#superclass : #BrProgressValueStencil,
	#instVars : [
		'numberOfDecimals'
	],
	#category : #'Brick-Progress - Model'
}

{ #category : #'api - instantiation' }
BrProgressFloatValueStencil >> create [
	<return: #String>
	^ (self value asFloat round: self numberOfDecimals) asString
]

{ #category : #initialization }
BrProgressFloatValueStencil >> initialize [
	super initialize.
	numberOfDecimals := 2.
]

{ #category : #accessing }
BrProgressFloatValueStencil >> numberOfDecimals [
	<return: #Integer>
	^ numberOfDecimals
]

{ #category : #accessing }
BrProgressFloatValueStencil >> numberOfDecimals: anInteger [
	numberOfDecimals := anInteger
]
