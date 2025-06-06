Class {
	#name : #BrPopoverMouseUpEventHandler,
	#superclass : #BrPopoverMouseEventHandler,
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - accessing' }
BrPopoverMouseUpEventHandler >> eventsToHandle [
	^ {BlMouseUpEvent}
]

{ #category : #'api - event managing' }
BrPopoverMouseUpEventHandler >> mouseUpEvent: anEvent [
	anEvent button = self mouseButton
		ifFalse: [ ^ self ].
	
	(self modifiersMatcher value: anEvent modifiers)
		ifFalse: [ ^ self ].

	anEvent consumed: true.
	
	self showDueTo: anEvent
]
