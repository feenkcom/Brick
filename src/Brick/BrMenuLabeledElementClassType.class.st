Class {
	#name : #BrMenuLabeledElementClassType,
	#superclass : #BlInfiniteItemType,
	#instVars : [
		'elementClass',
		'labelElementClass',
		'decorator'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #comparing }
BrMenuLabeledElementClassType >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	(anObject class = self class)
		ifFalse: [ ^ false ].
	^ anObject elementClass = self elementClass
		and: [ anObject labelElementClass = self labelElementClass ]
]

{ #category : #'api - instance creation' }
BrMenuLabeledElementClassType >> createElement [
	<return: #BlElement>
	| anElement |
	anElement := self elementClass new labelElementClass: self labelElementClass.
	self decorator ifNotNil: [ :aBlock | aBlock cull: anElement ].
	^ anElement
]

{ #category : #accessing }
BrMenuLabeledElementClassType >> decorator [
	^ decorator
]

{ #category : #accessing }
BrMenuLabeledElementClassType >> decorator: anObject [
	decorator := anObject
]

{ #category : #accessing }
BrMenuLabeledElementClassType >> elementClass [
	^ elementClass
]

{ #category : #accessing }
BrMenuLabeledElementClassType >> elementClass: anObject [
	elementClass := anObject
]

{ #category : #comparing }
BrMenuLabeledElementClassType >> hash [
	^ self elementClass hash bitXor: self labelElementClass hash
]

{ #category : #accessing }
BrMenuLabeledElementClassType >> labelElementClass [
	^ labelElementClass
]

{ #category : #accessing }
BrMenuLabeledElementClassType >> labelElementClass: anObject [
	labelElementClass := anObject
]
