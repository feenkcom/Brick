Class {
	#name : #BrDummyObjectForTextStyling,
	#superclass : #Object,
	#instVars : [
		'slotOne'
	],
	#category : #'Brick-Editor-Examples-Styler'
}

{ #category : #accessing }
BrDummyObjectForTextStyling >> methodOne: arg [
	slotOne := [:x|x] value: arg
]
