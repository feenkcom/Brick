Class {
	#name : #BrTextStylerAsyncStrategySignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'element',
		'future',
		'isElementAttachedToSpace'
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

{ #category : #accessing }
BrTextStylerAsyncStrategySignal >> printOneLineContentsOn: stream [
	super printOneLineContentsOn: stream.

	stream print: element.

	self isElementAttachedToSpace ifFalse: [ 
		stream nextPutAll: ' is not in space' ]
]
