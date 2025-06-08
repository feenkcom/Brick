Class {
	#name : #GtBlocThemeablePropertyHardcodedIssue,
	#superclass : #GtBlocThemeIssue,
	#instVars : [
		'typedThemeableProperty',
		'valueAssignment',
		'subThemeModel'
	],
	#category : #'Brick-Theme-Editor-Issues'
}

{ #category : #'as yet unclassified' }
GtBlocThemeablePropertyHardcodedIssue >> canFixIt [
	(typedThemeableProperty isThemeableType)
		ifFalse: [ ^ false ].
		
	(typedThemeableProperty extractPropertyConstantAst: valueAssignment)
		ifNil: [ ^ false ].
		
	^ true
]

{ #category : #accessing }
GtBlocThemeablePropertyHardcodedIssue >> description [
	^ 'Hardcoded value' format: { typedThemeableProperty propertyName }
]

{ #category : #'as yet unclassified' }
GtBlocThemeablePropertyHardcodedIssue >> fixItForTheme: aTheme [
	| newThemeProperty subThemeModelCopy hardcodedValueAst newAssignment newConstantAssignment newValueAst |
	
	typedThemeableProperty isThemeableType
		ifFalse: [ ^ nil ].

	hardcodedValueAst := typedThemeableProperty
		extractPropertyConstantAst: valueAssignment.
	
	subThemeModelCopy := subThemeModel copy.
	
	newConstantAssignment := GtBlocThemeConstantAssignment new
		subThemeClass: valueAssignment subThemeClass;
		subThemeSelector: #initializeConstants;
		valueName: typedThemeableProperty propertyName;
		valueAst: hardcodedValueAst;
		yourself.
	
	newThemeProperty := typedThemeableProperty themeProperty copy.

	newValueAst := RBParser parseExpression:
		typedThemeableProperty generateThemeableInitializationSource.
	
	newAssignment := valueAssignment copy.
	newAssignment valueAst: newValueAst.
	
	newThemeProperty
		replaceValueAssignment: valueAssignment
		with: newAssignment.
		
	newThemeProperty := newThemeProperty withConstantAssignment: newConstantAssignment.

	subThemeModelCopy
		replaceThemeProperty: typedThemeableProperty themeProperty
		with: newThemeProperty.

	^ subThemeModelCopy generateThemeMethods
]

{ #category : #accessing }
GtBlocThemeablePropertyHardcodedIssue >> subThemeModel: anObject [
	subThemeModel := anObject
]

{ #category : #accessing }
GtBlocThemeablePropertyHardcodedIssue >> typedThemeableProperty: anObject [
	typedThemeableProperty := anObject
]

{ #category : #accessing }
GtBlocThemeablePropertyHardcodedIssue >> valueAssignment: anObject [
	valueAssignment := anObject
]
