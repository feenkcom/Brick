Class {
	#name : #BrTextStylerAsyncStrategySignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'element',
		'future',
		'isElementAttachedToSpace',
		'text'
	],
	#category : #'Brick-Editor-Styler'
}

{ #category : #accessing }
BrTextStylerAsyncStrategySignal >> element [
	^ element
]

{ #category : #accessing }
BrTextStylerAsyncStrategySignal >> element: anElement [
	element := anElement.
	isElementAttachedToSpace := element
		ifNotNil: [ :theElement | theElement isAttachedToSceneGraph ]
		ifNil: [ false ]
]

{ #category : #accessing }
BrTextStylerAsyncStrategySignal >> future [
	^ future
]

{ #category : #accessing }
BrTextStylerAsyncStrategySignal >> future: anObject [
	future := anObject
]

{ #category : #testing }
BrTextStylerAsyncStrategySignal >> isElementAttachedToSpace [
	^ isElementAttachedToSpace
]

{ #category : #initialization }
BrTextStylerAsyncStrategySignal >> prepareForDelivery [
	super prepareForDelivery.

	element ifNotNil: [ :anElement | 
		text := anElement text copy ]
]

{ #category : #printing }
BrTextStylerAsyncStrategySignal >> printOneLineContentsOn: stream [
	stream print: element identityHash; space.

	self text
		ifEmpty: [ stream nextPutAll: 'Empty text' ]
		ifNotEmpty: [ 
			| anIndex |
			anIndex := self text finder endOfLine; search.
			anIndex isZero 
				ifTrue: [ stream print: self text ]
				ifFalse: [ stream print: (self text from: 1 to: (anIndex - 1 max: 1)) ] ].

	stream space.
	stream print: element.
	self isElementAttachedToSpace ifFalse: [ 
		stream nextPutAll: ' is not in space' ].
		
	stream space.
	super printOneLineContentsOn: stream.
]

{ #category : #accessing }
BrTextStylerAsyncStrategySignal >> text [
	^ text
]
