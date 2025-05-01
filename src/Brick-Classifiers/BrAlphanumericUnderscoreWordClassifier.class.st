Class {
	#name : #BrAlphanumericUnderscoreWordClassifier,
	#superclass : #BrWordClassifier,
	#category : #'Brick-Classifiers'
}

{ #category : #classification }
BrAlphanumericUnderscoreWordClassifier >> value: c1 value: c2 [
	^ c1 isSeparator ~= c2 isSeparator
		or: [ c1 isIdentifierish ~= c2 isIdentifierish ]
]
