Class {
	#name : #BrMenuSubmenuItemElement,
	#superclass : #BrMenuItemLabeledElement,
	#category : #'Brick-Menu - UI'
}

{ #category : #initialization }
BrMenuSubmenuItemElement >> initialize [
	super initialize.
	self initializeStyling.
	self
		addChild: ((BrGlamorousVectorIcons play asElement background: Color veryLightGray)
				asScalableElement
				size: 14 @ 14;
				constraintsDo: [ :c | c linear vertical alignCenter ];
				margin: (BlInsets left: 10))
]

{ #category : #initialization }
BrMenuSubmenuItemElement >> initializeStyling [
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
BrMenuSubmenuItemElement >> onSelected: anAnnouncement [
	self
		fireEvent: (BrMenuShowSubmenuWish new
				submenu: anAnnouncement menuModel submenu;
				fromElement: self)
]

{ #category : #'event handling' }
BrMenuSubmenuItemElement >> onSelectionChanged: anAnnouncement [
	| isSelected |
	super onSelectionChanged: anAnnouncement.
	anAnnouncement menuModel == self menuModel ifFalse: [ ^ self ].
	isSelected := anAnnouncement menuModel isSelected.

	isSelected
		ifTrue: [ self onSelected: anAnnouncement ]
		ifFalse: [ self onDeselected: anAnnouncement ]
		
	"Note: hide action happens in BrMenuSubmenuItem>>#onSelectionChanged.
	Is looks confusing."
]
