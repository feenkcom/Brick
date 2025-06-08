Class {
	#name : #GtBlocThemeStaticProperty,
	#superclass : #GtBlocThemeTypedProperty,
	#category : #'Brick-Theme-Editor-Model'
}

{ #category : #'as yet unclassified' }
GtBlocThemeStaticProperty >> isStaticType [
	^ true
]

{ #category : #'as yet unclassified' }
GtBlocThemeStaticProperty >> transformToThemeable [
	^ nil
]
