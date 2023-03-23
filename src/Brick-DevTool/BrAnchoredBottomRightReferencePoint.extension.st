Extension { #name : #BrAnchoredBottomRightReferencePoint }

{ #category : #'*Brick-DevTool' }
BrAnchoredBottomRightReferencePoint >> gtConfigureDropdownPreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignRight.
		c frame vertical alignBottom.
	]
]

{ #category : #'*Brick-DevTool' }
BrAnchoredBottomRightReferencePoint >> gtConfigureTooltipPreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignTop.
	]
]
