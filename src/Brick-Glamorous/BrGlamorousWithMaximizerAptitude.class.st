Class {
	#name : #BrGlamorousWithMaximizerAptitude,
	#superclass : #BrWithMaximizerAptitude,
	#instVars : [
		'actionButton',
		'showMaximizeButton'
	],
	#category : #'Brick-Glamorous-Maximizer'
}

{ #category : #initialization }
BrGlamorousWithMaximizerAptitude >> createActionButton [
	^ BrButton new
		background: Color white;
		aptitude: BrIconAptitude + BrGlamorousFocusableShadowAptitude + (BrStyleCommonAptitude new
			default: [ :s | s background: Color white ];
			hovered: [ :s | s background: Color veryVeryLightGray lighter ];
			pressed: [ :s | s background: Color veryVeryLightGray ]);
		geometry: BlEllipseGeometry new;
		layout: BlLinearLayout horizontal alignCenter;
		icon: (BrPlusIconStencil new radius: 4);
		size: 16@16
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
	actionButton action: [
		isMaximized
			ifFalse: [ self maximize ] ].

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
