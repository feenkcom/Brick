Class {
	#name : #BrTextStylerAsyncStylingFinished,
	#superclass : #BrTextStylerAsyncStrategySignal,
	#instVars : [
		'styledText',
		'styler'
	],
	#category : #'Brick-Editor-Styler'
}

{ #category : #'gt - extensions' }
BrTextStylerAsyncStylingFinished >> gtInnerTextAttributeTreeFor: aView [
	<gtView>
	^ aView forward
		title: 'Styled inner text attributes';
		priority: 0.1;
		object: [ self styledText ];
		view: #gtInnerTextAttributeTreeFor:
]

{ #category : #'gt - extensions' }
BrTextStylerAsyncStylingFinished >> gtInnerTextFor: aView [
	<gtView>
	^ aView forward
		title: 'Styled inner text';
		priority: 0;
		object: [ self styledText ];
		view: #gtInnerTextFor:
]

{ #category : #initialization }
BrTextStylerAsyncStylingFinished >> prepareForDelivery [
	super prepareForDelivery.

	styledText ifNotNil: [ :aText | styledText := aText copy ]
]

{ #category : #accessing }
BrTextStylerAsyncStylingFinished >> styledText [
	^ styledText
]

{ #category : #accessing }
BrTextStylerAsyncStylingFinished >> styledText: anObject [
	styledText := anObject
]

{ #category : #accessing }
BrTextStylerAsyncStylingFinished >> styler [
	^ styler
]

{ #category : #accessing }
BrTextStylerAsyncStylingFinished >> styler: anObject [
	styler := anObject
]
