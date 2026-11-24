Class {
	#name : #BrGlamorousWithMaximizerAptitude,
	#superclass : #BrWithMaximizerAptitude,
	#instVars : [
		'actionButton',
		'showMaximizeButton'
	],
	#category : #'Brick-Glamorous-Maximizer'
}

{ #category : #accessing }
BrGlamorousWithMaximizerAptitude >> actionButton: anElement [
	| aButton |
	aButton := anElement asStencil.
	aButton action: [ self maximize ].

	self widgetDo: [ :aWidget | 
		aWidget replaceChild: actionButton with: aButton ].

	actionButton := aButton
]

{ #category : #accessing }
BrGlamorousWithMaximizerAptitude >> actionButtonDo: aBlock [
	actionButton ifNotNil: aBlock
]

{ #category : #initialization }
BrGlamorousWithMaximizerAptitude >> createActionButton [
	^ GtInspectorRoundButtonStencil new asElement
		icon: BrGlamorousVectorIcons add;
		exact: 16 @ 16
]

{ #category : #'api - visibility' }
BrGlamorousWithMaximizerAptitude >> hideMaximizeButton [
	showMaximizeButton := false.
	actionButton visibility: BlVisibility gone
]

{ #category : #initialization }
BrGlamorousWithMaximizerAptitude >> initialize [
	super initialize.

	showMaximizeButton := true.

	actionButton := self createActionButton.
	actionButton action: [ self maximize ].

	actionButton constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignCenterAt: 0.
		c ignored vertical alignCenterAt: 0 ].
	actionButton zIndex: 100.

	self addChangeAddChild: #() with: [ actionButton ].
	self addChangeProperty: #(widget clipChildren) with: false
]

{ #category : #'private - hooks' }
BrGlamorousWithMaximizerAptitude >> onMaximized [
	super onMaximized.

	actionButton visibility: BlVisibility gone
]

{ #category : #'private - hooks' }
BrGlamorousWithMaximizerAptitude >> onMinimized [
	super onMinimized.

	showMaximizeButton
		ifFalse: [ ^ self ].
	actionButton visibility: BlVisibility visible
]

{ #category : #'api - visibility' }
BrGlamorousWithMaximizerAptitude >> showMaximizeButton [
	showMaximizeButton := true.
	
	self isMaximized
		ifFalse: [ actionButton visibility: BlVisibility visible ]
]
