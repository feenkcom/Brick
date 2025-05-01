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
	| pieces index previousColor |
	pieces := aText asString piecesCutWhere: classifier.
	index := 0.
	previousColor := Color white.
	pieces
		do: [ :p | 
			| newColor |
			newColor := (BrGlamorousColors distinctTenLightColors
					remove: previousColor ifAbsent: [  ];
					yourself) atRandom.
			(aText from: index + 1 to: index + p size)
				highlight: newColor twiceLighter lighter.
			index := index + p size.
			previousColor := newColor ].
	^ aText
]
