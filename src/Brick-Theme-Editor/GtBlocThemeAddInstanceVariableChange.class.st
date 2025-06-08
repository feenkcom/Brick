Class {
	#name : #GtBlocThemeAddInstanceVariableChange,
	#superclass : #GtBlocThemeChange,
	#instVars : [
		'variableClass',
		'variableName'
	],
	#category : #'Brick-Theme-Editor-Model'
}

{ #category : #comparing }
GtBlocThemeAddInstanceVariableChange >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ variableName = anObject variableName
		and: [ variableClass = anObject variableClass ]
]

{ #category : #'as yet unclassified' }
GtBlocThemeAddInstanceVariableChange >> applyOnNamespace: aRBNamespace [
	aRBNamespace
		addInstanceVariable: variableName
		to: variableClass
]

{ #category : #comparing }
GtBlocThemeAddInstanceVariableChange >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ variableName hash bitXor: variableClass hash
]

{ #category : #'as yet unclassified' }
GtBlocThemeAddInstanceVariableChange >> isRedundantForNamespace: aRBNamespace [
	| existingClass |
	existingClass := aRBNamespace classNamed: variableClass name.
	^ (existingClass definesInstanceVariable: variableName)
]

{ #category : #accessing }
GtBlocThemeAddInstanceVariableChange >> variableClass [
	^ variableClass
]

{ #category : #accessing }
GtBlocThemeAddInstanceVariableChange >> variableClass: anObject [
	variableClass := anObject
]

{ #category : #accessing }
GtBlocThemeAddInstanceVariableChange >> variableName [
	^ variableName
]

{ #category : #accessing }
GtBlocThemeAddInstanceVariableChange >> variableName: anObject [
	variableName := anObject
]
