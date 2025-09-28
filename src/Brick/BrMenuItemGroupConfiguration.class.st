Class {
	#name : #BrMenuItemGroupConfiguration,
	#superclass : #Object,
	#instVars : [
		'name',
		'priority'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #factory }
BrMenuItemGroupConfiguration class >> debugger [
	^ self new
		name: #Debugger;
		priority: 20
]

{ #category : #factory }
BrMenuItemGroupConfiguration class >> default [
	^ self new
]

{ #category : #factory }
BrMenuItemGroupConfiguration class >> editing [
	^ self new
		name: #Editing;
		priority: 48
]

{ #category : #factory }
BrMenuItemGroupConfiguration class >> evaluation [
	^ self new
		name: #Evaluation;
		priority: 47
]

{ #category : #factory }
BrMenuItemGroupConfiguration class >> gemstone [
	^ self new
		name: #GemStone;
		priority: 40
]

{ #category : #factory }
BrMenuItemGroupConfiguration class >> inspection [
	^ self new
		name: #Inspection;
		priority: 40
]

{ #category : #factory }
BrMenuItemGroupConfiguration class >> modification [
	^ self new
		name: #Modification;
		priority: 35
]

{ #category : #factory }
BrMenuItemGroupConfiguration class >> navigation [
	^ self new
		name: #Navigation;
		priority: 20
]

{ #category : #factory }
BrMenuItemGroupConfiguration class >> refactoring [
	^ self new
		name: #Refactoring;
		priority: 30
]

{ #category : #factory }
BrMenuItemGroupConfiguration class >> removal [
	^ self new
		name: #Removal;
		priority: 100
]

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
