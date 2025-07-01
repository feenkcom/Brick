Class {
	#name : #BrDebuggableEditorElementStencil,
	#superclass : #BrStencil,
	#instVars : [
		'exception'
	],
	#category : #'Brick-Debugger'
}

{ #category : #'api - instantiation' }
BrDebuggableEditorElementStencil >> create [
	<return: #BlElement>
	| aLabel aButton aContainer |
	aLabel := BrEditor new beReadOnlyWithSelection
		hFitContentLimited;
		vFitContent;
		text: self newTextLabel;
		aptitude: BrGlamorousEditorAptitude new;
		margin: (BlInsets right: 6);
		constraintsDo: [ :c | 
			c linear vertical alignCenter.
			c linear horizontal alignLeft ];
		when: BlClickEvent do: self newDebugAction.
	aButton := self createDebugButton.
	aContainer := BlElement new
		layout: BlLinearLayout horizontal;
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
BrDebuggableEditorElementStencil >> createDebugButton [
	^ BrButton new
		hFitContent;
		vFitContent;
		aptitude: BrGlamorousButtonWithIconAptitude new;
		icon: BrGlamorousVectorIcons debug;
		label: 'Open debugger';
		beTinySize;
		constraintsDo: [ :c | 
			c linear vertical alignCenter ];
		action: self newDebugAction
]

{ #category : #accessing }
BrDebuggableEditorElementStencil >> exception [
	^ exception
]

{ #category : #accessing }
BrDebuggableEditorElementStencil >> exception: anException [
	exception := anException
]

{ #category : #accessing }
BrDebuggableEditorElementStencil >> freeze: anException [
	| anExceptionCopy |
	
	anExceptionCopy := anException copy.
	
	anExceptionCopy signalContext
		ifNotNil: [ anExceptionCopy freeze ].
	self exception: anExceptionCopy
]

{ #category : #'instance creation' }
BrDebuggableEditorElementStencil >> newDebugAction [

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
BrDebuggableEditorElementStencil >> newTextLabel [
	^ self exception printString asRopedText 
		glamorousCodeFontAndSmallSize;
		foreground: BrGlamorousColors linkWithErrorColor
]
