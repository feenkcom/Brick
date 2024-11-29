Class {
	#name : #BrMenuHandle,
	#superclass : #BrMenuModel,
	#instVars : [
		'menu'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #testing }
BrMenuHandle class >> isAbstract [
	^ self name = #BrMenuHandle
]

{ #category : #accessing }
BrMenuHandle >> menu [
	<return: #BrMenu>
	^ menu
]

{ #category : #accessing }
BrMenuHandle >> menu: anObject [
	menu := anObject
]
