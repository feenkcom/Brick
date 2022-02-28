Class {
	#name : #BrAsyncWidget,
	#superclass : #BrFrame,
	#instVars : [
		'pendingBlock',
		'errorBlock',
		'successBlock'
	],
	#category : #'Brick-Async-Widget'
}

{ #category : #accessing }
BrAsyncWidget >> defaultErrorBlock [

	^ [ :anError | 
	  anError asDebuggableElement
		  hFitContentLimited;
		  vFitContent ]
]

{ #category : #accessing }
BrAsyncWidget >> defaultPendingBlock [

	^ [ 
	  BrLabel new
		  fitContent;
		  aptitude: (BrGlamorousLabelAptitude new foreground:
					   BrGlamorousColors disabledButtonTextColor);
		  text: 'Rendering...' ]
]

{ #category : #accessing }
BrAsyncWidget >> errorBlock [
	^ errorBlock ifNil: [ self defaultErrorBlock ]
]

{ #category : #accessing }
BrAsyncWidget >> errorBlock: aBlock [
	errorBlock := aBlock
]

{ #category : #accessing }
BrAsyncWidget >> initialize [

	super initialize.

	self fitContent.

	self withAsyncFutureDo: [ :anElementFuture | 
		anElementFuture
			whenPending: [ :theContainer | 
				theContainer
					addChild: self pendingBlock value;
					constraintsDo: [ :c | 
						c frame horizontal alignCenter.
						c frame vertical alignCenter ] ];
			whenError: [ :theContainer :anError | 
				theContainer
					removeChildren;
					addChild: (self errorBlock value: anError);
					constraintsDo: [ :c | 
						c frame horizontal alignCenter.
						c frame vertical alignCenter ] ];
			whenSuccess: [ :theFrame :aValue | 
				| aStencil aContainer |
				theFrame removeChildren.
				self successBlock value: theFrame value: aValue ] ]
]

{ #category : #accessing }
BrAsyncWidget >> pendingBlock [
	^ pendingBlock ifNil: [ self defaultPendingBlock ]
]

{ #category : #accessing }
BrAsyncWidget >> pendingBlock: aBlock [
	pendingBlock := aBlock
]

{ #category : #accessing }
BrAsyncWidget >> successBlock [
	^ successBlock
]

{ #category : #accessing }
BrAsyncWidget >> successBlock: aBlock [
	successBlock := aBlock
]
