Class {
	#name : #BrMenuPinnableAptitude,
	#superclass : #BrMenuModelAptitude,
	#instVars : [
		'handleElement',
		'pullHandler',
		'closeButton',
		'isPinned',
		'pinner',
		'isHideParentMenuOnPinned',
		'pinningActions'
	],
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #'private - updating' }
BrMenuPinnableAptitude >> addCloseButton [
	closeButton ifNotNil: [ ^ self ].
	
	self widgetDo: [ :anElement |
		anElement clipChildren: false.
		closeButton := self newCloseButton.
		self
			when: BlMouseEnterEvent
			do: [ :anEvent | closeButton visibility: BlVisibility visible ].
		self
			when: BlMouseLeaveEvent
			do: [ :anEvent | closeButton visibility: BlVisibility gone ].
		anElement 
			addChild: closeButton
			as: BrMenuPinnedCloseButtonId ]
]

{ #category : #'as yet unclassified' }
BrMenuPinnableAptitude >> addPinningAction: anAction [
	pinningActions := self pinningActions copyWith: anAction
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
BrMenuPinnableAptitude >> beHideMenu [
	"If my menu widget is pinned, I hide the other menu widgets."

	isHideParentMenuOnPinned := true
]

{ #category : #'api - initialization' }
BrMenuPinnableAptitude >> beKeepMenu [
	"If my menu widget is pinned, I still keep the other menu widgets around."

	isHideParentMenuOnPinned := false
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
			self performPreEndPinActions.
			pinner pinMenuElement: aWidget.
			self addCloseButton.
			isPinned := true. ]
]

{ #category : #initialization }
BrMenuPinnableAptitude >> initialize [
	super initialize.
	isPinned := false.
	isHideParentMenuOnPinned := true.
	pullHandler := BlPullHandler new disallowOutOfBounds.
	handleElement := self newHandleElement.
	handleElement addEventHandler: pullHandler.
	closeButton := nil.
	pinner := BrMenuAnchorElementPinner new.
	pinningActions := Array empty.
]

{ #category : #initialization }
BrMenuPinnableAptitude >> initializeListeners [
	super initializeListeners.

	self when: BlPullStartEvent do: [ :anEvent | self onPullStartEvent: anEvent ].
	self when: BlPullEndEvent do: [ :anEvent | self onPullEndEvent: anEvent ]
]

{ #category : #testing }
BrMenuPinnableAptitude >> isHideParentMenuOnPinned [
	<return: #Boolean>
	^ isHideParentMenuOnPinned ifNil: [ true ]
]

{ #category : #initialization }
BrMenuPinnableAptitude >> newCloseButton [
	^ BlElement new
		size: 5 @ 5;
		geometry: BlCircleGeometry new;
		background: self theme status paleErrorBackgroundColor;
		when: BlClickEvent do: [ :anEvent | self onCloseFrom: anEvent currentTarget ]
]

{ #category : #initialization }
BrMenuPinnableAptitude >> newHandleElement [
	^ BrFrame new 
		in: [ :theFrame |
			theFrame states addState: (BrResizerLocationState 
				location: BrResizerTopLocation new) ];
		constraintsDo: [ :c | 
			c ignoreByLayout ];
		mouseCursor: BlGrabCursor new;
		when: BlMouseDownEvent
			do: [ :anEvent | anEvent currentTarget mouseCursor: BlGrabbingCursor new ];
		when: BlMouseUpEvent 
			do: [ :anEvent | anEvent currentTarget mouseCursor: BlGrabCursor new ];
		when: BlDragEndEvent
			do: [ :anEvent | anEvent currentTarget mouseCursor: BlGrabCursor new ]
]

{ #category : #'private - notifying' }
BrMenuPinnableAptitude >> notifyHideParentMenu [
	self menuModel ifNotNil: [ :aMenuModel | 
		aMenuModel hideAll ]
]

{ #category : #'api - hooks' }
BrMenuPinnableAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.
	anElement clipChildren: false.
	self widget 
		addChild: handleElement 
		as: BrMenuPinnedHandleId.
	pullHandler targetElement: self widget
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

{ #category : #'private - event management' }
BrMenuPinnableAptitude >> onMenuPinRequest: anAnnouncement [
	"Must be called in a UI process."
	
	self menuModel == anAnnouncement menuModel ifFalse: [ ^ self ].

	self widgetDo: [ :aWidget | 
		self startPinning.
		self endPinning ]
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

{ #category : #'private - updating' }
BrMenuPinnableAptitude >> performPreEndPinActions [
	| aContext |
	self pinningActions ifEmpty: [ ^ self ].
	self widgetDo: [ :aWidget | 
		aContext := BrMenuPinActionContext new
			menuElement: aWidget;
			pinnableAptitude: self ].
	aContext ifNil: [ ^ self ].

	self pinningActions do: [ :eachAction |
		eachAction executePreEndPinBlockInContext: aContext ].
]

{ #category : #'private - updating' }
BrMenuPinnableAptitude >> performPreStartPinActions [
	| aContext |
	self pinningActions ifEmpty: [ ^ self ].
	self widgetDo: [ :aWidget | 
		aContext := BrMenuPinActionContext new
			menuElement: aWidget;
			pinnableAptitude: self ].
	aContext ifNil: [ ^ self ].

	self pinningActions do: [ :eachAction |
		eachAction executePreStartPinBlockInContext: aContext ].
]

{ #category : #accessing }
BrMenuPinnableAptitude >> pinningActions [
	<return: #Collection of: #BrMenuPinAction>
	^ pinningActions ifNil: [ pinningActions := Array empty ]
]

{ #category : #'event handling' }
BrMenuPinnableAptitude >> startPinning [
	isPinned ifTrue: [ ^ self ].
	self widgetDo: [ :aWidget |
		| aPosition |
		aWidget isAttachedToSceneGraph ifFalse: [ ^ self ].

		aPosition := aWidget position.
		aWidget fireEvent: (BrMenuDetachWish new menuModel: self menuModel).
		self performPreStartPinActions.
		aWidget constraintsDo: [ :c | 
			c ignoreByLayout ].
		aWidget relocate: aPosition.
		
		self isHideParentMenuOnPinned ifTrue: [ 
			self notifyHideParentMenu ] ]
]

{ #category : #'event handling' }
BrMenuPinnableAptitude >> subscribeToMenuModel [
	super subscribeToMenuModel.
	
	self menuModel announcer weak 
		when: BrMenuPinRequestAnnouncement
		send: #onMenuPinRequest:
		to: self
]

{ #category : #'event handling' }
BrMenuPinnableAptitude >> unsubscribeFromMenuModel [
	super unsubscribeFromMenuModel.
	self menuModel ifNotNil: [ :aMenuModel | 
		aMenuModel announcer unsubscribe: self ]
]

{ #category : #'api - initialization' }
BrMenuPinnableAptitude >> withAllPinActions [
	"Let's initialize menu element, e.g., by installing other event handlers."
	| allPragmas |
	allPragmas := Pragma 
		allNamed: #menuPinAction 
		from: self class 
		to: BrMenuPinnableAptitude.
	allPragmas do: [ :eachPragma |
		(self perform: eachPragma methodSelector) ]
]

{ #category : #'api - initialization' }
BrMenuPinnableAptitude >> withPinnedAptitude [
	<menuPinAction>
	self addPinningAction: (BrMenuPinAction new
		preEndPinBlock: [ self add: BrMenuPinnedAptitude new ])
]
