Extension { #name : #BrAnchoredBottomLeftReferencePoint }

{ #category : #'*Brick-DevTool' }
BrAnchoredBottomLeftReferencePoint >> gtConfigureDropdownPreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignBottom.
	]
]

{ #category : #'*Brick-DevTool' }
BrAnchoredBottomLeftReferencePoint >> gtConfigureTooltipPreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignRight.
		c frame vertical alignTop.
	]
]
