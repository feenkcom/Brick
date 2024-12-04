Class {
	#name : #BrMenuShowSubmenuWish,
	#superclass : #BrWish,
	#instVars : [
		'submenu',
		'fromElement'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuShowSubmenuWish >> fromElement [
	^ fromElement ifNil: [ self source ]
]

{ #category : #accessing }
BrMenuShowSubmenuWish >> fromElement: anObject [
	fromElement := anObject
]

{ #category : #accessing }
BrMenuShowSubmenuWish >> submenu [
	^ submenu
]

{ #category : #accessing }
BrMenuShowSubmenuWish >> submenu: anObject [
	submenu := anObject
]
