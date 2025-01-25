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
	menu ifNotNil: #hide.
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
		action: [ aMenuElement
				fireEvent: (BrMenuShowSubmenuWish new
						submenu: self menu;
						fromElement: aMenuElement) ].
]
