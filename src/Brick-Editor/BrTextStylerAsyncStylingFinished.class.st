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
BrTextStylerAsyncStylingFinished >> gtInnerTextFor: aView [
	<gtView>
	^ aView forward
		title: 'Inner text';
		priority: 0;
		object: [ self styledText ];
		view: #gtInnerTextFor:
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
