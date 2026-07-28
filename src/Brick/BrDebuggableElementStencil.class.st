Class {
	#name : #BrDebuggableElementStencil,
	#superclass : #BrStencil,
	#instVars : [
		'exception'
	],
	#category : #'Brick-Debugger'
}

{ #category : #'api - instantiation' }
BrDebuggableElementStencil >> create [
	<return: #BlElement>
	| aLabel aButton aContainer |
	aLabel := self createDebugLabel.
	aButton := self createDebugButton.
	aContainer := BlElement new
		layout: BlLinearLayout horizontal;
		id: BrDebuggableElementContentId;
		constraintsDo: [ :c | 
			c horizontal fitContentLimited.
			c vertical fitContent.
			c frame horizontal alignCenter.
			c frame vertical alignCenter ];
		addChildren: {aLabel. aButton}.
	^ BrFrame new
		matchParent;
		addChild: aContainer;
		in: [ :anElement | 
			anElement userData at: #exception put: self exception ];
		yourself
]

{ #category : #'api - instantiation' }
BrDebuggableElementStencil >> createDebugButton [
	^ BrButton new
		hFitContent;
		vFitContent;
		aptitude: BrGlamorousButtonWithIconAptitude new;
		icon: BrGlamorousVectorIcons debug;
		label: 'Open debugger';
		id: BrDebuggableElementOpenDebuggerButtonId;
		beTinySize;
		constraintsDo: [ :c | 
			c linear vertical alignCenter ];
		action: self newDebugAction
]

{ #category : #'api - instantiation' }
BrDebuggableElementStencil >> createDebugLabel [
	^ BrButton new
		hFitContentLimited;
		vFitContent;
		label: self newTextLabel;
		aptitude: BrGlamorousLabelAptitude new;
		id: BrDebuggableElementExceptionMessageId;
		margin: (BlInsets right: 6);
		constraintsDo: [ :c | 
			c linear vertical alignCenter.
			c linear horizontal alignLeft ];
		action: self newDebugAction
]

{ #category : #accessing }
BrDebuggableElementStencil >> exception [
	^ exception
]

{ #category : #accessing }
BrDebuggableElementStencil >> exception: anException [
	exception := anException
]

{ #category : #accessing }
BrDebuggableElementStencil >> freeze: anException [
	| anExceptionCopy |
	
	anExceptionCopy := anException copy.
	
	anExceptionCopy signalContext
		ifNotNil: [ anExceptionCopy freeze ].
	self exception: anExceptionCopy
]

{ #category : #'instance creation' }
BrDebuggableElementStencil >> newDebugAction [

	^ [ 
	  [ 
	  UIManager default
		  gtDebugProcess: Processor activeProcess
		  context:
		  (self exception signalerContext ifNil: [ 
			   self exception signalContext ])
		  label: self exception description
		  fullView: true
		  notification: nil
		  forException: self exception ] forkNamed: 'Debug' ]
]

{ #category : #'instance creation' }
BrDebuggableElementStencil >> newTextLabel [
	^ self exception printString asRopedText 
		glamorousCodeFontAndSmallSize;
		foreground: BrGlamorousColors linkWithErrorColor
]
