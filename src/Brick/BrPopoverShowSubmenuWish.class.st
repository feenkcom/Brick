Class {
	#name : #BrPopoverShowSubmenuWish,
	#superclass : #BrPopoverWish,
	#instVars : [
		'submenu',
		'fromElement'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrPopoverShowSubmenuWish >> fromElement [
	^ fromElement ifNil: [ self source ]
]

{ #category : #accessing }
BrPopoverShowSubmenuWish >> fromElement: anObject [
	fromElement := anObject
]

{ #category : #accessing }
BrPopoverShowSubmenuWish >> submenu [
	^ submenu
]

{ #category : #accessing }
BrPopoverShowSubmenuWish >> submenu: anObject [
	submenu := anObject
]
