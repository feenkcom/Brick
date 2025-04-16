"
I handle {{gtClass:BrMenuModel}} hide announcements, particularly:
- {{gtClass:BrMenuHideAnnouncement}}, and
- {{gtClass:BrMenuHideAllAnnouncement}}. 

"
Class {
	#name : #BrPopoverHideableAptitude,
	#superclass : #BrPopoverModelAptitude,
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #'event handling' }
BrPopoverHideableAptitude >> onMenuHideAllAnnouncement: anAnnouncement [
	"Must be called in a UI process."

	self widgetDo: [ :aWidget | aWidget fireEvent: BrPopoverHideAllWish new ]
]

{ #category : #'event handling' }
BrPopoverHideableAptitude >> onMenuHideRequest: anAnnouncement [
	"Must be called in a UI process."
	
	self widgetDo: [ :aWidget | 
		aWidget removeFromParent ]
]

{ #category : #'event handling' }
BrPopoverHideableAptitude >> subscribeToMenuModel [
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
BrPopoverHideableAptitude >> unsubscribeFromMenuModel [
	super unsubscribeFromMenuModel.
	self menuModel announcer unsubscribe: self
]
