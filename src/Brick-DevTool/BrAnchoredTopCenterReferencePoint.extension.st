Extension { #name : #BrAnchoredTopCenterReferencePoint }

{ #category : #'*Brick-DevTool' }
BrAnchoredTopCenterReferencePoint >> gtConfigureDropdownPreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignBottom.
	]
]

{ #category : #'*Brick-DevTool' }
BrAnchoredTopCenterReferencePoint >> gtConfigureTooltipPreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignBottom.
	]
]
