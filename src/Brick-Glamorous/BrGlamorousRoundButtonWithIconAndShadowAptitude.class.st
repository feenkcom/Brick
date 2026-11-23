"
I style a circular button with an icon and a theme-aware shadow.
"
Class {
	#name : #BrGlamorousRoundButtonWithIconAndShadowAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'buttonStyle',
		'shadowEnabled'
	],
	#category : #'Brick-Glamorous-Buttons'
}

{ #category : #initialization }
BrGlamorousRoundButtonWithIconAndShadowAptitude >> initialize [
	super initialize.
	shadowEnabled := true.
	self
		addChangeProperty: #(widgetContent layout)
		with: [ BlLinearLayout horizontal alignCenter ].
	self
		addChangeProperty: #(widgetContent geometry)
		with: [ BlCircleGeometry new ].
	self add: BrGlamorousButtonIconAptitude new.
	buttonStyle := BrLazyStyleCommonAptitude new
			default: [ :aStyle :aTheme | 
				aStyle
					background: aTheme default contentBackground;
					border: BlBorder empty;
					effect: (self shadowWithColor: aTheme default defaultShadowColor) ];
			focused: [ :aStyle :aTheme | aStyle effect: (self shadowWithColor: aTheme default primaryShadowColor) ];
			yourself.
	self add: buttonStyle
]

{ #category : #initialization }
BrGlamorousRoundButtonWithIconAndShadowAptitude >> initializeListeners [
	super initializeListeners.
	self
		when: BrIconChanged
		do: [ self widgetDo: [ :aButton | aButton requestStyle ] ]
]

{ #category : #accessing }
BrGlamorousRoundButtonWithIconAndShadowAptitude >> shadowEnabled: aBoolean [
	shadowEnabled = aBoolean ifTrue: [ ^ self ].
	buttonStyle updateWith: [ shadowEnabled := aBoolean ]
]

{ #category : #initialization }
BrGlamorousRoundButtonWithIconAndShadowAptitude >> shadowWithColor: aColor [
	^ shadowEnabled
		ifTrue: [ BlGaussianShadowEffect
				color: aColor
				width: 2
				offset: 0 @ 1 ]
		ifFalse: [ BlNullEffect new ]
]
