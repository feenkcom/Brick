Class {
	#name : #BrMenuSubmenuItemElement,
	#superclass : #BrMenuItemElement,
	#category : #'Brick-Menu - UI'
}

{ #category : #initialization }
BrMenuSubmenuItemElement >> initializeStyling [
	super initializeStyling.

	self addAptitude: (BrStyleCommonAptitude new
				default: [ :aStyle | aStyle background: Color white ];
				when: BlElementState hovered & BlElementState selected
					style: [ :aStyle | aStyle background: self theme item selectedColor ];
				when: BlElementState hovered not & BlElementState selected
					style: [ :aStyle | aStyle background: self theme item hoveredColor ];
				pressed: [ :aStyle | aStyle background: self theme item pressedColor ])
]

{ #category : #'event handling' }
BrMenuSubmenuItemElement >> onDeselected: anAnnouncement [ 
]

{ #category : #'event handling' }
BrMenuSubmenuItemElement >> onMenuModelChanged [
	super onMenuModelChanged.
	self updateElement
]

{ #category : #'event handling' }
BrMenuSubmenuItemElement >> onSelected: anAnnouncement [
	self
		fireEvent: (BrMenuShowSubmenuWish new
				submenu: anAnnouncement menuItem submenu;
				fromElement: self)
]

{ #category : #'event handling' }
BrMenuSubmenuItemElement >> onSelectionChanged: anAnnouncement [
	| isSelected |
	super onSelectionChanged: anAnnouncement.
	anAnnouncement menuItem == self menuItem ifFalse: [ ^ self ].
	isSelected := anAnnouncement menuItem isSelected.

	isSelected
		ifTrue: [ self onSelected: anAnnouncement ]
		ifFalse: [ self onDeselected: anAnnouncement ]
		
	"Note: hide action happens in BrMenuSubmenuItem>>#onSelectionChanged.
	Is looks confusing."
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
