Extension { #name : #BrAnchoredCenterRightReferencePoint }

{ #category : #'*Brick-DevTool' }
BrAnchoredCenterRightReferencePoint >> gtConfigureDropdownPreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignRight.
		c frame vertical alignCenter.
	]
]

{ #category : #'*Brick-DevTool' }
BrAnchoredCenterRightReferencePoint >> gtConfigureTooltipPreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignCenter.
	]
]
