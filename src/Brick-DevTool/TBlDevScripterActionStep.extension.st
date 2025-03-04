Extension { #name : #TBlDevScripterActionStep }

{ #category : #'*Brick-DevTool' }
TBlDevScripterActionStep >> addDropdownVisualAnalysis [
	^ self do
		referenceSender;
		label: 'Setup dropdown visual analysis';
		block: [ :anElement :aUserData | 
			aUserData
				at: BrAnchoredVisualAnalysis
				put: (BrAnchoredVisualAnalysis new elementWithDropdown: anElement) ];
		onParentStepTarget: self
]

{ #category : #'*Brick-DevTool' }
TBlDevScripterActionStep >> prepareSteppedLayoutAnalyzerFor: aMenuAptitudeClass [
	^ self do
		referenceSender;
		label: 'Prepare stepped layout analyser';
		block: [ :aButton :aUserData | 
			aButton
				aptitudeDo: [ :anAptitude | 
					anAptitude
						withAllActorsBreadthFirstDo: [ :eachAptitude | 
							(eachAptitude isKindOf: aMenuAptitudeClass)
								ifTrue: [ 
									| anAnalyzer |
									anAnalyzer := BlSteppedLayoutLastStateAnalyzer new.
									anAnalyzer menuContainer: eachAptitude menuContainer.
									eachAptitude menuContainer layout analyzer: anAnalyzer.
									aUserData at: BlSteppedLayoutLastStateAnalyzer put: anAnalyzer ] ] ] ]
]

{ #category : #'*Brick-DevTool' }
TBlDevScripterActionStep >> prepareSteppedLayoutDropdownAnalyzer [
	^ (self prepareSteppedLayoutAnalyzerFor: BrWithExplicitDropdownAptitude)
		referenceSender
]
