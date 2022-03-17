Class {
	#name : #BrAsyncWidget,
	#superclass : #BrFrame,
	#instVars : [
		'pendingBlock',
		'errorBlock',
		'successBlock',
		'beLazy',
		'strategy',
		'postAction'
	],
	#category : #'Brick-Async-Widget'
}

{ #category : #accessing }
BrAsyncWidget >> defaultErrorBlock [

	^ [ :anError | anError asDebuggableElement matchParent ]
]

{ #category : #accessing }
BrAsyncWidget >> defaultPendingBlock [

	^ [ :aFuture |
	  BrLabel new
		  matchParent;
		  alignCenter;
		  aptitude: (BrGlamorousLabelAptitude new foreground:
					   BrGlamorousColors disabledButtonTextColor);
		  text: 'Rendering...';
		  addChild: (BrButton new
				   aptitude: BrGlamorousButtonWithIconAptitude;
				   icon: BrGlamorousVectorIcons cancel;
				   action: [  aFuture cancelHard interrupt ]) ]
]

{ #category : #accessing }
BrAsyncWidget >> defaultStrategy [
	^ BrAsyncElementFutureWhenInSceneStrategy new
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
	
	strategy := self defaultStrategy
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
BrAsyncWidget >> postAction [
]

{ #category : #accessing }
BrAsyncWidget >> postAction: anAction [
	postAction := anAction
]

{ #category : #accessing }
BrAsyncWidget >> setup [

	self withAsyncFutureDo: [ :anElementFuture | 
		anElementFuture
			strategy: strategy;
			whenPending: [ :theContainer | 
				theContainer
					addChild: (self pendingBlock value: anElementFuture);
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
			whenSuccess: [ :theFrame :theElement | 
				| aStencil aContainer |
				theFrame removeChildren.
				theFrame addChild: theElement.
				postAction ifNotNil: [ postAction value: theFrame ] ] ]
]

{ #category : #accessing }
BrAsyncWidget >> stencil: aBlock [

	self setup.
	self asyncFuture future: [ aBlock asStencil asElement ] asAsyncFuture
]

{ #category : #accessing }
BrAsyncWidget >> strategy: aStrategy [
	strategy := aStrategy
]
