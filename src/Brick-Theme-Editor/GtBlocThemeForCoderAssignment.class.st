Class {
	#name : #GtBlocThemeForCoderAssignment,
	#superclass : #GtBlocThemePropertyAssignment,
	#instVars : [
		'originalAssignment',
		'themeValue'
	],
	#category : #'Brick-Theme-Editor-Model'
}

{ #category : #'as yet unclassified' }
GtBlocThemeForCoderAssignment >> asCoderAssignmentFor: aThemeValue [
	^ self
]

{ #category : #'as yet unclassified' }
GtBlocThemeForCoderAssignment >> isConstantAssignment [
	^ self originalAssignment isConstantAssignment
]

{ #category : #accessing }
GtBlocThemeForCoderAssignment >> originalAssignment [
	^ originalAssignment
]

{ #category : #accessing }
GtBlocThemeForCoderAssignment >> originalAssignment: anObject [
	originalAssignment := anObject
]

{ #category : #accessing }
GtBlocThemeForCoderAssignment >> themeValue [
	^ themeValue
]

{ #category : #accessing }
GtBlocThemeForCoderAssignment >> themeValue: anObject [
	themeValue := anObject
]
