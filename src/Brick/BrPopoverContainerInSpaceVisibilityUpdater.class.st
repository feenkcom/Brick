"
I am {{gtClass:BrPopoverContainerVisibilityUpdater}}.
I hide menu container if an associated anchor element is not visible in space.

"
Class {
	#name : #BrPopoverContainerInSpaceVisibilityUpdater,
	#superclass : #BrPopoverContainerVisibilityUpdater,
	#category : #'Brick-Menu - Support'
}

{ #category : #'as yet unclassified' }
BrPopoverContainerInSpaceVisibilityUpdater >> updateGiven: anAnchorElement firstTime: isFirstTimeDisplay [
	"Subclasses may change menu container visibility given the anchor element"

	anAnchorElement isVisibleInSpace 
			ifFalse: [ menuContainer visibility: BlVisibility gone ]
			ifTrue: [ menuContainer visibility: BlVisibility visible ].
]
