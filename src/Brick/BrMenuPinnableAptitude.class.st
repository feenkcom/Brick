Class {
	#name : #BrMenuPinnableAptitude,
	#superclass : #BrMenuModelAptitude,
	#instVars : [
		'handleElement',
		'pullHandler',
		'closeButton',
		'isPinned',
		'pinner'
	],
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #'private - updating' }
BrMenuPinnableAptitude >> addCloseButton [
	closeButton ifNotNil: [ ^ self ].
	
	self widgetDo: [ :anElement |
		anElement clipChildren: false.
		closeButton := self newCloseButton.
		closeButton action: [ :aButton |
			self onCloseFrom: aButton ].
		self
			when: BlMouseEnterEvent
			do: [ :anEvent | closeButton visibility: BlVisibility visible ].
		self
			when: BlMouseLeaveEvent
			do: [ :anEvent | closeButton visibility: BlVisibility gone ].
		anElement addChild: closeButton ]
]

{ #category : #'api - initialization' }
BrMenuPinnableAptitude >> beAnyParentPinner [
	"It moves a dragged menu element to a space root element.
	It asks to which parent element it should be attached to.
	It keeps the menu element in top-left relative position to 
	the given anchore element. It hides the menu element if
	the anchor element is removed from its space."

	pinner := BrMenuAnchorElementPinner new
]

{ #category : #'api - initialization' }
BrMenuPinnableAptitude >> beSameParentPinner [
	"I keep dragged menus in a same parent.
	As a consequence, pinned widgets keep relative position to 
	its original element (handle)."

	pinner := BrMenuSameParentPinner new
]

{ #category : #'api - initialization' }
BrMenuPinnableAptitude >> beSpaceRootPinner [
	pinner := BrMenuSpaceRootPinner new
]

{ #category : #'event handling' }
BrMenuPinnableAptitude >> endPinning [
	isPinned ifTrue: [ ^ self ].
	self
		widgetDo: [ :aWidget | 
			aWidget isAttachedToSceneGraph ifFalse: [ ^ self ].
			pinner pinMenuElement: aWidget.
			self addCloseButton.
			isPinned := true ]
]

{ #category : #initialization }
BrMenuPinnableAptitude >> initialize [
	super initialize.
	isPinned := false.
	pullHandler := BlPullHandler new disallowOutOfBounds.
	handleElement := self newHandleElement.
	handleElement addEventHandler: pullHandler.
	closeButton := nil.
	pinner := BrMenuAnchorElementPinner new
]

{ #category : #initialization }
BrMenuPinnableAptitude >> initializeListeners [
	super initializeListeners.

	self when: BlPullStartEvent do: [ :anEvent | self onPullStartEvent: anEvent ].
	self when: BlPullEndEvent do: [ :anEvent | self onPullEndEvent: anEvent ]
]

{ #category : #'event handling' }
BrMenuPinnableAptitude >> newCloseButton [
	^ GtInspectorRoundButtonStencil small asElement
		icon: (BrPlusIconStencil close radius: 3) asElement;
		zIndex: 10;
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored horizontal alignCenterAt: 1.0.
			c ignored vertical alignCenterAt: 0.0 ];
		addAptitude: (BrGlamorousWithLabelTooltipAptitude 
			text: 'Close').
]

{ #category : #initialization }
BrMenuPinnableAptitude >> newHandleElement [
	^ BrMenuDragHandleElement new
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored horizontal alignCenter.
			c ignored vertical alignTop ]
]

{ #category : #'event handling' }
BrMenuPinnableAptitude >> onCloseFrom: aButton [
	self widgetDo: [ :aWidget | 
		aWidget isAttachedToSceneGraph ifFalse: [ ^ self ].
		BlTaskAction 
			enqueueElement: aWidget 
			action: [ 
				aWidget fireEvent: BrMenuPinnedElementAboutToBeClosed new.
				aWidget removeFromParent.
				isPinned := false ] ]
]

{ #category : #'api - hooks' }
BrMenuPinnableAptitude >> onInstalledIn: anElement [
	super onInstalledIn: anElement.
	self widget addChild: handleElement.
	pullHandler targetElement: self widget
]

{ #category : #'private - event management' }
BrMenuPinnableAptitude >> onMenuPinRequest: anAnnouncement [
	self menuModel == anAnnouncement menuModel ifFalse: [ ^ self ].

	self widgetDo: [ :aWidget | 
		BlTaskAction
			enqueueElement: aWidget
			action: [ 
				self startPinning.
				self endPinning ] ]
]

{ #category : #'event handling' }
BrMenuPinnableAptitude >> onPullEndEvent: anEvent [
	isPinned ifTrue: [ ^ self ].
	anEvent consumed: true.
	self endPinning.
]

{ #category : #'event handling' }
BrMenuPinnableAptitude >> onPullStartEvent: anEvent [ 
	isPinned ifTrue: [ ^ self ].
	anEvent consumed: true.
	self startPinning
]

{ #category : #'api - hooks' }
BrMenuPinnableAptitude >> onUninstalledIn: anElement [
	super onUninstalledIn: anElement.
	handleElement removeFromParent.
	pullHandler targetElement: nil.
	closeButton ifNotNil: #removeFromParent.
	closeButton := nil.
	isPinned := false.
]

{ #category : #'event handling' }
BrMenuPinnableAptitude >> startPinning [
	isPinned ifTrue: [ ^ self ].
	self widgetDo: [ :aWidget |
		| aPosition |
		aWidget isAttachedToSceneGraph ifFalse: [ ^ self ].

		aPosition := aWidget position.
		aWidget fireEvent: BrMenuDetachWish new.
		aWidget constraintsDo: [ :c | 
			c ignoreByLayout ].
		aWidget relocate: aPosition ]
]

{ #category : #'event handling' }
BrMenuPinnableAptitude >> subscribeToMenuModel [
	super subscribeToMenuModel.
	
	self menuModel announcer weak 
		when: BrMenuPinRequest
		send: #onMenuPinRequest:
		to: self
]

{ #category : #'event handling' }
BrMenuPinnableAptitude >> unsubscribeFromMenuModel [
	super unsubscribeFromMenuModel.
	self menuModel announcer unsubscribe: self
]
