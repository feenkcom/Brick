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
