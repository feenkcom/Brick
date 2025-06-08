Class {
	#name : #GtBlocThemeConstantNotAssignedIssue,
	#superclass : #GtBlocThemeIssue,
	#instVars : [
		'typedThemeProperty',
		'subThemeClass'
	],
	#category : #'Brick-Theme-Editor-Issues'
}

{ #category : #'as yet unclassified' }
GtBlocThemeConstantNotAssignedIssue >> canFixIt [
	^ true
]

{ #category : #accessing }
GtBlocThemeConstantNotAssignedIssue >> description [
	^ 'Constant is not assigned in {1}' format: { self subThemeClass name }
]

{ #category : #'as yet unclassified' }
GtBlocThemeConstantNotAssignedIssue >> fixIt [
	^ nil
]

{ #category : #accessing }
GtBlocThemeConstantNotAssignedIssue >> subThemeClass [
	^ subThemeClass
]

{ #category : #accessing }
GtBlocThemeConstantNotAssignedIssue >> subThemeClass: anObject [
	subThemeClass := anObject
]

{ #category : #accessing }
GtBlocThemeConstantNotAssignedIssue >> typedThemeProperty [
	^ typedThemeProperty
]

{ #category : #accessing }
GtBlocThemeConstantNotAssignedIssue >> typedThemeProperty: anObject [
	typedThemeProperty := anObject
]
