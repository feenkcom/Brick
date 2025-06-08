Class {
	#name : #GtBlocThemePropertyNoGetterIssue,
	#superclass : #GtBlocThemeIssue,
	#instVars : [
		'typedThemeProperty'
	],
	#category : #'Brick-Theme-Editor-Issues'
}

{ #category : #accessing }
GtBlocThemePropertyNoGetterIssue >> description [
	^ 'There is no property getter'
]

{ #category : #'as yet unclassified' }
GtBlocThemePropertyNoGetterIssue >> isSeriousIssue [
	^ true
]

{ #category : #accessing }
GtBlocThemePropertyNoGetterIssue >> typedThemeProperty [
	^ typedThemeProperty
]

{ #category : #accessing }
GtBlocThemePropertyNoGetterIssue >> typedThemeProperty: anObject [
	typedThemeProperty := anObject
]
