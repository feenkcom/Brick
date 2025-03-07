Class {
	#name : #BrMenuElementClassType,
	#superclass : #BlInfiniteItemType,
	#instVars : [
		'elementClass'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #comparing }
BrMenuElementClassType >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	(anObject class = self class)
		ifFalse: [ ^ false ].
	^ anObject elementClass = self elementClass
]

{ #category : #'api - instance creation' }
BrMenuElementClassType >> createElement [
	<return: #BlElement>
	^ self elementClass new
]

{ #category : #accessing }
BrMenuElementClassType >> elementClass [
	^ elementClass
]

{ #category : #accessing }
BrMenuElementClassType >> elementClass: anObject [
	elementClass := anObject
]

{ #category : #comparing }
BrMenuElementClassType >> hash [
	^ self elementClass hash
]
