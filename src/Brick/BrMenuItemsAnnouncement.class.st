Class {
	#name : #BrMenuItemsAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'menuItems'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuItemsAnnouncement >> menuItems [
	<return: #BrMenuItems>
	^ menuItems
]

{ #category : #accessing }
BrMenuItemsAnnouncement >> menuItems: aMenuItems [
	menuItems := aMenuItems
]
