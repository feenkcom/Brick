"
I indicate that another menu was opened inside of existing menu.
I am used internally.
Users should use dedicated events to listen to show/hide state changes:
- for dropdowns: {{gtClass:BrDropdownIsVisible}}. 
- for context menus: *not implemented*, 
- for tooltips: *not implemented*.
"
Class {
	#name : #BrMenuIsVisibleEvent,
	#superclass : #BrMenuChangeEvent,
	#instVars : [
		'menuModel',
		'menuContainer'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuIsVisibleEvent >> menuContainer [
	^ menuContainer
]

{ #category : #accessing }
BrMenuIsVisibleEvent >> menuContainer: anObject [
	menuContainer := anObject
]

{ #category : #accessing }
BrMenuIsVisibleEvent >> menuModel [
	^ menuModel
]

{ #category : #accessing }
BrMenuIsVisibleEvent >> menuModel: anObject [
	menuModel := anObject
]

{ #category : #sending }
BrMenuIsVisibleEvent >> sendTo: anObject [
	anObject menuIsVisibleEvent: self
]
