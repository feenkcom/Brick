Class {
	#name : #BrMenuItemGroupConfiguration,
	#superclass : #Object,
	#instVars : [
		'name',
		'priority'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #accessing }
BrMenuItemGroupConfiguration >> id [
	^ self name
]

{ #category : #initialization }
BrMenuItemGroupConfiguration >> initialize [
	super initialize.
	priority := 50.
	name := #Default
]

{ #category : #accessing }
BrMenuItemGroupConfiguration >> name [
	^ name
]

{ #category : #accessing }
BrMenuItemGroupConfiguration >> name: anObject [
	name := anObject
]

{ #category : #printing }
BrMenuItemGroupConfiguration >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self name asString;
		nextPut: $)
]

{ #category : #accessing }
BrMenuItemGroupConfiguration >> priority [
	^ priority
]

{ #category : #accessing }
BrMenuItemGroupConfiguration >> priority: anObject [
	priority := anObject
]
