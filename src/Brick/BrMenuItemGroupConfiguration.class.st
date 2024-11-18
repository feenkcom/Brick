Class {
	#name : #BrMenuItemGroupConfiguration,
	#superclass : #Object,
	#instVars : [
		'name',
		'priority'
	],
	#category : #'Brick-Menu'
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

{ #category : #accessing }
BrMenuItemGroupConfiguration >> priority [
	^ priority
]

{ #category : #accessing }
BrMenuItemGroupConfiguration >> priority: anObject [
	priority := anObject
]
