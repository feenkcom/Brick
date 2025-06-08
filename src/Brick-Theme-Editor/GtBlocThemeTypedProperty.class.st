Class {
	#name : #GtBlocThemeTypedProperty,
	#superclass : #Object,
	#instVars : [
		'themeProperty',
		'issues'
	],
	#category : #'Brick-Theme-Editor-Model'
}

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty class >> detectTypeClassOf: aThemeProperty [
	(GtBlocThemeableColorProperty matchesThemeProperty: aThemeProperty)
		ifTrue: [ ^ GtBlocThemeableColorProperty ].

	(aThemeProperty propertyValue isKindOf: Color)
		ifTrue: [ ^ GtBlocThemeStaticColorType ].

	^ GtBlocThemeUnknownType
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty class >> detectTypeOf: aThemeableValue [
	^ (self detectTypeClassOf: aThemeableValue) new initializeForThemeProperty: aThemeableValue
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> constantAssignments [
	^ self themeProperty constantAssignments
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> createCoderViewModel: aCoderModel coderAssignment: aCoderAssignment subThemeModel: aSubThemeModel [
	| valueSourceCoderViewModel|
	
	valueSourceCoderViewModel := aCoderModel asCoderViewModel.
	^ valueSourceCoderViewModel
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> createCoderViewModel: anAssignmentForCoder subThemeModel: aSubThemeModel [
	| valueSourceCoder |
	
	valueSourceCoder := GtPharoSnippetCoder
		forSource: anAssignmentForCoder valueSourceCode.
	
	^ self
		createCoderViewModel: valueSourceCoder
		coderAssignment: anAssignmentForCoder
		subThemeModel: aSubThemeModel
]

{ #category : #accessing }
GtBlocThemeTypedProperty >> initializeForThemeProperty: aThemeProperty [
	themeProperty := aThemeProperty
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> isStaticType [
	^ false
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> isThemeableType [
	^ false
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> isUnknownType [
	^ false
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> issuesOn: aStream withinSubThemeModel: aSubThemeModel [
	self isThemeableType
		ifFalse: [ aStream nextPut: (GtBlocThemeValueNotThemeableIssue new
			subThemeModel: aSubThemeModel;
			typedThemeProperty: self) ].
	
	self valueAssignments
		ifEmpty: [ aStream nextPut: (GtBlocThemeValueNotAssignedIssue new themeableValue: self themeProperty) ].
		
	self propertyGetters
		ifEmpty: [ aStream nextPut: (GtBlocThemePropertyNoGetterIssue new typedThemeProperty: self) ].
	
	self valueAssignments size > 1
		ifTrue: [ aStream nextPut: (GtBlocThemeTooManyAssignmentsIssue new typedThemeProperty: self) ].
		
	self propertyGetters size > 1
		ifTrue: [ aStream nextPut: (GtBlocThemeTooManyGettersIssue new typedThemeProperty: self) ]
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> issuesWithinSubThemeModel: aSubThemeModel [
	issues ifNotNil: [ :theIssues | ^ theIssues ].
	issues := Array streamContents: [ :s | self issuesOn: s withinSubThemeModel: aSubThemeModel ].
	^ issues
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> postCopy [
	themeProperty := themeProperty copy.
	issues := nil
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> printPropertyAccessor: useGlobal [
	^ '{1} {2} {3}' format: {
		useGlobal
			ifTrue: [ 'BlTheme default' ]
			ifFalse: [ 'self theme' ].
		self subThemeName.
		self propertyName
	}
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> printShortThemeableValue [
	^ self themeProperty printShortThemeableValue
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> propertyGetters [
	^ self themeProperty propertyGetters
]

{ #category : #accessing }
GtBlocThemeTypedProperty >> propertyName [
	^ self themeProperty propertyName
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> propertyValue [
	^ themeProperty propertyValue
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> subThemeModel [
	self shouldNotImplement
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> subThemeName [
	^ themeProperty subThemeName
]

{ #category : #accessing }
GtBlocThemeTypedProperty >> themeProperty [
	^ themeProperty
]

{ #category : #accessing }
GtBlocThemeTypedProperty >> themeableValue [
	^ themeProperty
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> transformAssignmentForCoder: aThemeableAssignment subThemeModel: aSubThemeModel [
	^ aThemeableAssignment
]

{ #category : #'as yet unclassified' }
GtBlocThemeTypedProperty >> valueAssignments [
	^ self themeProperty valueAssignments
]
