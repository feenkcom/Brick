"
Subclasses define algorithm for determining the boundaries of words during cursor movement and selectino
"
Class {
	#name : #AbstractWordClassifier,
	#superclass : #Object,
	#category : #'Brick-Classifiers'
}

{ #category : #classification }
AbstractWordClassifier >> value: c1 value: c2 [
	"Returns true if a word boundary occurs between c1 and c2 (left to right)"
	self subclassResponsibility
]
