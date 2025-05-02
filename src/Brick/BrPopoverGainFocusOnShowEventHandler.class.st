Class {
	#name : #BrPopoverGainFocusOnShowEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'menuContainer',
		'previousFocusOwner'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - accessing' }
BrPopoverGainFocusOnShowEventHandler >> eventsToHandle [
	^ { BrPopoverIsVisibleEvent. BrPopoverIsHiddenEvent}
]

{ #category : #accessing }
BrPopoverGainFocusOnShowEventHandler >> menuContainer [
	^ menuContainer
]

{ #category : #accessing }
BrPopoverGainFocusOnShowEventHandler >> menuContainer: anObject [
	menuContainer := anObject
]

{ #category : #'api - event managing' }
BrPopoverGainFocusOnShowEventHandler >> menuIsHiddenEvent: anEvent [
	menuContainer ifNil: [ ^ self ].
	anEvent menuContainer == menuContainer ifFalse: [ ^ self ].

	previousFocusOwner
		ifNotNil: [ :aWeak | (aWeak at: 1) ifNotNil: [ :anElement | anElement requestFocus ] ]
]

{ #category : #'api - event managing' }
BrPopoverGainFocusOnShowEventHandler >> menuIsVisibleEvent: anEvent [
	| aSpace aFocusOwner |
	menuContainer ifNil: [ ^ self ].
	anEvent menuContainer == menuContainer ifFalse: [ ^ self ].

	aSpace := menuContainer space ifNil: [ ^ self ].
	aFocusOwner := aSpace focusOwner.
	aFocusOwner ifNil: [ ^ self ].
	
	previousFocusOwner := aFocusOwner asWeakReference.
	menuContainer dispatchEvent: BrPopoverGainFocusWish new
]
