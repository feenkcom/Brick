Class {
	#name : #BrCamelCaseWordClassifier,
	#superclass : #BrWordClassifier,
	#category : #'Brick-Classifiers'
}

{ #category : #classification }
BrCamelCaseWordClassifier >> value: c1 value: c2 [
	^ c1 isSeparator ~= c2 isSeparator
		or: [ c1 isIdentifierish ~= c2 isIdentifierish
				or: [ c1 isUppercase not and: [ c2 isUppercase ] ] ]
]
