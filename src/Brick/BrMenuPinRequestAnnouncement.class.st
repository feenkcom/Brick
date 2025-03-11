"
I am a {{gtClass:BrMenuModelAnnouncement}}. 
I notify menu elements that they should be pinned and therefore detached from a menu model. 
Pinned menu elements remain opened even after closing the menu.
Note: This announcement can be announced only from the UI process.
"
Class {
	#name : #BrMenuPinRequestAnnouncement,
	#superclass : #BrMenuModelAnnouncement,
	#category : #'Brick-Menu - Events'
}
