Extension { #name : #BrAnchoredBottomCenterReferencePoint }

{ #category : #'*Brick-DevTool' }
BrAnchoredBottomCenterReferencePoint >> gtConfigureDropdownPreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignBottom.
	]
]

{ #category : #'*Brick-DevTool' }
BrAnchoredBottomCenterReferencePoint >> gtConfigureTooltipPreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignTop.
	]
]
