Class {
	#name : #BrAsyncWidget,
	#superclass : #BrFrame,
	#instVars : [
		'pendingBlock',
		'errorBlock',
		'successBlock',
		'beLazy',
		'postAction',
		'stencil',
		'session'
	],
	#category : #'Brick-Async-Widget'
}

{ #category : #initialization }
BrAsyncWidget >> defaultErrorBlock [

	^ [ :anError | anError asDebuggableElement matchParent ]
]

{ #category : #initialization }
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
				   beSmallSize;
				   icon: BrGlamorousVectorIcons cancel;
				   action: [ aFuture cancelHard interrupt ]) ]
]

{ #category : #initialization }
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

{ #category : #initialization }
BrAsyncWidget >> initialize [
	super initialize.

	self fitContent.

	self withAsyncFutureDo: [ :anElementFuture | 
		anElementFuture
			strategy: self defaultStrategy;
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
			whenSuccess: [ :theContainer :theElement | 
				session := Smalltalk session.
				theContainer removeChildren.
				theContainer addChild: theElement.
				postAction ifNotNil: [ postAction value: theContainer ] ] ]
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
BrAsyncWidget >> stencil: aBlock [
	| aStencil |

	stencil := aStencil := aBlock asStencil.
	self asyncFuture future: [ aStencil asElement ] asAsyncFuture
]

{ #category : #accessing }
BrAsyncWidget >> strategy: aStrategy [
	self asyncFuture strategy: aStrategy
]
