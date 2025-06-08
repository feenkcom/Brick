Class {
	#name : #GtBlocThemeConstantAssignedTooHighIssue,
	#superclass : #GtBlocThemeIssue,
	#instVars : [
		'typedThemeProperty',
		'constantAssignment',
		'subThemeModel'
	],
	#category : #'Brick-Theme-Editor-Issues'
}

{ #category : #'as yet unclassified' }
GtBlocThemeConstantAssignedTooHighIssue >> canFixIt [
	^ true
]

{ #category : #accessing }
GtBlocThemeConstantAssignedTooHighIssue >> constantAssignment: anObject [
	constantAssignment := anObject
]

{ #category : #accessing }
GtBlocThemeConstantAssignedTooHighIssue >> description [
	^ 'Constant assigned too high in the hierarchy'
]

{ #category : #'as yet unclassified' }
GtBlocThemeConstantAssignedTooHighIssue >> fixItForTheme: aTheme [
	| sourceClass targetClass copyToClasses previousClass currentClass newSubThemeModel compositeChange |
	
	sourceClass := constantAssignment subThemeClass.
	targetClass := subThemeModel subThemeClass.
	self
		assert: [ targetClass inheritsFrom: sourceClass ]
		description: [ 'Target class must inherit from the source class' ].
	
	copyToClasses := OrderedCollection new.
	previousClass := targetClass.
	currentClass := targetClass superclass.
	[ previousClass = sourceClass ]
		whileFalse: [ copyToClasses addAll: (currentClass subclasses copyWithout: previousClass).
			previousClass := currentClass.
			currentClass := currentClass superclass ].
	
	compositeChange := GtBlocThemeCompositeChange new.
	
	newSubThemeModel := self
		moveConstantAssignmentsOPropertyNamed: constantAssignment propertyName
		fromClass: sourceClass
		to: targetClass
		in: subThemeModel copy.
	newSubThemeModel changesOn: compositeChange.
	
	copyToClasses do: [ :eachSubThemeClass |
		| eachSubThemeModel |
		
		eachSubThemeModel := newSubThemeModel instantiateNewSubThemeModel: eachSubThemeClass.
		eachSubThemeModel := self
			moveConstantAssignmentsOPropertyNamed: constantAssignment propertyName
			fromClass: sourceClass
			to: eachSubThemeClass
			in: eachSubThemeModel.
		
		eachSubThemeModel changesOn: compositeChange ].
	
	
	^ compositeChange changedNamespace
]

{ #category : #'as yet unclassified' }
GtBlocThemeConstantAssignedTooHighIssue >> moveConstantAssignmentsOPropertyNamed: aPropertyName fromClass: sourceClass to: targetClass in: aSubThemeModel [
	aSubThemeModel
		themePropertyNamed: aPropertyName
		ifFound: [ :existingThemeProperty |
			| newThemeProperty assignmentsToMove|
			
			newThemeProperty := existingThemeProperty copy.
			assignmentsToMove := newThemeProperty constantAssignments
				select: [ :eachAssignment | eachAssignment subThemeClass = sourceClass ].
			
			assignmentsToMove do: [ :eachAssignment |
				newThemeProperty := newThemeProperty
					copyReplaceConstantAssignment: eachAssignment
					with: (eachAssignment copyWithSubThemeClass: targetClass) ].
			
			aSubThemeModel
				replaceThemeProperty: existingThemeProperty
				with: newThemeProperty ].
				
	^ aSubThemeModel
]

{ #category : #accessing }
GtBlocThemeConstantAssignedTooHighIssue >> subThemeModel: anObject [
	subThemeModel := anObject
]

{ #category : #accessing }
GtBlocThemeConstantAssignedTooHighIssue >> typedThemeProperty: anObject [
	typedThemeProperty := anObject
]
