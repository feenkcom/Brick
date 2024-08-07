Extension { #name : #TBlDevScripterActionStep }

{ #category : #'*Brick-Editor-Examples' }
TBlDevScripterActionStep >> editor [
	^ self
		addStep: (BrEditorStep new
				label: 'Editor';
				referenceSender)
]
