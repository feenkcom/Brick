Class {
	#name : #BrMenuItemElement,
	#superclass : #BrMenuModelElement,
	#category : #'Brick-Menu - UI'
}

{ #category : #initialization }
BrMenuItemElement >> defaultLayout [
	^ BlLinearLayout horizontal
]

{ #category : #initialization }
BrMenuItemElement >> initialize [
	super initialize.
	self hMatchParent.
	self vFitContent.

	self when: BlMouseEnterEvent do: [ :anEvent | self onMouseEnterEvent: anEvent ]
]

{ #category : #initialization }
BrMenuItemElement >> initializeCommonStyling [
	self
		addAptitude: (BrStyleCommonAptitude new
				default: [ :aStyle | aStyle background: Color white ];
				hovered: [ :aStyle | aStyle background: self theme item selectedColor ];
				pressed: [ :aStyle | aStyle background: self theme item pressedColor ])
]

{ #category : #accessing }
BrMenuItemElement >> menuItem [
	^ self menuModel
]

{ #category : #accessing }
BrMenuItemElement >> menuItem: aMenuItem [
	self menuModel: aMenuItem
]

{ #category : #'event handling' }
BrMenuItemElement >> onMouseEnterEvent: anEvent [
	self menuItem ifNil: [ ^ self ].
	anEvent consumed: true.
	self menuItem select
]

{ #category : #'event handling' }
BrMenuItemElement >> onSelectionChanged: anAnnouncement [
	| isSelected |
	isSelected := anAnnouncement menuItem isSelected.
	self dispatchEvent: (BlElementSelectedStateWish selected: isSelected)
]

{ #category : #'event handling' }
BrMenuItemElement >> subscribeToMenuModel [
	super subscribeToMenuModel.
	self menuItem announcer weak
		when: BrMenuItemSelectionChanged
		send: #onSelectionChanged:
		to: self
]

{ #category : #'event handling' }
BrMenuItemElement >> unsubscribeFromMenuModel [
	super unsubscribeFromMenuModel.
	self menuItem unsubscribe: self
]
