Class {
	#name : #BrMenuAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'menuModel'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuAnnouncement >> menuModel [
	<return: #BrMenu>
	^ menuModel
]

{ #category : #accessing }
BrMenuAnnouncement >> menuModel: aMenu [
	menuModel := aMenu
]
