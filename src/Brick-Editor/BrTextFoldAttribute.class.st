Class {
	#name : #BrTextFoldAttribute,
	#superclass : #BrTextHideAttribute,
	#category : #'Brick-Editor-Attributes'
}

{ #category : #'as yet unclassified' }
BrTextFoldAttribute >> initialize [
	super initialize.
	alignmentMode := #fold
]

{ #category : #'as yet unclassified' }
BrTextFoldAttribute >> shouldReplace [
	^true
]
