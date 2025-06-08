Class {
	#name : #GtBlocThemeConstantAssignment,
	#superclass : #GtBlocThemePropertyAssignment,
	#category : #'Brick-Theme-Editor-Model'
}

{ #category : #'as yet unclassified' }
GtBlocThemeConstantAssignment >> generateAccessorSourceForSubThemeModel: aSubThemeModel [
	^ 'aTheme {1} constantAt: #{2}' format: { aSubThemeModel subThemeName . self propertyName }
]

{ #category : #'as yet unclassified' }
GtBlocThemeConstantAssignment >> isConstantAssignment [
	^ true
]
