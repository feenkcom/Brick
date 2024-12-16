Class {
	#name : #BrMenuModelAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'menuModel'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuModelAnnouncement >> menuModel [
	<return: #BrMenu>
	^ menuModel
]

{ #category : #accessing }
BrMenuModelAnnouncement >> menuModel: aMenu [
	menuModel := aMenu
]
