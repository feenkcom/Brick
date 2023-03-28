Extension { #name : #BrAnchoredTopLeftReferencePoint }

{ #category : #'*Brick-DevTool' }
BrAnchoredTopLeftReferencePoint >> gtConfigureDropdownPreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignTop.
	]
]

{ #category : #'*Brick-DevTool' }
BrAnchoredTopLeftReferencePoint >> gtConfigureTooltipPreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignRight.
		c frame vertical alignBottom.
	]
]
