Class {
	#name : #BrTextStylerAsyncStylingStarted,
	#superclass : #BrTextStylerAsyncStrategySignal,
	#instVars : [
		'unstyledText',
		'styler'
	],
	#category : #'Brick-Editor-Styler'
}

{ #category : #initialization }
BrTextStylerAsyncStylingStarted >> prepareForDelivery [
	super prepareForDelivery.
	unstyledText ifNotNil: [ :aText | unstyledText := aText copy ]
]

{ #category : #accessing }
BrTextStylerAsyncStylingStarted >> styler [
	^ styler
]

{ #category : #accessing }
BrTextStylerAsyncStylingStarted >> styler: anObject [
	styler := anObject
]

{ #category : #accessing }
BrTextStylerAsyncStylingStarted >> unstyledText [
	^ unstyledText
]

{ #category : #accessing }
BrTextStylerAsyncStylingStarted >> unstyledText: aText [
	unstyledText := aText
]
