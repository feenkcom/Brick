Class {
	#name : #BrCamelCaseWordClassifier,
	#superclass : #BrWordClassifier,
	#category : #'Brick-Classifiers'
}

{ #category : #'as yet unclassified' }
BrCamelCaseWordClassifier >> itself [
	<gtExample>
	<return: #BrCamelCaseWordClassifier>
	^ self
]

{ #category : #classification }
BrCamelCaseWordClassifier >> value: c1 value: c2 [
	^ c1 isSeparator ~= c2 isSeparator
		or: [ c1 isAlphaNumeric ~= c2 isAlphaNumeric
				or: [ c1 isUppercase not and: [ c2 isUppercase ] ] ]
]
