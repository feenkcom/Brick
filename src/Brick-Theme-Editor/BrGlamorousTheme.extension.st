Extension { #name : #BrGlamorousTheme }

{ #category : #'*Brick-Theme-Editor' }
BrGlamorousTheme >> gtThemeEditorFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Theme';
		priority: 5;
		stencil: [ GtBlocThemeEditorElement new editTheme: self ];
		actionUpdateButton
]
