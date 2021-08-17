Class {
	#name : 'BrLayoutHorizontalExactResizerPropagatedState',
	#superclass : 'BrLayoutHorizontalExactResizerState',
	#instVars : [
		'width'
	],
	#category : 'Brick-Core-Layout Resizer'
}

{ #category : 'converting' }
BrLayoutHorizontalExactResizerPropagatedState >> asNotPropagated [
	^ BrLayoutHorizontalResizerState exact
]

{ #category : 'converting' }
BrLayoutHorizontalExactResizerPropagatedState >> asPropagated [
	^ self
]

{ #category : 'initialization' }
BrLayoutHorizontalExactResizerPropagatedState >> initialize [
	super initialize.
	
	width := 50
]

{ #category : 'enumerating' }
BrLayoutHorizontalExactResizerPropagatedState >> optionalOnAddedTo: anElement [
	anElement properties hExact: self width
]

{ #category : 'printing' }
BrLayoutHorizontalExactResizerPropagatedState >> printOn: aStream [
	super printOn: aStream.
	aStream space;
		nextPutAll: '(propagated)'
]

{ #category : 'testing' }
BrLayoutHorizontalExactResizerPropagatedState >> shouldOverwriteChildState [
	^ true
]

{ #category : 'accessing' }
BrLayoutHorizontalExactResizerPropagatedState >> width [
	^ width
]

{ #category : 'accessing' }
BrLayoutHorizontalExactResizerPropagatedState >> width: anObject [
	width := anObject
]
