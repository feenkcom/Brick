Class {
	#name : #BrMenuElementClassType,
	#superclass : #BlInfiniteItemType,
	#instVars : [
		'elementClass',
		'decorator'
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
	| anElement |
	anElement := self elementClass new.
	self decorator ifNotNil: [ :aBlock | aBlock cull: anElement ].
	^ anElement
]

{ #category : #accessing }
BrMenuElementClassType >> decorator [
	^ decorator
]

{ #category : #accessing }
BrMenuElementClassType >> decorator: anObject [
	decorator := anObject
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
