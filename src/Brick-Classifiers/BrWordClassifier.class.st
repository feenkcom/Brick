"
Subclasses define algorithm for determining the boundaries of words during cursor movement and selectino
"
Class {
	#name : #BrWordClassifier,
	#superclass : #Object,
	#category : #'Brick-Classifiers'
}

{ #category : #'as yet unclassified' }
BrWordClassifier >> gtHighlightingFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Highlighting';
		aptitude: BrGlamorousCodeEditorAptitude;
		text: 'wordWithCamelCase_and_underscore
	"Smalltalk comment"

	aSomething := aSomethingElse 
		doWith: [ :a | a value ] 
		andWith: ((Something named: ''something'');
		andThenSometingElse';
		styler: [ BrClassifierStyler for: self ]
]

{ #category : #classification }
BrWordClassifier >> value: c1 value: c2 [
	"Returns true if a word boundary occurs between c1 and c2 (left to right)"
	self subclassResponsibility
]
