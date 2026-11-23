Class {
	#name : #BrGlamorousRoundButtonWithIconAndShadowAptitudeExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Button'
}

{ #category : #asserting }
BrGlamorousRoundButtonWithIconAndShadowAptitudeExamples >> assertRoundButtonIn: aScripter hovered: isHovered focused: isFocused [
	| aTheme aShadowColor anIconColor |
	aTheme := aScripter element theme.
	aShadowColor := isFocused
			ifTrue: [ aTheme default primaryShadowColor ]
			ifFalse: [ aTheme default defaultShadowColor ].
	anIconColor := isHovered
			ifTrue: [ aTheme button hoveredTextColor ]
			ifFalse: [ aTheme button defaultTextForeground ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the circular button geometry, fill, border and shadow';
				// #roundButton;
				value: [ :aButton | 
						{aButton geometry class.
							aButton size.
							aButton background paint color blocResolveColorForTheme: aTheme.
							aButton border isTransparent.
							aButton effect color blocResolveColorForTheme: aTheme.
							aButton states hasState: BlElementState hovered.
							aButton states hasState: BlElementState focused} ]
					equals: {BlCircleGeometry.
							20 @ 20.
							aTheme default contentBackground blocResolveColorForTheme: aTheme.
							true.
							aShadowColor blocResolveColorForTheme: aTheme.
							isHovered.
							isFocused} ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check the round button icon foreground';
				// #roundButton;
				// #icon;
				value: [ :anIcon | anIcon background paint color blocResolveColorForTheme: aTheme ]
					equals: (anIconColor blocResolveColorForTheme: aTheme) ]
]

{ #category : #examples }
BrGlamorousRoundButtonWithIconAndShadowAptitudeExamples >> darkRoundButton [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripterWithTheme: BrGlamorousDarkTheme new.
	self
		assertRoundButtonIn: aScripter
		hovered: false
		focused: false.
	^ aScripter
]

{ #category : #examples }
BrGlamorousRoundButtonWithIconAndShadowAptitudeExamples >> focused [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self hovered.
	aScripter
		doStep: [ :aStep | 
			aStep
				label: 'Focus the round button';
				// #roundButton;
				block: [ :aButton | aButton requestFocus ] ].
	self
		assertRoundButtonIn: aScripter
		hovered: true
		focused: true.
	^ aScripter
]

{ #category : #examples }
BrGlamorousRoundButtonWithIconAndShadowAptitudeExamples >> hovered [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self darkRoundButton.
	aScripter mouseMoveOverStep: [ :aStep | aStep // #roundButton ].
	self
		assertRoundButtonIn: aScripter
		hovered: true
		focused: false.
	^ aScripter
]

{ #category : #examples }
BrGlamorousRoundButtonWithIconAndShadowAptitudeExamples >> replaceIconInDarkTheme [
	<gtExample>
	<return: #BlScripter>
	| aScripter anIcon |
	aScripter := self darkRoundButton.
	anIcon := BrGlamorousVectorIcons downwards asElement.
	aScripter
		doStep: [ :aStep | 
			aStep
				label: 'Replace the round button icon in dark mode';
				// #roundButton;
				block: [ :aButton | aButton icon: anIcon ] ].
	aScripter
		checkStep: [ :aStep | 
			aStep
				label: 'Check that the replacement is displayed';
				// #roundButton;
				// #icon;
				value: [ :anElement | anElement == anIcon ] equals: true ].
	self
		assertRoundButtonIn: aScripter
		hovered: false
		focused: false.
	^ aScripter
]

{ #category : #support }
BrGlamorousRoundButtonWithIconAndShadowAptitudeExamples >> scripterWithTheme: aTheme [
	| aButton |
	aButton := GtInspectorRoundButtonStencil new asElement
			id: #roundButton;
			beFocusable;
			exact: 20 @ 20;
			icon: BrGlamorousVectorIcons maximize;
			yourself.
	^ BlScripter new
		element: (BrHorizontalPane new
				theme: aTheme;
				padding: (BlInsets all: 24);
				size: 120 @ 90;
				addChild: aButton;
				yourself)
]

{ #category : #examples }
BrGlamorousRoundButtonWithIconAndShadowAptitudeExamples >> switchTheme [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self darkRoundButton.
	aScripter
		doStep: [ :aStep | 
			aStep
				label: 'Apply the light theme to the rendered round button';
				block: [ :anElement | anElement theme: BrGlamorousLightTheme new ] ].
	self
		assertRoundButtonIn: aScripter
		hovered: false
		focused: false.
	^ aScripter
]
