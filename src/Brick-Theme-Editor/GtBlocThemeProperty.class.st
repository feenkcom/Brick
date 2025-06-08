Class {
	#name : #GtBlocThemeProperty,
	#superclass : #Object,
	#instVars : [
		'subThemeModel',
		'valueAssignments',
		'constantAssignments',
		'propertyName',
		'propertyValue',
		'propertyGetters',
		'definingSubThemeClass'
	],
	#category : #'Brick-Theme-Editor-Model'
}

{ #category : #accessing }
GtBlocThemeProperty >> constantAssignments [
	<return: #Array of: #GtBlocThemeConstantAssignment>
	^ constantAssignments
]

{ #category : #accessing }
GtBlocThemeProperty >> constantAssignments: aCollectionOfAssignments [
	self
		assert: [ constantAssignments isNil ]
		description: [ 'Can''t modify already assigned constants' ].
	self privateSetConstantAssignments: aCollectionOfAssignments
]

{ #category : #copying }
GtBlocThemeProperty >> copyAndTransformAssignmentsWith: aBlock [
	1
		to: valueAssignments size
		do: [ :index |
			| newAssignment |
			
			newAssignment := (valueAssignments at: index) copy.
			aBlock value: newAssignment.
			valueAssignments at: index put: newAssignment ]
]

{ #category : #'as yet unclassified' }
GtBlocThemeProperty >> copyReplaceConstantAssignment: aPreviousAssignment with: aNewAssignment [
	| newAsssignments |
	
	newAsssignments := self constantAssignments copyWithout: aPreviousAssignment.
	newAsssignments := newAsssignments copyWith: aNewAssignment.
	
	^ self copy
		privateSetConstantAssignments: newAsssignments;
		yourself
]

{ #category : #accessing }
GtBlocThemeProperty >> definingSubThemeClass [
	^ definingSubThemeClass
]

{ #category : #accessing }
GtBlocThemeProperty >> definingSubThemeClass: anObject [
	definingSubThemeClass := anObject
]

{ #category : #'ast  - analysis' }
GtBlocThemeProperty >> doesAstUseConstantGetter: anAst [

	anAst nodesDo: [ :eachNode |
		(eachNode isMessage and: [ eachNode selector = #constantAt: ])
			ifTrue: [ ^ true ] ].
			
	^ false
]

{ #category : #views }
GtBlocThemeProperty >> gtConstantAssignmentsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Constants';
		priority: 7;
		items: [ constantAssignments ];
		column: 'Name' text: [ :each | each propertyName ];
		column: 'Value' text: [ :each | each gtDisplayString ]
]

{ #category : #printing }
GtBlocThemeProperty >> gtDisplayOn: aStream [
	aStream nextPutAll: self propertyName
]

{ #category : #views }
GtBlocThemeProperty >> gtValueAssignmentsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Assignments';
		priority: 5;
		items: [ valueAssignments ];
		column: 'Name' text: [ :each | each propertyName ];
		column: 'Value' text: [ :each | each gtDisplayString ]
]

{ #category : #'ast  - analysis' }
GtBlocThemeProperty >> hardcodedValueAssignments [
	^ self valueAssignments reject: [ :eachAssignment |
		self doesAstUseConstantGetter: eachAssignment valueAst ]
]

{ #category : #copying }
GtBlocThemeProperty >> postCopy [
	valueAssignments := valueAssignments copy.
	constantAssignments := constantAssignments copy.
	propertyGetters := propertyGetters copy
]

{ #category : #accessing }
GtBlocThemeProperty >> printShortThemeableValue [
	| article className |
	
	className := self propertyValue class name.
	article := className first isVowel ifTrue: [ 'an' ] ifFalse: [ 'a' ].
	
	^ '{1} {2}' format: { article . className }
]

{ #category : #accessing }
GtBlocThemeProperty >> privateSetConstantAssignments: aCollectionOfAssignments [
	constantAssignments := aCollectionOfAssignments asArray
]

{ #category : #accessing }
GtBlocThemeProperty >> propertyGetters [
	^ propertyGetters
]

{ #category : #accessing }
GtBlocThemeProperty >> propertyGetters: aCollectionOfGetters [
	propertyGetters := aCollectionOfGetters asOrderedCollection
]

{ #category : #accessing }
GtBlocThemeProperty >> propertyName [
	^ propertyName
]

{ #category : #accessing }
GtBlocThemeProperty >> propertyName: aSymbol [
	propertyName := aSymbol
]

{ #category : #accessing }
GtBlocThemeProperty >> propertyValue [
	^ propertyValue
]

{ #category : #accessing }
GtBlocThemeProperty >> propertyValue: anObject [
	propertyValue := anObject
]

{ #category : #'as yet unclassified' }
GtBlocThemeProperty >> replaceValueAssignment: anAssignment with: anotherAssignment [
	| index |
	index:= self valueAssignments indexOf: anAssignment.
	self valueAssignments at: index put: anotherAssignment.
]

{ #category : #accessing }
GtBlocThemeProperty >> subThemeModel [
	^ subThemeModel
]

{ #category : #accessing }
GtBlocThemeProperty >> subThemeModel: anObject [
	subThemeModel := anObject
]

{ #category : #accessing }
GtBlocThemeProperty >> theme [
	^ self subThemeModel subTheme theme
]

{ #category : #accessing }
GtBlocThemeProperty >> valueAssignments [
	<return: #Collecton of: #GtBlocThemeValueAssignment>
	
	^ valueAssignments
]

{ #category : #accessing }
GtBlocThemeProperty >> valueAssignments: anObject [
	valueAssignments := anObject asOrderedCollection
]

{ #category : #accessing }
GtBlocThemeProperty >> valueType [
	^ GtBlocThemeTypedProperty detectTypeOf: self
]

{ #category : #'as yet unclassified' }
GtBlocThemeProperty >> withConstantAssignment: aConstantAssignment [
	^ self copy
		privateSetConstantAssignments: (self constantAssignments copyWith: aConstantAssignment);
		yourself
]

{ #category : #'as yet unclassified' }
GtBlocThemeProperty >> withoutConstantAssignment: aConstantAssignment [
	^ self copy
		privateSetConstantAssignments: (self constantAssignments copyWithout: aConstantAssignment);
		yourself
]
