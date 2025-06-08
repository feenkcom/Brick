Class {
	#name : #GtBlocThemeValueNotThemeableIssue,
	#superclass : #GtBlocThemeIssue,
	#instVars : [
		'typedThemeProperty',
		'subThemeModel'
	],
	#category : #'Brick-Theme-Editor-Issues'
}

{ #category : #'as yet unclassified' }
GtBlocThemeValueNotThemeableIssue >> canFixIt [
	typedThemeProperty valueAssignments size > 1
		ifTrue: [ ^ false ].

	^ typedThemeProperty isStaticType
]

{ #category : #accessing }
GtBlocThemeValueNotThemeableIssue >> description [
	^ 'Not a themeable value' format: { typedThemeProperty propertyName }
]

{ #category : #'as yet unclassified' }
GtBlocThemeValueNotThemeableIssue >> fixItForTheme: aTheme [
	typedThemeProperty isStaticType ifFalse: [ ^ nil ].

	^ typedThemeProperty
		transformToThemeable: aTheme
		withinSubThemeModel: subThemeModel
]

{ #category : #accessing }
GtBlocThemeValueNotThemeableIssue >> subThemeModel: anObject [
	subThemeModel := anObject
]

{ #category : #accessing }
GtBlocThemeValueNotThemeableIssue >> typedThemeProperty: anObject [
	typedThemeProperty := anObject
]
