Class {
	#name : #GtBlocThemeValueNotAssignedIssue,
	#superclass : #GtBlocThemeIssue,
	#instVars : [
		'themeableValue'
	],
	#category : #'Brick-Theme-Editor-Issues'
}

{ #category : #accessing }
GtBlocThemeValueNotAssignedIssue >> description [
	^ 'Value is not assigned' format: { self themeableValue propertyName }
]

{ #category : #'as yet unclassified' }
GtBlocThemeValueNotAssignedIssue >> isSeriousIssue [
	^ true
]

{ #category : #accessing }
GtBlocThemeValueNotAssignedIssue >> themeableValue [
	^ themeableValue
]

{ #category : #accessing }
GtBlocThemeValueNotAssignedIssue >> themeableValue: anObject [
	themeableValue := anObject
]
