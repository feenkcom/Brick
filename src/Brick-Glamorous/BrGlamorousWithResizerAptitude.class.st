Class {
	#name : #BrGlamorousWithResizerAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'resizer'
	],
	#category : #'Brick-Glamorous-Resizer'
}

{ #category : #'api - visibility' }
BrGlamorousWithResizerAptitude >> hideResizer [
	self resizerDo: [ :aResizer | aResizer visibility: BlVisibility hidden ]
]

{ #category : #initialization }
BrGlamorousWithResizerAptitude >> initialize [
	super initialize.
	resizer := self newResizer.
	self addChangeAddChild: #() with: [ resizer ].
	self
		addChange:
			(BrLookChange new
				up: [ :e | 
					resizer target: self widget ];
				down: [ :e | 
					"We do not want to keep target elements, since it may produce memory leaks.
					Issue: https://github.com/feenkcom/gtoolkit/issues/3915
					Example: GtWorldByScripterExamples>>#worldSpotter_ResizeVertically_ClosePressingEscape"
					resizer target: nil ];
				yourself)
]

{ #category : #accessing }
BrGlamorousWithResizerAptitude >> keepRatio: aBoolean [
	self resizerDo: [ :aResizer | aResizer keepRatio: aBoolean ]
]

{ #category : #initialization }
BrGlamorousWithResizerAptitude >> newResizer [
	^ BrResizer new
		aptitude: BrGlamorousResizerAptitude;
		elevation: (BlRelativeElevation elevation: 1000);
		constraintsDo: [ :c | c ignoreByLayout ]
]

{ #category : #enumerating }
BrGlamorousWithResizerAptitude >> resizerDo: aBlock [
	aBlock value: resizer
]

{ #category : #'api - visibility' }
BrGlamorousWithResizerAptitude >> showResizer [
	self resizerDo: [ :aResizer | aResizer visibility: BlVisibility visible ]
]

{ #category : #'api - event handlers' }
BrGlamorousWithResizerAptitude >> whenResizedDo: aBlock [
	self resizerDo: [ :aResizer | aResizer when: BlResizerResizedEvent do: aBlock ]
]
