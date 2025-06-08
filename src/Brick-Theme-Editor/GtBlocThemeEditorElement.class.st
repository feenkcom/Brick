"
```
GtBlocThemeEditorElement new editTheme: BlTheme default
```
"
Class {
	#name : #GtBlocThemeEditorElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'editorsPane',
		'themeModel'
	],
	#category : #'Brick-Theme-Editor-UI'
}

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> createForSubThemeEditor: eachSubThemeModel subTheme: eachSubTheme [
	^ GtBlocSubThemeEditorElement new
		subThemeModel: eachSubThemeModel
		subTheme: eachSubTheme
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> editTheme: aBlTheme [
	themeModel := GtBlocThemeModel new initializeForTheme: aBlTheme.
	
	editorsPane removeChildren.
	editorsPane addChildren: (themeModel subThemesAndModels
		collect: [ :eachAssociation | self createForSubThemeEditor: eachAssociation value subTheme: eachAssociation key ])
]

{ #category : #'as yet unclassified' }
GtBlocThemeEditorElement >> initialize [
	super initialize.
	
	self matchParent.
	self background: self theme default backdropBackground.
	
	editorsPane := BrVerticalPane new
		hMatchParent;
		vFitContent;
		cellSpacing: 2.
	
	self addChild:(BrScrollPane new
		padding: (BlInsets all: 10);
		aptitude: BrScrollPaneAptitude + BrGlamorousWithVerticalScrollbarAptitude;
		matchParent;
		content: editorsPane)
]
