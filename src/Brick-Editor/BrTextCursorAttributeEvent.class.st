Class {
	#name : 'BrTextCursorAttributeEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'interval'
	],
	#category : 'Brick-Editor-Attributes - Support'
}

{ #category : 'accessing' }
BrTextCursorAttributeEvent >> attributeEnd [
	^ interval last
]

{ #category : 'accessing' }
BrTextCursorAttributeEvent >> attributeStart [
	^ interval first
]

{ #category : 'accessing' }
BrTextCursorAttributeEvent >> interval [

	^ interval
]

{ #category : 'accessing' }
BrTextCursorAttributeEvent >> interval: anObject [

	interval := anObject
]
