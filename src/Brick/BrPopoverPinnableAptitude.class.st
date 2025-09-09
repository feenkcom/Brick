"
I make {{gtClass:BrMenuModel}} elements pinnable. It means that users can drag-and-drop menus and keep them permanently visible. Users can explicitly close such elements using a close button. See my subclasses for examples, e.g., {{gtClass:BrGlamorousPopoverPinnableAptitude}}.

"
Class {
	#name : #BrPopoverPinnableAptitude,
	#superclass : #BrPopoverModelAptitude,
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

{ #category : #testing }
BrPopoverPinnableAptitude class >> isAbstract [
	^ self name = #BrPopoverPinnableAptitude
]

{ #category : #'private - updating' }
BrPopoverPinnableAptitude >> addCloseButton [
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
			as: BrPopoverPinnedCloseButtonId ]
]

{ #category : #'api - initialization' }
BrPopoverPinnableAptitude >> addPinningAction: anAction [
	pinningActions := self pinningActions copyWith: anAction
]

{ #category : #'api - initialization' }
BrPopoverPinnableAptitude >> beAnyParentPinner [
	"It moves a dragged menu element to a space root element.
	It asks to which parent element it should be attached to.
	It keeps the menu element in top-left relative position to 
	the given anchore element. It hides the menu element if
	the anchor element is removed from its space."

	pinner := BrPopoverAnchorElementPinner new
]

{ #category : #'api - initialization' }
BrPopoverPinnableAptitude >> beHideMenu [
	"If my menu widget is pinned, I hide the other menu widgets."

	isHideParentMenuOnPinned := true
]

{ #category : #'api - initialization' }
BrPopoverPinnableAptitude >> beKeepMenu [
	"If my menu widget is pinned, I still keep the other menu widgets around."

	isHideParentMenuOnPinned := false
]

{ #category : #'api - initialization' }
BrPopoverPinnableAptitude >> beSameParentPinner [
	"I keep dragged menus in a same parent.
	As a consequence, pinned widgets keep relative position to 
	its original element (handle)."

	pinner := BrPopoverSameParentPinner new
]

{ #category : #'api - initialization' }
BrPopoverPinnableAptitude >> beSpaceRootPinner [
	pinner := BrPopoverSpaceRootPinner new
]

{ #category : #'event handling' }
BrPopoverPinnableAptitude >> endPinning [
	isPinned ifTrue: [ ^ self ].
	self
		widgetDo: [ :aWidget | 
			aWidget isAttachedToSceneGraph ifFalse: [ ^ self ].
			self performPreEndPinActions.
			pinner pinMenuElement: aWidget.
			self addCloseButton.
			isPinned := true.
			self performPostEndPinActions. ]
]

{ #category : #initialization }
BrPopoverPinnableAptitude >> initialize [
	super initialize.
	isPinned := false.
	isHideParentMenuOnPinned := true.
	pullHandler := BlPullHandler new disallowOutOfBounds.
	handleElement := self newHandleElement.
	handleElement addEventHandler: pullHandler.
	closeButton := nil.
	pinner := BrPopoverAnchorElementPinner new.
	pinningActions := Array empty.
]

{ #category : #initialization }
BrPopoverPinnableAptitude >> initializeListeners [
	super initializeListeners.

	self when: BlPullStartEvent do: [ :anEvent | self onPullStartEvent: anEvent ].
	self when: BlPullEndEvent do: [ :anEvent | self onPullEndEvent: anEvent ]
]

{ #category : #testing }
BrPopoverPinnableAptitude >> isHideParentMenuOnPinned [
	<return: #Boolean>
	^ isHideParentMenuOnPinned ifNil: [ true ]
]

{ #category : #initialization }
BrPopoverPinnableAptitude >> newCloseButton [
	^ BlElement new
		size: 5 @ 5;
		geometry: BlCircleGeometry new;
		background: self theme status paleErrorBackgroundColor;
		when: BlClickEvent do: [ :anEvent | self onCloseFrom: anEvent currentTarget ]
]

{ #category : #initialization }
BrPopoverPinnableAptitude >> newHandleElement [
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
BrPopoverPinnableAptitude >> notifyHideParentMenu [
	self menuModel ifNotNil: [ :aMenuModel | 
		aMenuModel hideAll ]
]

{ #category : #'api - hooks' }
BrPopoverPinnableAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.
	anElement clipChildren: false.
	self widget 
		addChild: handleElement 
		as: BrPopoverPinnedHandleId.
	pullHandler targetElement: self widget
]

{ #category : #'event handling' }
BrPopoverPinnableAptitude >> onCloseFrom: aButton [
	self widgetDo: [ :aWidget | 
		aWidget isAttachedToSceneGraph ifFalse: [ ^ self ].
		BlTaskAction 
			enqueueElement: aWidget 
			action: [ 
				aWidget fireEvent: BrPopoverPinnedElementAboutToBeClosed new.
				aWidget removeFromParent.
				isPinned := false ] ]
]

{ #category : #'private - event management' }
BrPopoverPinnableAptitude >> onMenuPinRequest: anAnnouncement [
	"Must be called in a UI process."
	
	self menuModel == anAnnouncement menuModel ifFalse: [ ^ self ].

	self widgetDo: [ :aWidget | 
		self startPinning.
		self endPinning ]
]

{ #category : #'event handling' }
BrPopoverPinnableAptitude >> onPullEndEvent: anEvent [
	isPinned ifTrue: [ ^ self ].
	anEvent consumed: true.
	self endPinning.
]

{ #category : #'event handling' }
BrPopoverPinnableAptitude >> onPullStartEvent: anEvent [ 
	isPinned ifTrue: [ ^ self ].
	anEvent consumed: true.
	self startPinning
]

{ #category : #'api - hooks' }
BrPopoverPinnableAptitude >> onUninstalledIn: anElement [
	super onUninstalledIn: anElement.
	handleElement removeFromParent.
	pullHandler targetElement: nil.
	closeButton ifNotNil: #removeFromParent.
	closeButton := nil.
	isPinned := false.
]

{ #category : #'private - updating' }
BrPopoverPinnableAptitude >> performPostEndPinActions [
	| aContext |
	self pinningActions ifEmpty: [ ^ self ].
	self widgetDo: [ :aWidget | 
		aContext := BrMenuPinActionContext new
			menuElement: aWidget;
			pinnableAptitude: self ].
	aContext ifNil: [ ^ self ].

	self pinningActions do: [ :eachAction |
		eachAction executePostEndPinBlockInContext: aContext ].
]

{ #category : #'private - updating' }
BrPopoverPinnableAptitude >> performPreEndPinActions [
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
BrPopoverPinnableAptitude >> performPreStartPinActions [
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
BrPopoverPinnableAptitude >> pinningActions [
	<return: #Collection of: #BrMenuPinAction>
	^ pinningActions ifNil: [ pinningActions := Array empty ]
]

{ #category : #'event handling' }
BrPopoverPinnableAptitude >> startPinning [
	isPinned ifTrue: [ ^ self ].
	self widgetDo: [ :aWidget |
		| aPosition |
		aWidget isAttachedToSceneGraph ifFalse: [ ^ self ].

		aPosition := aWidget position.
		aWidget fireEvent: (BrPopoverDetachWish new menuModel: self menuModel).
		self performPreStartPinActions.
		aWidget constraintsDo: [ :c | 
			c ignoreByLayout ].
		aWidget relocate: aPosition.
		
		self isHideParentMenuOnPinned ifTrue: [ 
			self notifyHideParentMenu ] ]
]

{ #category : #'event handling' }
BrPopoverPinnableAptitude >> subscribeToMenuModel [
	super subscribeToMenuModel.
	
	self menuModel announcer weak 
		when: BrMenuPinRequestAnnouncement
		send: #onMenuPinRequest:
		to: self
]

{ #category : #'event handling' }
BrPopoverPinnableAptitude >> unsubscribeFromMenuModel [
	super unsubscribeFromMenuModel.
	self menuModel ifNotNil: [ :aMenuModel | 
		aMenuModel announcer unsubscribe: self ]
]

{ #category : #'api - initialization' }
BrPopoverPinnableAptitude >> withAllPinActions [
	"Let's initialize menu element, e.g., by installing other event handlers."
	| allPragmas |
	allPragmas := Pragma 
		allNamed: #menuPinAction 
		from: self class 
		to: BrPopoverPinnableAptitude.
	allPragmas do: [ :eachPragma |
		(self perform: eachPragma methodSelector) ]
]

{ #category : #'api - initialization' }
BrPopoverPinnableAptitude >> withPinnedAptitude [
	<menuPinAction>
	self addPinningAction: (BrMenuPinAction new
		preEndPinBlock: [ self add: BrPopoverPinnedAptitude new ])
]

{ #category : #'api - initialization' }
BrPopoverPinnableAptitude >> withPostEndPinBlock: aOneArgBlock [
	"Define an action that is performed after a menu element is pinned.
	The block must have one argument: [ :aContext | ].
	aContext is an BrMenuPinActionContext object."

	self addPinningAction: (BrMenuPinAction new postEndPinBlock: aOneArgBlock)
]

{ #category : #'api - initialization' }
BrPopoverPinnableAptitude >> withPreEndPinBlock: aOneArgBlock [
	"Define an action that is performed after a menu element is pinned.
	The block must have one argument: [ :aContext | ].
	aContext is an BrMenuPinActionContext object."

	self addPinningAction: (BrMenuPinAction new preEndPinBlock: aOneArgBlock)
]

{ #category : #'api - initialization' }
BrPopoverPinnableAptitude >> withPreStartPinBlock: aOneArgBlock [
	"Define an action that is performed before a menu element is pinned.
	The block must have one argument: [ :aContext | ].
	aContext is an BrMenuPinActionContext object."

	self addPinningAction: (BrMenuPinAction new preStartPinBlock: aOneArgBlock)
]
