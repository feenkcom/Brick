Class {
	#name : #GtBlocThemeCompileMethodChange,
	#superclass : #GtBlocThemeChange,
	#instVars : [
		'methodClass',
		'methodSelector',
		'methodSourceCode',
		'methodProtocol'
	],
	#category : #'Brick-Theme-Editor-Model'
}

{ #category : #comparing }
GtBlocThemeCompileMethodChange >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ methodSourceCode = anObject methodSourceCode
		and: [ methodClass = anObject methodClass
				and: [ methodProtocol = anObject methodProtocol
						and: [ methodSelector = anObject methodSelector ] ] ]
]

{ #category : #'as yet unclassified' }
GtBlocThemeCompileMethodChange >> applyOnNamespace: aRBNamespace [	
	aRBNamespace
		compile: methodSourceCode
		in: methodClass
		classified: methodProtocol
]

{ #category : #comparing }
GtBlocThemeCompileMethodChange >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ methodSourceCode hash
		bitXor: (methodClass hash bitXor: (methodProtocol hash bitXor: methodSelector hash))
]

{ #category : #'as yet unclassified' }
GtBlocThemeCompileMethodChange >> isRedundantForNamespace: aRBNamespace [
	| existingMethod |
	
	existingMethod := (aRBNamespace classNamed: methodClass name)
		methodFor: methodSelector.
	
	^ existingMethod isNotNil and: [
		existingMethod source = methodSourceCode
			and: [ existingMethod protocols includes: methodProtocol ] ]
]

{ #category : #accessing }
GtBlocThemeCompileMethodChange >> methodClass [
	^ methodClass
]

{ #category : #accessing }
GtBlocThemeCompileMethodChange >> methodClass: anObject [
	methodClass := anObject
]

{ #category : #accessing }
GtBlocThemeCompileMethodChange >> methodProtocol [
	^ methodProtocol
]

{ #category : #accessing }
GtBlocThemeCompileMethodChange >> methodProtocol: anObject [
	methodProtocol := anObject
]

{ #category : #accessing }
GtBlocThemeCompileMethodChange >> methodSelector [
	^ methodSelector
]

{ #category : #accessing }
GtBlocThemeCompileMethodChange >> methodSelector: anObject [
	methodSelector := anObject
]

{ #category : #accessing }
GtBlocThemeCompileMethodChange >> methodSourceCode [
	^ methodSourceCode
]

{ #category : #accessing }
GtBlocThemeCompileMethodChange >> methodSourceCode: anObject [
	methodSourceCode := anObject
]
