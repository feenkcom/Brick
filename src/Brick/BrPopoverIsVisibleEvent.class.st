"
I indicate that another menu was opened inside of existing menu.
I am used internally.
Users should use dedicated events to listen to show/hide state changes:
- for dropdowns: {{gtClass:BrDropdownIsVisible}}. 
- for context menus: {{gtClass:BrContextMenuIsVisible}}, 
- for tooltips: {{gtClass:BrTooltipIsVisible}}. 
"
Class {
	#name : #BrPopoverIsVisibleEvent,
	#superclass : #BrPopoverChangeEvent,
	#instVars : [
		'menuModel',
		'menuContainer'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrPopoverIsVisibleEvent >> menuContainer [
	^ menuContainer
]

{ #category : #accessing }
BrPopoverIsVisibleEvent >> menuContainer: anObject [
	menuContainer := anObject
]

{ #category : #accessing }
BrPopoverIsVisibleEvent >> menuModel [
	^ menuModel
]

{ #category : #accessing }
BrPopoverIsVisibleEvent >> menuModel: anObject [
	menuModel := anObject
]

{ #category : #sending }
BrPopoverIsVisibleEvent >> sendTo: anObject [
	anObject menuIsVisibleEvent: self
]
