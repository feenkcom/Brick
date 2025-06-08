Class {
	#name : #GtBlocThemePropertyGetter,
	#superclass : #Object,
	#instVars : [
		'subThemeClass',
		'propertyName',
		'getterAst'
	],
	#category : #'Brick-Theme-Editor-Model'
}

{ #category : #accessing }
GtBlocThemePropertyGetter >> getterAst [
	^ getterAst
]

{ #category : #accessing }
GtBlocThemePropertyGetter >> getterAst: anObject [
	getterAst := anObject
]

{ #category : #'as yet unclassified' }
GtBlocThemePropertyGetter >> getterSourceCode [
	^ self getterAst formattedCode
]

{ #category : #accessing }
GtBlocThemePropertyGetter >> propertyName [
	^ propertyName
]

{ #category : #accessing }
GtBlocThemePropertyGetter >> propertyName: anObject [
	propertyName := anObject
]

{ #category : #accessing }
GtBlocThemePropertyGetter >> subThemeClass [
	^ subThemeClass
]

{ #category : #accessing }
GtBlocThemePropertyGetter >> subThemeClass: anObject [
	subThemeClass := anObject
]

{ #category : #'as yet unclassified' }
GtBlocThemePropertyGetter >> subThemeMethod [
	^ subThemeClass >> propertyName
]

{ #category : #accessing }
GtBlocThemePropertyGetter >> valueAst [
	^ valueAst
]

{ #category : #'as yet unclassified' }
GtBlocThemePropertyGetter >> valueSourceCode [
	^ self valueAst formattedCode
]
