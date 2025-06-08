Class {
	#name : #GtBlocThemeTooManyAssignmentsIssue,
	#superclass : #GtBlocThemeIssue,
	#instVars : [
		'typedThemeProperty'
	],
	#category : #'Brick-Theme-Editor-Issues'
}

{ #category : #accessing }
GtBlocThemeTooManyAssignmentsIssue >> description [
	^ 'Too many assignments, must be just one'
]

{ #category : #accessing }
GtBlocThemeTooManyAssignmentsIssue >> typedThemeProperty [
	^ typedThemeProperty
]

{ #category : #accessing }
GtBlocThemeTooManyAssignmentsIssue >> typedThemeProperty: anObject [
	typedThemeProperty := anObject
]
