Class {
	#name : #GtBlocThemeTooManyGettersIssue,
	#superclass : #GtBlocThemeIssue,
	#instVars : [
		'typedThemeProperty'
	],
	#category : #'Brick-Theme-Editor-Issues'
}

{ #category : #accessing }
GtBlocThemeTooManyGettersIssue >> description [
	^ 'Too many getters, must be just one'
]

{ #category : #accessing }
GtBlocThemeTooManyGettersIssue >> typedThemeProperty [
	^ typedThemeProperty
]

{ #category : #accessing }
GtBlocThemeTooManyGettersIssue >> typedThemeProperty: anObject [
	typedThemeProperty := anObject
]
