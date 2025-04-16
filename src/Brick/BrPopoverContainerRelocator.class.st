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
	menuContainer := anElement
]

{ #category : #'api - relocating' }
BrPopoverContainerRelocator >> mouseUp: anEvent given: aWidget [
	"Relocators can store interesting information."

	
]

{ #category : #'api - relocating' }
BrPopoverContainerRelocator >> relocateGiven: aWidget [
	"Relocate menu elements given the widget"

	self subclassResponsibility
]
