Extension { #name : #BrAnchoredCenterLeftReferencePoint }

{ #category : #'*Brick-DevTool' }
BrAnchoredCenterLeftReferencePoint >> gtConfigureDropdownPreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignCenter.
	]
]

{ #category : #'*Brick-DevTool' }
BrAnchoredCenterLeftReferencePoint >> gtConfigureTooltipPreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignRight.
		c frame vertical alignCenter.
	]
]
