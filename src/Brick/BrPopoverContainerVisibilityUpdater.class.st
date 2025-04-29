"
I am an abstract class.
I am responsible for changing menu container visibility based on a given anchor element.

"
Class {
	#name : #BrPopoverContainerVisibilityUpdater,
	#superclass : #Object,
	#instVars : [
		'menuContainer'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #testing }
BrPopoverContainerVisibilityUpdater class >> isAbstract [
	^ self name = #BrPopoverContainerVisibilityUpdater
]

{ #category : #accessing }
BrPopoverContainerVisibilityUpdater >> menuContainer [
	^ menuContainer
]

{ #category : #accessing }
BrPopoverContainerVisibilityUpdater >> menuContainer: anObject [
	menuContainer := anObject
]

{ #category : #'api - updating' }
BrPopoverContainerVisibilityUpdater >> updateGiven: anAnchorElement reason: aReason [
	"Subclasses may change menu container visibility given the anchor element.
	aReason is `BrPopoverRelocateReason` kind of instance"

	
]
