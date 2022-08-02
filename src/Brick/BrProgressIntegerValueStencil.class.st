"
I convert {{gtMethod:BrProgressModel>>#amount|label=#selector}} and {{gtMethod:BrProgressModel>>#total|label=#selector}} values to an {{gtClass:Integer}}:

{{gtExample:BrProgressExamples>>#integerValues|codeExpanded=false|previewExpanded=true|previewHeight=180}}


"
Class {
	#name : #BrProgressIntegerValueStencil,
	#superclass : #BrProgressValueStencil,
	#category : #'Brick-Progress - Model'
}

{ #category : #'api - instantiation' }
BrProgressIntegerValueStencil >> create [
	<return: #String>
	^ self value asInteger asString
]
