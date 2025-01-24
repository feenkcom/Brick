"
I indicate that another menu was closed inside of an existing menu.
"
Class {
	#name : #BrMenuIsHiddenEvent,
	#superclass : #BrChangeEvent,
	#instVars : [
		'menuModel',
		'menuContainer'
	],
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #accessing }
BrMenuIsHiddenEvent >> menuContainer [
	^ menuContainer
]

{ #category : #accessing }
BrMenuIsHiddenEvent >> menuContainer: anObject [
	menuContainer := anObject
]

{ #category : #accessing }
BrMenuIsHiddenEvent >> menuModel [
	^ menuModel
]

{ #category : #accessing }
BrMenuIsHiddenEvent >> menuModel: anObject [
	menuModel := anObject
]
