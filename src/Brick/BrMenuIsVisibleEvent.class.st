"
I indicate that another menu is opened inside of existing menu.
"
Class {
	#name : #BrMenuIsVisibleEvent,
	#superclass : #BrChangeEvent,
	#instVars : [
		'menuModel',
		'menuContainer'
	],
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #accessing }
BrMenuIsVisibleEvent >> menuContainer [
	^ menuContainer
]

{ #category : #accessing }
BrMenuIsVisibleEvent >> menuContainer: anObject [
	menuContainer := anObject
]

{ #category : #accessing }
BrMenuIsVisibleEvent >> menuModel [
	^ menuModel
]

{ #category : #accessing }
BrMenuIsVisibleEvent >> menuModel: anObject [
	menuModel := anObject
]
