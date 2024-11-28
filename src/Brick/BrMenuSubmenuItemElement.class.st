Class {
	#name : #BrMenuSubmenuItemElement,
	#superclass : #BrMenuItemElement,
	#category : #'Brick-Menu - UI'
}

{ #category : #'event handling' }
BrMenuSubmenuItemElement >> onMenuItemChanged [
	super onMenuItemChanged.
	self updateElement
]

{ #category : #'event handling' }
BrMenuSubmenuItemElement >> onSelectionChanged: anAnnouncement [
	super onSelectionChanged: anAnnouncement.
	anAnnouncement menuItem == self menuItem ifFalse: [ ^ self ].
	
	anAnnouncement menuItem isSelected
		ifTrue: [ 
			self fireEvent: (BrMenuShowSubmenuWish new 
				submenu: anAnnouncement menuItem submenu;
				fromElement: self) ]
]

{ #category : #'private - updating' }
BrMenuSubmenuItemElement >> updateElement [
	self removeChildren.
	self addLabelElement.
	self
		addChild: (BrGlamorousVectorIcons play asElement
				background: Color veryLightGray;
				constraintsDo: [ :c | c linear vertical alignCenter ])
]
