Class {
	#name : #BrSmalltalkWordClassifier,
	#superclass : #BrWordClassifier,
	#category : #'Brick-Classifiers'
}

{ #category : #'as yet unclassified' }
BrSmalltalkWordClassifier >> itself [
	<gtExample>
	<return: #BrSmalltalkWordClassifier>
	^ self
]

{ #category : #classification }
BrSmalltalkWordClassifier >> value: c1 value: c2 [
	^ c1 isSeparator ~= c2 isSeparator
		or: [ (c1 isIdentifierish not and: [ c2 isIdentifierish ])
				or: [ c1 isIdentifierish and: [ c2 tokenish not ] ] ]
]
