Class {
	#name : #BrTextStylerAsyncStrategySignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'element',
		'elementSpace',
		'future'
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
	elementSpace := anElement ifNotNil: #space
]

{ #category : #accessing }
BrTextStylerAsyncStrategySignal >> elementSpace [
	^ elementSpace
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
BrTextStylerAsyncStrategySignal >> isElementInSpace [
	^ elementSpace isNotNil
]

{ #category : #accessing }
BrTextStylerAsyncStrategySignal >> printOneLineContentsOn: stream [
	super printOneLineContentsOn: stream.

	stream print: element.

	self isElementInSpace ifFalse: [ 
		stream nextPutAll: ' is not in space' ]
]
