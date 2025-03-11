Class {
	#name : #BrMenuHideableAptitude,
	#superclass : #BrMenuModelAptitude,
	#category : #'Brick-Menu - Aptitude'
}

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
		when: BrMenuHideRequestAnnouncement
		send: #onMenuHideRequest:
		to: self
]

{ #category : #'event handling' }
BrMenuHideableAptitude >> unsubscribeFromMenuModel [
	super unsubscribeFromMenuModel.
	self menuModel announcer unsubscribe: self
]
