Class {
	#name : #BrThemeExamples,
	#superclass : #Object,
	#category : #'Brick-Theme-Examples'
}

{ #category : #accessing }
BrThemeExamples >> container [
	^ BlElement new
		layout: BlLinearLayout horizontal;
		padding: (BlInsets all: 5);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		yourself
]

{ #category : #examples }
BrThemeExamples >> customizedLabelColorsAfterThemeModified [
	<gtExample>
	<return: #BrGlamorousDarkTheme>
	| lightTheme darkTheme colors |
	lightTheme := BrGlamorousLightTheme new.
	darkTheme := BrGlamorousDarkTheme new.
	colors := {#metadataTextForeground -> Color cyan.
			#summaryTextForeground -> Color green.
			#navigationTextForeground -> Color magenta}.
	colors do: [ :entry | darkTheme label constantAt: entry key put: entry value ].
	darkTheme themeModified.
	colors
		do: [ :entry | 
			| paint |
			paint := lightTheme label perform: entry key.
			self assert: (paint blocResolveColorForTheme: darkTheme) equals: entry value ].
	^ darkTheme
]

{ #category : #examples }
BrThemeExamples >> itemAndLabelThemes [
	<gtExample>
	<return: #Array>
	| variants themes lightTheme |
	variants := {{BrGlamorousLightTheme new.
				BrGlamorousItemLightTheme.
				BrGlamorousLabelLightTheme}.
			{BrGlamorousDarkTheme new.
				BrGlamorousItemDarkTheme.
				BrGlamorousLabelDarkTheme}.
			{BrGlamorousNearWhiteTheme new.
				BrGlamorousItemNearWhiteTheme.
				BrGlamorousLabelNearWhiteTheme}}.
	themes := variants collect: [ :each | each first ].
	lightTheme := themes first.
	variants
		do: [ :each | 
			| theme |
			theme := each first.
			self assert: theme item class equals: each second.
			self assert: theme label class equals: each third.
			self assert: (theme item class includesSelector: #initializeConstants).
			self assert: (theme label class includesSelector: #initializeConstants).
			self assert: theme item theme == theme.
			self assert: theme label theme == theme.
			#(defaultTextForeground metadataTextForeground summaryTextForeground navigationTextForeground)
				do: [ :role | 
					| paint color |
					paint := theme label perform: role.
					color := theme label constantAt: role.
					self assert: (paint isKindOf: BlThemeableColor).
					self assert: (color isKindOf: Color).
					self assert: paint rawColor equals: color.
					self
						assert: ((lightTheme label perform: role) blocResolveColorForTheme: theme)
						equals: color ] ].
	^ themes
]

{ #category : #accessing }
BrThemeExamples >> listBaseline [
	<gtExample>
	<return: #BrSimpleList>
	| list |
	list := BrSimpleList vertical
			itemType: [ :aFactory :anItem :anIndex | Integer ];
			itemStencil: [ :anItemType | 
				BrButton new
					aptitude: BrGlamorousButtonWithLabelAptitude;
					yourself ];
			itemDataBinder: [ :anElement :anItem :anIndex | anElement label: anItem asString ];
			items: (1 to: 1000);
			yourself.
	^ list
]

{ #category : #accessing }
BrThemeExamples >> listLook [
	<gtExample>
	<return: #BrSimpleList>
	| list a b |
	a := BrThemeExampleMapped new
			at: BrButton put: #newGlamorousButtonLookFor:;
			yourself.
	b := BrThemeExampleMapped new
			at: BrButton put: #newMaterialButtonLookFor:;
			yourself.
	list := BrSimpleList vertical
			theme: a;
			itemType: [ :aFactory :anItem :anIndex | Integer ];
			itemStencil: [ :anItemType | 
				BrButton new
					aptitude: BrThemeableAptitude;
					action: [ list theme == a ifTrue: [ list theme: b ] ifFalse: [ list theme: a ] ];
					yourself ];
			itemDataBinder: [ :anElement :anItem :anIndex | anElement label: anItem asString ];
			items: (1 to: 1000);
			yourself.
	^ list
]

{ #category : #accessing }
BrThemeExamples >> listProfileAll [
	<gtExample>
	<noTest>
	^ {(self profile: self listBaseline named: #listBaseline).
	(self profile: self listElement named: #listElement).
	(self profile: self listLook named: #listLook).
	(self profile: self listProperty named: #listProperty)}
]

{ #category : #accessing }
BrThemeExamples >> listProperty [
	<gtExample>
	<return: #BrSimpleList>
	| list a b |
	a := BrThemeExampleMapped new
			at: BrButton put: #newGlamorousButtonLookFor:;
			yourself.
	b := BrThemeExampleMapped new
			at: BrButton put: #newMaterialButtonLookFor:;
			yourself.
	list := BrSimpleList vertical
			itemType: [ :aFactory :anItem :anIndex | Integer ];
			itemStencil: [ :anItemType | 
				BrButton new
					action: [ list theme == a ifTrue: [ list theme: b ] ifFalse: [ list theme: a ] ];
					yourself ];
			itemDataBinder: [ :anElement :anItem :anIndex | anElement label: anItem asString ];
			items: (1 to: 1000);
			yourself.
	list properties
		addProperty: (BrThemeElementProperty new
				theme: a;
				yourself).
	^ list
]

{ #category : #accessing }
BrThemeExamples >> profile: anElement named: aString [
	<gtExample>
	| scripter telemetry logger |
	scripter := BlScripter new
		element: anElement;
		yourself.
	telemetry := MemoryTelemetry new.
	scripter space telemetry: telemetry.
	logger := TelemetryLogger named: aString.
	logger start.
	scripter wait forEmptySpaceTaskQueue.
	100
		timesRepeat: [ scripter mouseWheel downBy: 25;
			play.
			scripter wait waitingBlock: [ :e | 8 milliSeconds wait ];
			play ].
	scripter wait forEmptySpaceTaskQueue;
			play.
	logger stop.
	^ logger
]
