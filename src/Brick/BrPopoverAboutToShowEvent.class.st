"
I indicate that a popover is about to be opened.
"
Class {
	#name : #BrPopoverAboutToShowEvent,
	#superclass : #BrPopoverChangeEvent,
	#instVars : [
		'menuModel',
		'menuContainer',
		'anchorElement'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrPopoverAboutToShowEvent >> anchorElement [
	^ anchorElement
]

{ #category : #accessing }
BrPopoverAboutToShowEvent >> anchorElement: anObject [
	anchorElement := anObject
]

{ #category : #accessing }
BrPopoverAboutToShowEvent >> menuContainer [
	^ menuContainer
]

{ #category : #accessing }
BrPopoverAboutToShowEvent >> menuContainer: anObject [
	menuContainer := anObject
]

{ #category : #accessing }
BrPopoverAboutToShowEvent >> menuModel [
	^ menuModel
]

{ #category : #accessing }
BrPopoverAboutToShowEvent >> menuModel: anObject [
	menuModel := anObject
]

{ #category : #sending }
BrPopoverAboutToShowEvent >> sendTo: anObject [
	anObject popoverAboutToShowEvent: self
]
