"
I indicate that another menu was closed inside of an existing menu.
I am used internally.
Users should use dedicated events to listen to show/hide state changes:
- for dropdowns: {{gtClass:BrDropdownIsHidden}}. 
- for context menus: *not implemented*, 
- for tooltips: *not implemented*.
"
Class {
	#name : #BrMenuIsHiddenEvent,
	#superclass : #BrMenuChangeEvent,
	#instVars : [
		'menuModel',
		'menuContainer'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuIsHiddenEvent >> menuContainer [
	^ menuContainer
]

{ #category : #accessing }
BrMenuIsHiddenEvent >> menuContainer: anObject [
	menuContainer := anObject
]

{ #category : #accessing }
BrMenuIsHiddenEvent >> menuModel [
	^ menuModel
]

{ #category : #accessing }
BrMenuIsHiddenEvent >> menuModel: anObject [
	menuModel := anObject
]

{ #category : #sending }
BrMenuIsHiddenEvent >> sendTo: anObject [
	anObject menuIsHiddenEvent: self
]
