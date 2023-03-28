Extension { #name : #BrAnchoredTopRightReferencePoint }

{ #category : #'*Brick-DevTool' }
BrAnchoredTopRightReferencePoint >> gtConfigureDropdownPreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignRight.
		c frame vertical alignTop.
	]
]

{ #category : #'*Brick-DevTool' }
BrAnchoredTopRightReferencePoint >> gtConfigureTooltipPreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignBottom.
	]
]
