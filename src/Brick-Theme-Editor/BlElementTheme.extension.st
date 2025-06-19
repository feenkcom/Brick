Extension { #name : #BlElementTheme }

{ #category : #'*Brick-Theme-Editor' }
BlElementTheme >> gtThemeEditorFor: aView [
	<gtView>
	^ aView forward
		title: 'Theme';
		object: [ self theme ];
		view: #gtThemeEditorFor:
]
