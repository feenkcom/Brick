Class {
	#name : #BrLayoutVerticalExactResizerPropagatedState,
	#superclass : #BrLayoutVerticalExactResizerState,
	#instVars : [
		'height'
	],
	#category : #'Brick-Core-Layout Resizer'
}

{ #category : #converting }
BrLayoutVerticalExactResizerPropagatedState >> asNotPropagated [
	^ BrLayoutVerticalResizerState exact
]

{ #category : #converting }
BrLayoutVerticalExactResizerPropagatedState >> asPropagated [
	^ self
]

{ #category : #accessing }
BrLayoutVerticalExactResizerPropagatedState >> height [
	^ height
]

{ #category : #accessing }
BrLayoutVerticalExactResizerPropagatedState >> height: anObject [
	height := anObject
]

{ #category : #initialization }
BrLayoutVerticalExactResizerPropagatedState >> initialize [
	super initialize.
	
	height := 50
]

{ #category : #enumerating }
BrLayoutVerticalExactResizerPropagatedState >> optionalOnAddedTo: anElement [
	anElement properties vExact: self height
]

{ #category : #printing }
BrLayoutVerticalExactResizerPropagatedState >> printOn: aStream [
	super printOn: aStream.
	aStream space;
		nextPutAll: '(propagated)'
]

{ #category : #testing }
BrLayoutVerticalExactResizerPropagatedState >> shouldOverwriteChildState [
	^ true
]
