"
I am an abstract class.
I am responsible for changing {{gtMethod:BlSteppedLayout >> #anchorBounds:}}. 
I am used by {{gtClass:BrWithExplicitPopoverAptitude}}. 

"
Class {
	#name : #BrPopoverContainerRelocator,
	#superclass : #Object,
	#instVars : [
		'menuContainer'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #accessing }
BrPopoverContainerRelocator >> menuContainer [
	^ menuContainer
]

{ #category : #accessing }
BrPopoverContainerRelocator >> menuContainer: anElement [
	"Set popover container which has {{gtClass:BlSteppedLayout}} layout."

	menuContainer := anElement
]

{ #category : #'api - relocating' }
BrPopoverContainerRelocator >> mouseEvent: anEvent given: anAnchorElement [
	"Relocators can store interesting information."

	
]

{ #category : #'api - relocating' }
BrPopoverContainerRelocator >> relocateGiven: anAnchorElement firstTime: isFirstTimeDisplay [
	"Relocate menu elements given the anchor element"

	self subclassResponsibility
]
