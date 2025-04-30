Class {
	#name : #BrMenuItemElement,
	#superclass : #BrMenuModelElement,
	#traits : 'TBrMenuWithUpdatableElement + TBrEnableable',
	#classTraits : 'TBrMenuWithUpdatableElement classTrait + TBrEnableable classTrait',
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

	self when: BlMouseEnterEvent do: [ :anEvent | self onMouseEnterEvent: anEvent ].
	self when: BlMouseLeaveEvent do: [ :anEvent | self onMouseLeaveEvent: anEvent ].
	
	self
		padding: (BlInsets
				top: BrMenuConstants defaultMenuItemTopPadding
				bottom: BrMenuConstants defaultMenuItemBottomPadding
				left: BrMenuConstants defaultMenuItemLeftPadding
				right: BrMenuConstants defaultMenuItemRightPadding)
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
BrMenuItemElement >> onMenuModelChanged [
	super onMenuModelChanged.
	self updateElementSubscriptions.
	self enabled: self menuModel isEnabled
]

{ #category : #'event handling' }
BrMenuItemElement >> onMouseEnterEvent: anEvent [
	| aMenuModel |
	aMenuModel := self menuModel.
	aMenuModel ifNil: [ ^ self ].
	anEvent consumed: true.
	aMenuModel select
]

{ #category : #'event handling' }
BrMenuItemElement >> onMouseLeaveEvent: anEvent [
	
]

{ #category : #'event handling' }
BrMenuItemElement >> onSelectionChanged: anAnnouncement [
	"Must be called in a UI process."

	| isSelected |
	isSelected := anAnnouncement menuModel isSelected.
	self dispatchEvent: (BlElementSelectedStateWish selected: isSelected)
]

{ #category : #'event handling' }
BrMenuItemElement >> onUpdateRequestedAnnouncement: anAnnouncement [
	"This is called from the UI process."

	self menuModel hasEnableSpecifications ifFalse: [ ^ self ].

	self enabled: self menuModel isEnabled
]

{ #category : #'event handling' }
BrMenuItemElement >> subscribeToMenuModel [
	super subscribeToMenuModel.
	self menuItem announcer weak
		when: BrMenuItemSelectionChangedAnnouncement
		send: #onSelectionChanged:
		to: self.
	self subscribeToUpdatableMenuModel.
]

{ #category : #'event handling' }
BrMenuItemElement >> unsubscribeFromMenuModel [
	super unsubscribeFromMenuModel.
	
	self unsubscribeFromUpdatableMenuModel
]

{ #category : #'event handling' }
BrMenuItemElement >> unsubscribeFromMenuModelExcludingUserSubscriptions [
	super unsubscribeFromMenuModelExcludingUserSubscriptions.
	
	self menuModel announcer unsubscribe: self.
]
