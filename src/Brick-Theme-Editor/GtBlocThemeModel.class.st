Class {
	#name : #GtBlocThemeModel,
	#superclass : #Object,
	#instVars : [
		'subThemeModels',
		'theme',
		'themeClass'
	],
	#category : #'Brick-Theme-Editor-Model'
}

{ #category : #accessing }
GtBlocThemeModel class >> theme: aBlTheme [
	^ self new initializeForTheme: aBlTheme 
]

{ #category : #views }
GtBlocThemeModel >> gtSubThemeModelsFor: aView [
	<gtView>
	^ aView forward
		title: 'Sub-Themes';
		priority: 3;
		object: [ subThemeModels values ];
		view: #gtItemsFor:
]

{ #category : #'as yet unclassified' }
GtBlocThemeModel >> initializeForTheme: aBlTheme [
	theme := aBlTheme.
	themeClass := aBlTheme class.
	
	subThemeModels := (Array streamContents: [ :s |
		themeClass allInstVarNames do: [ :eachVar |
			| eachVarValue |
			eachVarValue := theme instVarNamed: eachVar.
			(eachVarValue isKindOf: BlSubTheme)
				ifTrue: [ s nextPut: eachVarValue -> (GtBlocSubThemeModel new subTheme: eachVarValue name: eachVar) ] ] ]) asOrderedDictionary.
]

{ #category : #accessing }
GtBlocThemeModel >> subThemeModels [
	^ subThemeModels values
]

{ #category : #accessing }
GtBlocThemeModel >> subThemesAndModels [
	^ subThemeModels associations
]

{ #category : #'as yet unclassified' }
GtBlocThemeModel >> theme [
	^ theme
]
