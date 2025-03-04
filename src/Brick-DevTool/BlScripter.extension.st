Extension { #name : #BlScripter }

{ #category : #'*Brick-DevTool' }
BlScripter >> gtAnchoredContainerOverviewFor: aView [
	<gtView>
	self userData at: BrAnchoredVisualAnalysis ifAbsent: [ ^ aView empty ].

	^ aView forward
		title: 'Dropdown analysis';
		priority: -1;
		object: [ self userData at: BrAnchoredVisualAnalysis ];
		view: #gtSpaceFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Details'
			tooltip: 'Inspect dropdown analysis details'
			action: [ :aButton | aButton phlow spawnObject: (self userData at: BrAnchoredVisualAnalysis) ]
]

{ #category : #'*Brick-DevTool' }
BlScripter >> gtMenuSteppedLayoutAnalysisFor: aView [
	<gtView>
	self userData at: BlSteppedLayoutLastStateAnalyzer ifAbsent: [ ^ aView empty ].

	^ aView forward
		title: 'Menu analysis';
		tooltip: 'Dropdown, context menu, and tooltip stepped layout analysis';
		priority: -1;
		object: [ self userData at: BlSteppedLayoutLastStateAnalyzer ];
		view: #gtAreasPreviewFor:context:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Details'
			tooltip: 'Inspect menu analysis details'
			action: [ :aButton | aButton phlow spawnObject: (self userData at: BlSteppedLayoutLastStateAnalyzer) ]
]
