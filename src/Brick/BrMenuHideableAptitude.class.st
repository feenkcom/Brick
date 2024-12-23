Class {
	#name : #BrMenuHideableAptitude,
	#superclass : #BrMenuModelAptitude,
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #'event handling' }
BrMenuHideableAptitude >> onMenuHideRequest: anAnnouncement [
	self widgetDo: [ :aWidget | 
		BlTaskAction
			enqueueElement: aWidget 
			action: [
				aWidget removeFromParent ] ]
]

{ #category : #'event handling' }
BrMenuHideableAptitude >> subscribeToMenuModel [
	super subscribeToMenuModel.
	
	self menuModel announcer weak 
		when: BrMenuHideRequest
		send: #onMenuHideRequest:
		to: self
]

{ #category : #'event handling' }
BrMenuHideableAptitude >> unsubscribeFromMenuModel [
	super unsubscribeFromMenuModel.
	self menuModel announcer unsubscribe: self
]
