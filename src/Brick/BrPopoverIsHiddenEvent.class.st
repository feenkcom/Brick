"
I indicate that another menu was closed inside of an existing menu.
I am used internally.
Users should use dedicated events to listen to show/hide state changes:
- for dropdowns: {{gtClass:BrDropdownIsHidden}}. 
- for context menus: *not implemented*, 
- for tooltips: *not implemented*.
"
Class {
	#name : #BrPopoverIsHiddenEvent,
	#superclass : #BrPopoverChangeEvent,
	#instVars : [
		'menuModel',
		'menuContainer'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrPopoverIsHiddenEvent >> menuContainer [
	^ menuContainer
]

{ #category : #accessing }
BrPopoverIsHiddenEvent >> menuContainer: anObject [
	menuContainer := anObject
]

{ #category : #accessing }
BrPopoverIsHiddenEvent >> menuModel [
	^ menuModel
]

{ #category : #accessing }
BrPopoverIsHiddenEvent >> menuModel: anObject [
	menuModel := anObject
]

{ #category : #sending }
BrPopoverIsHiddenEvent >> sendTo: anObject [
	anObject menuIsHiddenEvent: self
]
