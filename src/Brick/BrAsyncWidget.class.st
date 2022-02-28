Class {
	#name : #BrAsyncWidget,
	#superclass : #BrFrame,
	#instVars : [
		'pendingBlock',
		'errorBlock',
		'successBlock',
		'beLazy'
	],
	#category : #'Brick-Async-Widget'
}

{ #category : #accessing }
BrAsyncWidget >> beEager [
	beLazy := false.
	self setup
]

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
	
	beLazy := true
]

{ #category : #accessing }
BrAsyncWidget >> onLayoutDone [

	super onLayoutDone.

	beLazy ifTrue: [ self setup ]
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
BrAsyncWidget >> setup [

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
				self successBlock cull: theFrame cull: aValue ] ]
]

{ #category : #accessing }
BrAsyncWidget >> successBlock [
	^ successBlock
]

{ #category : #accessing }
BrAsyncWidget >> successBlock: aBlock [
	successBlock := aBlock
]
