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
