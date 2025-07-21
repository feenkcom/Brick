Class {
	#name : #BrGlamorousMaximizerSwitcher,
	#superclass : #Object,
	#instVars : [
		'hostElement',
		'elementToMaximize',
		'closeButton',
		'maximizerAptitude',
		'containerElement',
		'contentElement',
		'originalElevation',
		'previousHorizontalResizerState',
		'previousVerticalResizerState',
		'originalHorizontalResizingStrategy',
		'originalVerticalResizingStrategy',
		'originalPosition'
	],
	#category : #'Brick-Glamorous-Maximizer'
}

{ #category : #accessing }
BrGlamorousMaximizerSwitcher >> closeButton [
	^ closeButton
]

{ #category : #accessing }
BrGlamorousMaximizerSwitcher >> closeButton: anElement [
	self assert: [ closeButton isNil ].
	self assert: [ anElement isKindOf: BlElement ].
	closeButton := anElement
]

{ #category : #accessing }
BrGlamorousMaximizerSwitcher >> containerElement [
	^ containerElement
]

{ #category : #accessing }
BrGlamorousMaximizerSwitcher >> containerElement: anElement [
	self assert: [ containerElement isNil ].
	self assert: [ anElement isKindOf: BlElement ].

	containerElement := anElement
]

{ #category : #accessing }
BrGlamorousMaximizerSwitcher >> contentElement [
	^ contentElement
]

{ #category : #accessing }
BrGlamorousMaximizerSwitcher >> contentElement: anElement [
	"Content element is optional.
	Content element can be a child of a container element.
	Both, element-to-maximize and close button are added
	- to the content element, or
	- to the container element if the content element is not defined."

	self assert: [ contentElement isNil ].
	self assert: [ anElement isKindOf: BlElement ].

	contentElement := anElement
]

{ #category : #accessing }
BrGlamorousMaximizerSwitcher >> elementToMaximize [
	^ elementToMaximize
]

{ #category : #accessing }
BrGlamorousMaximizerSwitcher >> elementToMaximize: anElement [
	self assert: [ elementToMaximize isNil ].
	self assert: [ anElement isKindOf: BlElement ].

	elementToMaximize := anElement
]

{ #category : #accessing }
BrGlamorousMaximizerSwitcher >> hostElement [
	^ hostElement
]

{ #category : #accessing }
BrGlamorousMaximizerSwitcher >> hostElement: anElement [
	self assert: [ hostElement isNil ].
	self assert: [ anElement isKindOf: BlElement ].

	hostElement := anElement
]

{ #category : #accessing }
BrGlamorousMaximizerSwitcher >> maximizerAptitude [
	^ maximizerAptitude
]

{ #category : #accessing }
BrGlamorousMaximizerSwitcher >> maximizerAptitude: anAptitude [
	self assert: [ maximizerAptitude isNil ].
	self assert: [ anAptitude isKindOf: BrWithMaximizerAptitude ].
	
	maximizerAptitude := anAptitude
]

{ #category : #private }
BrGlamorousMaximizerSwitcher >> minimize [
	hostElement removeChild: containerElement.
	elementToMaximize removeFromParent.

	originalElevation ifNotNil: [ elementToMaximize elevation: originalElevation ].

	previousHorizontalResizerState
		ifNil: [ elementToMaximize states
				removeState: BrLayoutHorizontalResizerState matchParent ]
		ifNotNil: [ elementToMaximize states addState: previousHorizontalResizerState ].

	previousVerticalResizerState
		ifNil: [ elementToMaximize states removeState: BrLayoutVerticalResizerState matchParent ]
		ifNotNil: [ elementToMaximize states addState: previousVerticalResizerState ].

	elementToMaximize constraints horizontal
		resizer: originalHorizontalResizingStrategy.
	elementToMaximize constraints vertical
		resizer: originalVerticalResizingStrategy.
	elementToMaximize constraints position: originalPosition.
	maximizerAptitude
		dispatchEvent: (BrMaximizerMinimizeWish new
				elementToMinimize: elementToMaximize;
				hostElement: hostElement)
]

{ #category : #building }
BrGlamorousMaximizerSwitcher >> switch [
	self assert: [ closeButton isKindOf: BlElement ].
	self assert: [ closeButton respondsTo: #action: ].
	self assert: [ elementToMaximize isKindOf: BlElement ].
	self assert: [ hostElement isKindOf: BlElement ].
	self assert: [ containerElement isKindOf: BlElement ].
	self assert: [ contentElement isNil or: [ contentElement isKindOf: BlElement ] ].
	self assert: [ maximizerAptitude isKindOf: BrWithMaximizerAptitude ].

	elementToMaximize elevation = BlRelativeElevation zero ifFalse: [ 
		originalElevation := elementToMaximize elevation.
		elementToMaximize elevation: BlRelativeElevation zero ].

	originalHorizontalResizingStrategy := elementToMaximize constraints horizontal resizer.
	originalVerticalResizingStrategy := elementToMaximize constraints vertical resizer.
	originalPosition := elementToMaximize constraints position.

	previousHorizontalResizerState := elementToMaximize states
		stateLike: BrLayoutHorizontalResizerState new
		ifFound: #yourself
		ifNone: [ nil ].

	previousVerticalResizerState := elementToMaximize states
			stateLike: BrLayoutVerticalResizerState new
			ifFound: #yourself
			ifNone: [ nil ].

	elementToMaximize
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
			c position: 0 @ 0 ].

	elementToMaximize states addState: BrLayoutHorizontalResizerState matchParent.
	elementToMaximize states addState: BrLayoutVerticalResizerState matchParent.
	
	containerElement when: BrMaximizerHostMinimizeWish do: [ :anEvent |
		anEvent consumed: true.
		self minimize ].
		
	containerElement when: BrMaximizerHostMaximizedElementWish do: [ :anEvent |
		anEvent consumed: true.
		anEvent maximizedElement: elementToMaximize ].
	
	closeButton action: [ self minimize ].
			
	contentElement 
		ifNil: [
			containerElement addChild: elementToMaximize.
			containerElement addChild: closeButton ]
		ifNotNil: [
			contentElement hasParent ifFalse: [
				containerElement addChild: contentElement ].
			contentElement addChild: elementToMaximize.
			contentElement addChild: closeButton ].
	
	hostElement addChild: containerElement
]
