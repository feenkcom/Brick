"
I handle {{gtClass:BrMenuModel}} hide announcements, particularly:
- {{gtClass:BrMenuHideAnnouncement}}, and
- {{gtClass:BrMenuHideAllAnnouncement}}. 

"
Class {
	#name : #BrMenuHideableAptitude,
	#superclass : #BrMenuModelAptitude,
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #'event handling' }
BrMenuHideableAptitude >> onMenuHideAllAnnouncement: anAnnouncement [
	"Must be called in a UI process."

	self widgetDo: [ :aWidget | aWidget fireEvent: BrMenuHideAllWish new ]
]

{ #category : #'event handling' }
BrMenuHideableAptitude >> onMenuHideRequest: anAnnouncement [
	"Must be called in a UI process."
	
	self widgetDo: [ :aWidget | 
		aWidget removeFromParent ]
]

{ #category : #'event handling' }
BrMenuHideableAptitude >> subscribeToMenuModel [
	super subscribeToMenuModel.

	self menuModel announcer weak
		when: BrMenuHideAnnouncement
			send: #onMenuHideRequest:
			to: self;
		when: BrMenuHideAllAnnouncement
			send: #onMenuHideAllAnnouncement:
			to: self
]

{ #category : #'event handling' }
BrMenuHideableAptitude >> unsubscribeFromMenuModel [
	super unsubscribeFromMenuModel.
	self menuModel announcer unsubscribe: self
]
