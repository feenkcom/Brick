Class {
	#name : #BrFromStreamData,
	#superclass : #Object,
	#instVars : [
		'allValues',
		'newValues'
	],
	#category : #'Brick-Future - Support'
}

{ #category : #accessing }
BrFromStreamData >> allValues [

	^ allValues
]

{ #category : #accessing }
BrFromStreamData >> allValues: anObject [

	allValues := anObject
]

{ #category : #accessing }
BrFromStreamData >> newValues [

	^ newValues
]

{ #category : #accessing }
BrFromStreamData >> newValues: anObject [

	newValues := anObject
]
