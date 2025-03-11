Class {
	#name : #BrMenuHandle,
	#superclass : #BrMenuModel,
	#instVars : [
		'menu'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #testing }
BrMenuHandle class >> isAbstract [
	^ self name = #BrMenuHandle
]

{ #category : #visiting }
BrMenuHandle >> acceptVisitor: aVisitor [
	^ aVisitor visitMenuHandle: self
]

{ #category : #initialization }
BrMenuHandle >> defaultMenu [
	<return: #BrMenu or: nil>
	^ nil
]

{ #category : #'api - visibility' }
BrMenuHandle >> hide [
	"Hide corresponding menu element.
	Note: This method can be called only from the UI process."
	
	"Hide associated menu model."
	menu ifNotNil: #hide.
	
	"Then hide the handle element."
	super hide.
]

{ #category : #accessing }
BrMenuHandle >> menu [
	<return: #BrMenu>
	^ menu ifNil: [ 
		menu := self defaultMenu.
		menu ifNotNil: [ :aMenu | aMenu parent: self ].
		menu ]
]

{ #category : #accessing }
BrMenuHandle >> menu: aBrMenu [
	aBrMenu parent: self.
	menu := aBrMenu
]

{ #category : #'api - hooks' }
BrMenuHandle >> onMenuDisplayed: aMenuElement [
	"Subclasses may react when a menu is dispalyed using a given element"

	super onMenuDisplayed: aMenuElement.

	BlTaskAction
		enqueueElement: aMenuElement
		action: [ self onMenuDisplayedFromParentMenuElement: aMenuElement ]
]

{ #category : #private }
BrMenuHandle >> onMenuDisplayedFromParentMenuElement: aMenuElement [
	| aMenu |
	aMenu := self menu.
	aMenu ifNil: [ 
		self hide. 
		^ self ].
	
	aMenuElement
		fireEvent: (BrMenuShowSubmenuWish new
				submenu: aMenu;
				fromElement: aMenuElement)
]
