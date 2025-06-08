Class {
	#name : #GtBlocThemeConstantAssignment,
	#superclass : #GtBlocThemePropertyAssignment,
	#category : #'Brick-Theme-Editor-Model'
}

{ #category : #comparing }
GtBlocThemeConstantAssignment >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ valueAst = anObject valueAst
		and: [ propertyName = anObject propertyName
				and: [ subThemeClass = anObject subThemeClass
						and: [ subThemeSelector = anObject subThemeSelector ] ] ]
]

{ #category : #'as yet unclassified' }
GtBlocThemeConstantAssignment >> generateAccessorSourceForSubThemeModel: aSubThemeModel [
	^ 'aTheme {1} constantAt: #{2}' format: { aSubThemeModel subThemeName . self propertyName }
]

{ #category : #comparing }
GtBlocThemeConstantAssignment >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ valueAst hash
		bitXor: (propertyName hash bitXor: (subThemeClass hash bitXor: subThemeSelector hash))
]

{ #category : #'as yet unclassified' }
GtBlocThemeConstantAssignment >> isConstantAssignment [
	^ true
]
