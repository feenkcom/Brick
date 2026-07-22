Extension { #name : #TBlDevScripterActionStep }

{ #category : #'*Brick-Editor-Examples' }
TBlDevScripterActionStep >> editor [
	<scripterActionStep>
	
	^ self
		addStep: (BrEditorStep new
				label: 'Editor';
				referenceSender)
]
