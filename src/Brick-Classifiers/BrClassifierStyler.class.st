Class {
	#name : #BrClassifierStyler,
	#superclass : #BlTextStyler,
	#instVars : [
		'classifier'
	],
	#category : #'Brick-Classifiers'
}

{ #category : #'as yet unclassified' }
BrClassifierStyler class >> for: aClassifier [ 
	^ self new classifier: aClassifier
]

{ #category : #'as yet unclassified' }
BrClassifierStyler >> classifier: aClassifier [ 
	classifier := aClassifier
]

{ #category : #'as yet unclassified' }
BrClassifierStyler >> privateStyle: aText [
	| pieces index |
	pieces := aText asString piecesCutWhere: classifier.
	index := 0.
	pieces
		doWithIndex: [ :p :pieceIndex | 
			| newColor |
			newColor := BrGlamorousColors distinctTenLightColors at: (pieceIndex \\ BrGlamorousColors distinctTenLightColors size) + 1.
			(aText from: index + 1 to: index + p size)
				highlight: newColor twiceLighter lighter.
			index := index + p size].
	^ aText
]
