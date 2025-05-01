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
	pieces := aText asString piecesCutWhere: BrCamelCaseWordClassifier new.
	index := 0.
	pieces
		do: [ :p | 
			(aText from: index + 1 to: index + p size)
				highlight: BrGlamorousColors distinctTenLightColors atRandom twiceLighter twiceLighter.
			index := index + p size ].
	^ aText
]
