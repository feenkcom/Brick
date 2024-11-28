Class {
	#name : #BrMenuHideSubmenuWish,
	#superclass : #BrWish,
	#instVars : [
		'submenu',
		'fromElement'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuHideSubmenuWish >> fromElement [
	^ fromElement
]

{ #category : #accessing }
BrMenuHideSubmenuWish >> fromElement: anObject [
	fromElement := anObject
]

{ #category : #accessing }
BrMenuHideSubmenuWish >> submenu [
	^ submenu
]

{ #category : #accessing }
BrMenuHideSubmenuWish >> submenu: anObject [
	submenu := anObject
]
