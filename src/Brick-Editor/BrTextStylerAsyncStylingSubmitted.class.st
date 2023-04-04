Class {
	#name : #BrTextStylerAsyncStylingSubmitted,
	#superclass : #BrTextStylerAsyncStrategySignal,
	#instVars : [
		'editorStylingFuture'
	],
	#category : #'Brick-Editor-Styler'
}

{ #category : #accessing }
BrTextStylerAsyncStylingSubmitted >> editorStylingFuture [
	^ editorStylingFuture
]

{ #category : #accessing }
BrTextStylerAsyncStylingSubmitted >> editorStylingFuture: anObject [
	editorStylingFuture := anObject
]
