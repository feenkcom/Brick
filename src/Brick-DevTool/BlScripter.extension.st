Extension { #name : #BlScripter }

{ #category : #'*Brick-DevTool' }
BlScripter >> gtAnchoredContainerOverviewFor: aView [
	<gtView>
	self userData at: BrAnchoredVisualAnalysis ifAbsent: [ ^ aView empty ].

	^ aView forward
		title: 'Dropdown Analysis';
		priority: -1;
		object: [ self userData at: BrAnchoredVisualAnalysis ];
		view: #gtSpaceFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Details'
			tooltip: 'Inspect dropdown analysis details'
			action: [ :aButton | aButton phlow spawnObject: (self userData at: BrAnchoredVisualAnalysis) ]
]
