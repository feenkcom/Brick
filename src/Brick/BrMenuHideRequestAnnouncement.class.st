"
I am a {{gtClass:BrMenuModelAnnouncement}}. 
I notify hide requests from {{gtClass:BrMenuModel}}. 
I can be triggered using:
- {{gtMethod:BrMenuModel >> #hide}}, or
- {{gtMethod:BrMenuModel >> #hideAll}}.

Note: This announcement can be announced only from the UI process.

"
Class {
	#name : #BrMenuHideRequestAnnouncement,
	#superclass : #BrMenuModelAnnouncement,
	#category : #'Brick-Menu - Events'
}
