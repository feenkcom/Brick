Extension { #name : #BrAnchoredCenterReferencePoint }

{ #category : #'*Brick-DevTool' }
BrAnchoredCenterReferencePoint >> gtConfigureDropdownPreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignCenter.
	]
]

{ #category : #'*Brick-DevTool' }
BrAnchoredCenterReferencePoint >> gtConfigureTooltipPreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignCenter.
	]
]
