Class {
	#name : #BrMenuItemAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'menuItem'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuItemAnnouncement >> menuItem [
	<return: #BrMenuItem>
	^ menuItem
]

{ #category : #accessing }
BrMenuItemAnnouncement >> menuItem: aMenuItem [
	menuItem := aMenuItem
]
