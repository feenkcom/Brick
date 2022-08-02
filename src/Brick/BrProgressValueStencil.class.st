"
My subclasses convert {{gtMethod:BrProgressModel>>#amount|label=#selector}} and {{gtMethod:BrProgressModel>>#total|label=#selector}} values to {{gtClass:String}} using different strategies.

See my subclasses for specific examples: {{gtClass:BrProgressValueStencil|show=#gtSubclassesFor:|expanded=true|height=200}}


"
Class {
	#name : #BrProgressValueStencil,
	#superclass : #BrStencil,
	#instVars : [
		'value'
	],
	#category : #'Brick-Progress - Model'
}

{ #category : #testing }
BrProgressValueStencil class >> isAbstract [
	^ self name = #BrProgressValueStencil 
]

{ #category : #'api - instantiation' }
BrProgressValueStencil >> create [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #initialization }
BrProgressValueStencil >> initialize [
	super initialize.
	value := 0.
]

{ #category : #accessing }
BrProgressValueStencil >> value [
	^ value
]

{ #category : #accessing }
BrProgressValueStencil >> value: anObject [
	value := anObject
]
