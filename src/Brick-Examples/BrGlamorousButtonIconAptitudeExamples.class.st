"
Scripter examples for theme-aware vector button icons, interactive states, and replacement by image icons.
"
Class {
	#name : #BrGlamorousButtonIconAptitudeExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Button'
}

{ #category : #private }
BrGlamorousButtonIconAptitudeExamples >> assertIconColor: aSelector in: aScripter [
	aScripter
		checkStep: [ :step | 
			step
				label: 'The vector icon uses the button theme color';
				// #icon;
				do: [ :icon | 
					self
						assert: (icon background paint color blocResolveColorForTheme: icon theme)
						equals: ((aScripter element theme button perform: aSelector)
								blocResolveColorForTheme: icon theme) ] ]
]

{ #category : #examples }
BrGlamorousButtonIconAptitudeExamples >> darkTheme [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self scripterWithTheme: BrGlamorousDarkTheme new.
	self assertIconColor: #defaultTextForeground in: scripter.
	^ scripter
]

{ #category : #examples }
BrGlamorousButtonIconAptitudeExamples >> disabled [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self lightTheme.
	scripter
		doStep: [ :step | 
			step
				// #button;
				block: [ :button | button disable ] ].
	self assertIconColor: #disabledTextColor in: scripter.
	^ scripter
]

{ #category : #examples }
BrGlamorousButtonIconAptitudeExamples >> hovered [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self lightTheme.
	scripter mouseMoveOverStep: [ :step | step // #button ].
	self assertIconColor: #hoveredTextColor in: scripter.
	^ scripter
]

{ #category : #examples }
BrGlamorousButtonIconAptitudeExamples >> imageIconKeepsBackground [
	<gtExample>
	<return: #BlScripter>
	| scripter image originalBackground |
	scripter := self lightTheme.
	image := BrGlamorousIcons up asElement.
	originalBackground := image background.
	scripter
		doStep: [ :step | 
			step
				// #button;
				block: [ :button | button icon: image ] ].
	scripter
		checkStep: [ :step | 
			step
				// #icon;
				do: [ :icon | self assert: icon background == originalBackground ] ].
	^ scripter
]

{ #category : #examples }
BrGlamorousButtonIconAptitudeExamples >> lightTheme [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self scripterWithTheme: BrGlamorousLightTheme new.
	self assertIconColor: #defaultTextForeground in: scripter.
	^ scripter
]

{ #category : #examples }
BrGlamorousButtonIconAptitudeExamples >> pressed [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self hovered.
	scripter mouseDown play.
	self assertIconColor: #pressedTextColor in: scripter.
	^ scripter
]

{ #category : #examples }
BrGlamorousButtonIconAptitudeExamples >> replaceImageWithVectorIcon [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self imageIconKeepsBackground.
	scripter
		doStep: [ :step | 
			step
				// #button;
				block: [ :button | button icon: BrGlamorousVectorIcons down ] ].
	self assertIconColor: #defaultTextForeground in: scripter.
	^ scripter
]

{ #category : #examples }
BrGlamorousButtonIconAptitudeExamples >> replaceVectorIcon [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self lightTheme.
	scripter
		doStep: [ :step | 
			step
				// #button;
				block: [ :button | button icon: BrGlamorousVectorIcons down ] ].
	self assertIconColor: #defaultTextForeground in: scripter.
	^ scripter
]

{ #category : #private }
BrGlamorousButtonIconAptitudeExamples >> scripterWithTheme: aTheme [
	| scripter button |
	button := BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousVectorIcons up;
			label: 'Previous';
			action: [  ];
			fitContent;
			yourself.
	scripter := BlScripter new.
	scripter extent: 220 @ 100.
	scripter
		element: (BrHorizontalPane new
				theme: aTheme;
				background: aTheme default contentBackground;
				matchParent;
				alignCenter;
				addChild: button as: #button;
				yourself).
	^ scripter
]

{ #category : #examples }
BrGlamorousButtonIconAptitudeExamples >> switchTheme [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self lightTheme.
	scripter
		doStep: [ :step | 
			step
				label: 'Switch the rendered button to dark theme';
				block: [ :element | element theme: BrGlamorousDarkTheme new ] ].
	self assertIconColor: #defaultTextForeground in: scripter.
	^ scripter
]
