Class {
	#name : #GtBlocThemeChangesElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'compositeChange',
		'relevantChanges',
		'changesPane',
		'applyChangesButton',
		'changesExecuted'
	],
	#category : #'Brick-Theme-Editor-UI'
}

{ #category : #'as yet unclassified' }
GtBlocThemeChangesElement >> createListOfChanges: eachChanges forChangesClass: eachChangeClass [
	| container |
	container := BrVerticalPane new.
	container
		hMatchParent;
		vFitContent.

	container addChild: (self createListOfChangesProtoHeader: eachChanges forChangesClass: eachChangeClass).

	container
		addChildren: (eachChanges collect: [ :eachChange | self createPreviewOfChange: eachChange ]).

	^ container
]

{ #category : #'as yet unclassified' }
GtBlocThemeChangesElement >> createListOfChangesProtoHeader: eachChanges forChangesClass: eachChangeClass [
	| aLabel |
	
	aLabel := BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		text: ('{1} {2}' format: { eachChanges size . eachChangeClass description uncapitalized });
		hMatchParent.
	
	aLabel
		when: BlClickEvent
		do: [ :anEvent |
			anEvent currentTarget
				allParentsDetect: [ :each | each isKindOf: BrExpander ]
				ifFound: [ :anExpander |
					anEvent consumed: true.
					anExpander toggleExpanded ] 
				ifNone: [ ] ].
	
	^ aLabel
]

{ #category : #'as yet unclassified' }
GtBlocThemeChangesElement >> createPreviewChanges: classChanges forClass: affectedClass [
	| label container groupedChanges|
	
	label := BrLabel new
		text: affectedClass;
		beSmallSize;
		aptitude: BrGlamorousMetadataLabelAptitude.
	
	container := BrVerticalPane new.
	container
		hMatchParent;
		vFitContent;
		addChild: label.
	
	groupedChanges := classChanges groupedBy: [ :each | each class ].
	groupedChanges := (groupedChanges associations
		sorted: [ :a :b | a key priority < b key priority ])
		asOrderedDictionary.
	
	groupedChanges keysAndValuesDo: [ :eachChangeClass :eachChanges |
		container addChild: (self
			createPreviewExpanderChanges: eachChanges
			forChangesClass:  eachChangeClass) ].

	^ container
]

{ #category : #'as yet unclassified' }
GtBlocThemeChangesElement >> createPreviewExpanderChanges: eachChanges forChangesClass: eachChangeClass [
	| anExpander |
	
	anExpander := BrExpander new
			hMatchParent;
			vFitContent;
			margin: (BlInsets top: 3 bottom: 3).

	anExpander
		header: [ self createListOfChangesProtoHeader: eachChanges forChangesClass: eachChangeClass ];
		content: [ self createListOfChanges: eachChanges forChangesClass: eachChangeClass ];
		aptitude: (GtCoderExpanderAptitude new).

	^ anExpander
]

{ #category : #'as yet unclassified' }
GtBlocThemeChangesElement >> createPreviewOfChange: eachChange [
	| namespace |
	namespace := RBNamespace new.
	eachChange applyOnNamespace: namespace.
	^ namespace changes changes first gtDiffChange asElement
]

{ #category : #'as yet unclassified' }
GtBlocThemeChangesElement >> executeChanges [
	changesExecuted
		ifTrue: [ ^ self ].

	changesExecuted := true.
	applyChangesButton disable.
	applyChangesButton label: 'Applied'.
	compositeChange changedNamespace changes execute.
	applyChangesButton
		addChangingColorAnimationFor: BrGlamorousColors successBackgroundColor
]

{ #category : #'as yet unclassified' }
GtBlocThemeChangesElement >> initialize [
	super initialize.
	
	self matchParent.
	self background: self theme default backdropBackground.
	
	changesExecuted := false.
	applyChangesButton := BrButton new
		label: 'Apply changes';
		icon: BrGlamorousVectorIcons accept;
		aptitude: BrGlamorousButtonWithIconAndLabelAptitude;
		margin: (BlInsets top: 10 left: 10);
		action: [ self executeChanges ].
	
	self addChild: applyChangesButton.
	
	changesPane := BrVerticalPane new
		hMatchParent;
		vFitContent;
		cellSpacing: 2.
	
	self addChild:(BrScrollPane new
		padding: (BlInsets top: 6 left: 10 bottom: 10 right: 10);
		aptitude: BrScrollPaneAptitude + BrGlamorousWithVerticalScrollbarAptitude;
		matchParent;
		content: changesPane)
]

{ #category : #'as yet unclassified' }
GtBlocThemeChangesElement >> themeChanges: aCompositeChange [
	compositeChange := aCompositeChange.
	
	relevantChanges := compositeChange relevantChanges.
	(relevantChanges groupedBy: [ :each| each affectedClass ])
		keysAndValuesDo: [ :affectedClass :classChanges |
			changesPane addChild: (self createPreviewChanges: classChanges forClass: affectedClass) ]
]
