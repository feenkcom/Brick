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

{ #category : #'private - notifying' }
BrMenuPinnableAptitude >> notifyHideParentMenu [
	self menuModel ifNotNil: [ :aMenuModel | 
		aMenuModel hideAll ]
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

{ #category : #'as yet unclassified' }
BrMenuPinnableAptitude >> pinningActions [
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
		when: BrMenuPinRequest
		send: #onMenuPinRequest:
		to: self
]

{ #category : #'event handling' }
BrMenuPinnableAptitude >> unsubscribeFromMenuModel [
	super unsubscribeFromMenuModel.
	self menuModel announcer unsubscribe: self
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
