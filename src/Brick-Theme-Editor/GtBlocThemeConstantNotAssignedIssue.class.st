Class {
	#name : #GtBlocThemeConstantNotAssignedIssue,
	#superclass : #GtBlocThemeIssue,
	#instVars : [
		'typedThemeProperty',
		'subThemeClass',
		'subThemeModel'
	],
	#category : #'Brick-Theme-Editor-Issues'
}

{ #category : #'as yet unclassified' }
GtBlocThemeConstantNotAssignedIssue >> canFixIt [
	^ typedThemeProperty constantAssignments size = 1
]

{ #category : #accessing }
GtBlocThemeConstantNotAssignedIssue >> description [
	^ 'Constant is not assigned in {1}' format: { subThemeClass name }
]

{ #category : #'as yet unclassified' }
GtBlocThemeConstantNotAssignedIssue >> fixItForTheme: aTheme [
	| constantAssignment newConstantAssignment newThemeProperty newSubThemeModel |
	
	constantAssignment := typedThemeProperty constantAssignments first.
	newConstantAssignment := constantAssignment copyWithSubThemeClass: subThemeClass.
	
	newThemeProperty := typedThemeProperty themeProperty copy.
	newThemeProperty := newThemeProperty
		withNeighbourConstantAssignment: newConstantAssignment.
	
	newSubThemeModel := subThemeModel copy.
	newSubThemeModel
		replaceThemeProperty: typedThemeProperty themeProperty
		with: newThemeProperty.

	^ newSubThemeModel generateThemeChanges
]

{ #category : #accessing }
GtBlocThemeConstantNotAssignedIssue >> subThemeClass: anObject [
	subThemeClass := anObject
]

{ #category : #accessing }
GtBlocThemeConstantNotAssignedIssue >> subThemeModel: anObject [
	subThemeModel := anObject
]

{ #category : #accessing }
GtBlocThemeConstantNotAssignedIssue >> typedThemeProperty: anObject [
	typedThemeProperty := anObject
]
