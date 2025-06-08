Class {
	#name : #GtBlocThemeChangesElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'compositeChange',
		'relevantChanges'
	],
	#category : #'Brick-Theme-Editor-UI'
}

{ #category : #'as yet unclassified' }
GtBlocThemeChangesElement >> themeChanges: aCompositeChange [
	compositeChange := aCompositeChange.
	
	relevantChanges := compositeChange relevantChangesByType.
	relevantChanges
]
