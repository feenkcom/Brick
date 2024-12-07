Class {
	#name : #BrMenuContainerRelocator,
	#superclass : #Object,
	#instVars : [
		'menuContainer'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #accessing }
BrMenuContainerRelocator >> menuContainer [
	^ menuContainer
]

{ #category : #accessing }
BrMenuContainerRelocator >> menuContainer: anElement [
	menuContainer := anElement
]

{ #category : #'api - relocating' }
BrMenuContainerRelocator >> mouseUp: anEvent given: aWidget [
	"Relocators can store interesting information."

	
]

{ #category : #'api - relocating' }
BrMenuContainerRelocator >> relocateGiven: aWidget [
	"Relocate menu elements given the widget"

	self subclassResponsibility
]
