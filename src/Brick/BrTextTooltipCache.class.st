Class {
	#name : #BrTextTooltipCache,
	#superclass : #Object,
	#instVars : [
		'text',
		'cache'
	],
	#category : #'Brick-Attributes - Support'
}

{ #category : #'api - cache' }
BrTextTooltipCache >> at: aBlSubText ifPresent: aFullBlockClosure ifAbsentPut: aFullBlockClosure3 [
	^ cache
		at: aBlSubText
		ifPresent: aFullBlockClosure
		ifAbsentPut: aFullBlockClosure3
]

{ #category : #'as yet unclassified' }
BrTextTooltipCache >> initialize [
	super initialize.
	cache := Dictionary new
]

{ #category : #'api - cache' }
BrTextTooltipCache >> isForText: aBlText [
	^ self text isNotNil and: [ self text isNextGenerationOf: aBlText ]
]

{ #category : #'api - cache' }
BrTextTooltipCache >> prepareForTextElement: aTextElement [
	(self isForText: aTextElement text) ifTrue: [ ^ self ].

	self uninstallAllIn: aTextElement.
	self text: aTextElement text
]

{ #category : #printing }
BrTextTooltipCache >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $[;
		print: self size;
		nextPutAll: (' item' asPluralBasedOn: self size);
		nextPut: $]
]

{ #category : #accessing }
BrTextTooltipCache >> size [
	^ cache ifNotNil: #size ifNil: [ 0 ]
]

{ #category : #accessing }
BrTextTooltipCache >> text [
	^ text
]

{ #category : #accessing }
BrTextTooltipCache >> text: aBlText [
	text := aBlText nextGeneration
]

{ #category : #'api - cache' }
BrTextTooltipCache >> uninstallAllIn: aTextElement [
	cache valuesDo: [ :eachAptitude | aTextElement removeAptitude: eachAptitude ].
	cache removeAll
]
