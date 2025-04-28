Class {
	#name : #BrWithExplicitPopoverAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'mouseButton',
		'modifiersMatcher',
		'menuContainer',
		'extentChangedEventHandler',
		'positionInSpaceChangedEventHandler',
		'clickOutsideEventHandler',
		'pressEscEventHandler',
		'removedFromSceneEventHandler',
		'addedToSceneEventHandler',
		'menuContainerParent',
		'relocator',
		'menuStencil',
		'submenus',
		'cacheCleaner',
		'mouseEventHandler',
		'visibilityUpdater'
	],
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #'instance creation' }
BrWithExplicitPopoverAptitude class >> handle: aHandleStencil content: aContentStencil [
	"Create a menu with a handle element and with an explicit menu element.
	aHandleStencil is a stencil that creates a BlElement instance.
	aContentStencil is a stencil that creates a BlElement instance."

	^ self new handle: aHandleStencil content: aContentStencil
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> beClickPositionRelocator [
	self
		deprecated: 'Use #withClickPositionRelocator instead.'
		transformWith: '`@receiver beClickPositionRelocator' -> '`@receiver withClickPositionRelocator'.
	self withClickPositionRelocator
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> beContextMenu [
	self withClickPositionRelocator.
	self withSecondaryMouseButton.
	self withContainerContextMenuAreas
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> beDropdown [
	self withWidgetBoundsRelocator.
	self withPrimaryMouseButton.
	self withContainerDropdown
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> beTooltipMenu [
	self withWidgetBoundsRelocator.
	self withContainerTooltipAreas.
	self withTooltipHandle
]

{ #category : #accessing }
BrWithExplicitPopoverAptitude >> cacheCleaner [
	<return: #BrPopoverCacheCleaner>
	^ cacheCleaner ifNil: [ cacheCleaner := self defaultCacheCleaner ]
]

{ #category : #accessing }
BrWithExplicitPopoverAptitude >> cacheCleaner: anObject [
	cacheCleaner := anObject
]

{ #category : #testing }
BrWithExplicitPopoverAptitude >> canHide [
	^ self visible or: [ self isTemporarilyHidden ]
]

{ #category : #testing }
BrWithExplicitPopoverAptitude >> canShow [
	self visible ifTrue: [ 
		menuContainer hasPinnedChildrenOnly ifFalse: [
			^ false ] ].
	self widgetDo: [ :aWidget | 
		^ aWidget isAttachedToSceneGraph 
			and: [ aWidget visibility shouldDraw ] ].
	^ false
]

{ #category : #'event handling' }
BrWithExplicitPopoverAptitude >> consumeClickedOutsideMouseUpEvent: anEvent [
	"Dropdown and context menu want to consume the event.
	As a consequence, no other actions are triggered.
	For example:
	- no new dropdown or context menu is opened,
	- no button action is executed."

	anEvent consumed: true
]

{ #category : #'api - menu' }
BrWithExplicitPopoverAptitude >> content: aBlockOrStencil [
	"Set explicit menu with a default handle"

	^ self handleSubmenu: (BrMenuExplicit new stencil: aBlockOrStencil)
]

{ #category : #initialization }
BrWithExplicitPopoverAptitude >> defaultCacheCleaner [
	^ BrPopoverCacheCleaner allCleaner
]

{ #category : #initialization }
BrWithExplicitPopoverAptitude >> defaultElementBuilder [
	^ BrMenuElementBuilder new
]

{ #category : #initialization }
BrWithExplicitPopoverAptitude >> defaultMenuContainerPadding [
	^ BlInsets all: 20
]

{ #category : #initialization }
BrWithExplicitPopoverAptitude >> defaultModifiersMatcher [
	^ [ :aBlKeyModifiers | true ]
]

{ #category : #initialization }
BrWithExplicitPopoverAptitude >> defaultMouseEventHandler [
	^ self newMouseUpEventHandler
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> doNotShowOnClick [
	"Do not show menu on click"

	self withoutMouseEventHandler
]

{ #category : #accessing }
BrWithExplicitPopoverAptitude >> elementBuilder [
	<return: #BrMenuElementBuilder>
	^ menuContainer elementBuilder
]

{ #category : #accessing }
BrWithExplicitPopoverAptitude >> elementBuilder: anElementBuilder [
	menuContainer elementBuilder: anElementBuilder
]

{ #category : #'api - menu' }
BrWithExplicitPopoverAptitude >> handle: aHandleStencil content: aContentStencil [
	"Set a menu with a handle element and with an explicit menu element.
	aHandleStencil is a stencil that creates a BlElement instance.
	aContentStencil is a stencil that creates a BlElement instance."

	self
		handle: aHandleStencil
		submenu: (BrMenuExplicit new stencil: aContentStencil)
]

{ #category : #'api - menu' }
BrWithExplicitPopoverAptitude >> handle: aHandleStencil submenu: aMenuStencil [
	"Initialize a menu with a handle.
	aHandleBlock is a stencil that creates a BlElement instance.
	aMenuBlock is a stencil that creates a BrMenu instance."

	self stencil: (BrMenuExplicitHandle new
		handle: aHandleStencil;
		submenu: aMenuStencil)
]

{ #category : #'api - menu' }
BrWithExplicitPopoverAptitude >> handleSubmenu: aMenuBlockOrStencil [
	"Set a stencil that creates a menu model.
	The stencil returns a BrMenu instance."

	self stencil: (BrMenuExplicitHandle new submenu: aMenuBlockOrStencil)
]

{ #category : #'event handling' }
BrWithExplicitPopoverAptitude >> hasModifiers: anEvent [
	"Return true if any modifiers are pressed"

	<return: #Boolean>
	^ anEvent modifiers isAlt or: [ 
		  anEvent modifiers isCmd or: [ 
			  anEvent modifiers isCtrl or: [ 
				  anEvent modifiers isShift ] ] ]
]

{ #category : #testing }
BrWithExplicitPopoverAptitude >> haveAnyVisibleSubmenu [
	^ self submenus anySatisfy: #isAttachedToSceneGraph
]

{ #category : #'api - displaying' }
BrWithExplicitPopoverAptitude >> hide [
	self canHide ifFalse: [ ^ self ].
	
	self hideSubmenus.
	
	menuContainer menuModel ifNotNil: [ :aMenu | 
		aMenu hide ].
	self cacheCleaner cleanMenuContainer: menuContainer.
	
	self widgetDo: [ :aWidget | 
		menuContainer childrenCount isZero ifTrue: [
			aWidget
				removeEventHandler: extentChangedEventHandler;
				removeEventHandler: positionInSpaceChangedEventHandler;
				removeEventHandler: addedToSceneEventHandler;
				removeEventHandler: removedFromSceneEventHandler.
			self temporarilyHide.
			self fireEvent: (BrPopoverIsHiddenEvent new
				menuModel: menuContainer menuModel;
				menuContainer: menuContainer).
			self onHidden ] ]
]

{ #category : #private }
BrWithExplicitPopoverAptitude >> hideSubmenus [
	self haveAnyVisibleSubmenu ifFalse: [ ^ self ].
	
	self submenus do: [ :eachElement | 
		eachElement fireEvent: BrPopoverHideAllWish new ]
]

{ #category : #initialization }
BrWithExplicitPopoverAptitude >> initialize [
	super initialize.
	mouseButton := BlMouseButton secondary.
	modifiersMatcher := self defaultModifiersMatcher.
	submenus := IdentitySet new: 1.
	cacheCleaner := self defaultCacheCleaner.

	self initializeMenuContainer.
	self initializeEventHandlers.

	self
		addChange: (BrLookChange new
				up: [ :e |  ];
				down: [ :e | self hide ];
				yourself).
				
	self mouseEventHandler: self defaultMouseEventHandler.
	self withDefaultHandle
]

{ #category : #initialization }
BrWithExplicitPopoverAptitude >> initializeEventHandlers [
	addedToSceneEventHandler := BlEventHandler
			on: BlElementAddedToSceneGraphEvent
			do: [ :anEvent | self onWidgetAddedToSceneGraph: anEvent ].

	removedFromSceneEventHandler := BlEventHandler
			on: BlElementRemovedFromSceneGraphEvent
			do: [ :anEvent | self onWidgetRemovedFromSceneGraph: anEvent ].

	extentChangedEventHandler := BlEventHandler
			on: BlElementExtentChangedEvent
			do: [ :anEvent | self onWidgetExtentChanged: anEvent ].

	positionInSpaceChangedEventHandler := BlEventHandler
			on: BlElementPositionInSpaceChangedEvent
			do: [ :anEvent | self onWidgetPositionChanged: anEvent ].

	clickOutsideEventHandler := BlEventHandler
			on: BlMouseUpEvent
			do: [ :anEvent | self onClickedOutsideMouseUpEvent: anEvent ].

	pressEscEventHandler := BlShortcutWithAction new
			combination: BlKeyCombination escape;
			action: [ :anEvent | self onEscapeKeyCombinationEvent: anEvent ]
]

{ #category : #initialization }
BrWithExplicitPopoverAptitude >> initializeMenuContainer [
	menuContainer := BrMenuSteppedElement new.
	menuContainer elementBuilder: self defaultElementBuilder.
	menuContainer addAptitude: BrPopoverContainerAptitude new.
	menuContainer padding: self defaultMenuContainerPadding.
	menuContainerParent := nil.
	relocator := BrPopoverClickPositionRelocator new menuContainer: menuContainer.
	visibilityUpdater := BrPopoverContainerInSpaceVisibilityUpdater new menuContainer: menuContainer.
	menuContainer
		when: BrPopoverWhoToPinToEvent
		do: [ :anEvent | self onWhoToPinToEvent: anEvent ].
	menuContainer
		when: BrPopoverAnchorElementWish
		do: [ :anEvent | self onAnchorElementRequest: anEvent ].
	menuContainer
		when: BrPopoverHideAllWish
		do: [ :anEvent | self onHideAllWish: anEvent ].
	menuContainer
		when: BrPopoverIsVisibleEvent
		do: [ :anEvent | self onMenuIsVisibleEvent: anEvent ].
	menuContainer
		when: BrPopoverIsHiddenEvent
		do: [ :anEvent | self onMenuIsHiddenEvent: anEvent ].
	menuContainer
		when: BrPopoverElementAdded
		do: [ :anEvent | self onMenuElementAddedEvent: anEvent ].
	menuContainer
		when: BrPopoverElementRemoved
		do: [ :anEvent | self onMenuElementRemovedEvent: anEvent ]
]

{ #category : #testing }
BrWithExplicitPopoverAptitude >> isTemporarilyHidden [
	self
		widgetDo: [ :aWidget | 
			^ (aWidget hasEventHandler: addedToSceneEventHandler)
				and: [ (aWidget hasEventHandler: clickOutsideEventHandler) not ] ].
	^ false
]

{ #category : #'api - menu' }
BrWithExplicitPopoverAptitude >> menu: aMenuBlock [
	self stencil: aMenuBlock
]

{ #category : #accessing }
BrWithExplicitPopoverAptitude >> menuContainer [
	<return: #BrMenuSteppedElement>
	^ menuContainer
]

{ #category : #accessing }
BrWithExplicitPopoverAptitude >> menuContainerDo: aBlock [
	"Initialize menu container, e.g., setting background and border."

	aBlock value: menuContainer
]

{ #category : #'api - menu' }
BrWithExplicitPopoverAptitude >> modifiersMatcher [
	"Return the modifiers matcher in a form of [ :aBlKeyModifiers | true ] that is used
	to test whether the menu should be opened"

	^ modifiersMatcher ifNil: [ modifiersMatcher := self defaultModifiersMatcher ]
]

{ #category : #'api - menu' }
BrWithExplicitPopoverAptitude >> modifiersMatcher: aBlockOrSymbol [
	"Customize the modifiers matcher in a form of [ :aBlKeyModifiers | true ] that is used
	to test whether the context menu should be opened"

	modifiersMatcher := aBlockOrSymbol
]

{ #category : #'api - menu' }
BrWithExplicitPopoverAptitude >> mouseButton [
	^ mouseButton
]

{ #category : #accessing }
BrWithExplicitPopoverAptitude >> mouseEventHandler [
	<return: #BrPopoverMouseEventHandler>
	^ mouseEventHandler
]

{ #category : #accessing }
BrWithExplicitPopoverAptitude >> mouseEventHandler: aBrMenuMouseEventHandler [
	mouseEventHandler == aBrMenuMouseEventHandler ifTrue: [ ^ self ].

	self withoutMouseEventHandler.
	mouseEventHandler := aBrMenuMouseEventHandler.
	self addEventHandler: aBrMenuMouseEventHandler
]

{ #category : #initialization }
BrWithExplicitPopoverAptitude >> newMouseHoverEventHandler [
	^ BrPopoverMouseHoverEventHandler new menuAptitude: self
]

{ #category : #initialization }
BrWithExplicitPopoverAptitude >> newMouseUpEventHandler [
	^ BrPopoverMouseUpEventHandler new menuAptitude: self
]

{ #category : #'event handling' }
BrWithExplicitPopoverAptitude >> onAnchorElementRequest: anEvent [ 
	anEvent consumed: true.
	self widgetDo: [ :aWidget | 
		anEvent anchorElement: aWidget ]
]

{ #category : #'api - hooks' }
BrWithExplicitPopoverAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.
	
	menuContainer anchor: anElement.
]

{ #category : #'event handling' }
BrWithExplicitPopoverAptitude >> onClickedOutsideMouseUpEvent: anEvent [
	"Hide when clicked outside of the container" 
	anEvent target == menuContainer ifTrue: [ ^ self ].
	
	(menuContainer isUnpinnedChild: anEvent target)
		ifTrue: [ ^ self ].
	
	self submenus do: [ :eachSubmenuContainer |
		(eachSubmenuContainer isUnpinnedChild: anEvent target)
			ifTrue: [ ^ self ] ].

	self consumeClickedOutsideMouseUpEvent: anEvent.
	self hide.
]

{ #category : #'event handling' }
BrWithExplicitPopoverAptitude >> onEscapeKeyCombinationEvent: anEvent [ 
	anEvent consumed: true.
	self hide
]

{ #category : #'private - event management' }
BrWithExplicitPopoverAptitude >> onHidden [
	"Subclasses may act when the menu is hidden"

	
]

{ #category : #'event handling' }
BrWithExplicitPopoverAptitude >> onHideAllWish: anEvent [ 
	anEvent consumed: true.
	self hide
]

{ #category : #'event handling' }
BrWithExplicitPopoverAptitude >> onHideWish: aWish [
	"hide on wish"
	
	"if an anchor is explicitely specified we can hide"
	(aWish anchor = widget)
		ifTrue: [
			aWish consumed: true.
			^ self hide ].
	
	"if anchor is not specified and the source is within the widget - hide"
	(aWish anchor isNil and: [ aWish source = widget or: [ aWish source hasParent: widget ] ])
		ifTrue: [ 
			aWish consumed: true.
			^ self hide ].
		
	"if anchor is not specified and the source is within the outer container - hide"
	(aWish anchor isNil and: [ menuContainer notNil  and: [ aWish source = menuContainer or: [ aWish source hasParent: menuContainer ] ] ])
		ifTrue: [ 
			aWish consumed: true.
			^ self hide ]
]

{ #category : #initialization }
BrWithExplicitPopoverAptitude >> onMenuElementAddedEvent: anEvent [
	self
		dispatchEvent: (BrPopoverElementAdded new
				menuModel: anEvent menuModel;
				menuElement: anEvent menuElement)
]

{ #category : #initialization }
BrWithExplicitPopoverAptitude >> onMenuElementRemovedEvent: anEvent [
	self
		dispatchEvent: (BrPopoverElementRemoved new
				menuModel: anEvent menuModel;
				menuElement: anEvent menuElement)
]

{ #category : #'event handling' }
BrWithExplicitPopoverAptitude >> onMenuIsHiddenEvent: anEvent [
	anEvent consumed: true.
	self submenus remove: anEvent menuContainer ifAbsent: [ "ignore" ]
]

{ #category : #'event handling' }
BrWithExplicitPopoverAptitude >> onMenuIsVisibleEvent: anEvent [
	anEvent consumed: true.
	self submenus add: anEvent menuContainer
]

{ #category : #'event handling' }
BrWithExplicitPopoverAptitude >> onShowWish: aWish [
	self canShow
		ifFalse: [ ^ self ].
	
	"if an anchor is explicitely specified we can show"
	(aWish anchor = widget)
		ifTrue: [
			aWish consumed: true.
			^ self show ].
	
	"if anchor is not specify we can check the source of the wish"
	(aWish anchor isNil and: [ aWish source = widget or: [ aWish source hasParent: widget ] ])
		ifTrue: [ 
			aWish consumed: true.
			^ self show ]
]

{ #category : #'private - event management' }
BrWithExplicitPopoverAptitude >> onShown [
	"Subclasses may act when the menu is shown"

	
]

{ #category : #'api - hooks' }
BrWithExplicitPopoverAptitude >> onUninstalledIn: anElement [
	self hide.
	menuContainer anchor: nil.

	super onUninstalledIn: anElement.
]

{ #category : #'event handling' }
BrWithExplicitPopoverAptitude >> onWhoToPinToEvent: anEvent [ 
	anEvent consumed: true.
	self widgetDo: [ :aWidget |
		| anotherEvent |
		anotherEvent := BrPopoverWhoToPinToEvent new.
		aWidget fireEvent: anotherEvent.
		anotherEvent anchorElement ifNotNil: [ :anElement |
			anEvent anchorElement: anElement ] ]
]

{ #category : #'event handling' }
BrWithExplicitPopoverAptitude >> onWidgetAddedToSceneGraph: anEvent [
	self temporarilyShow
]

{ #category : #'event handling' }
BrWithExplicitPopoverAptitude >> onWidgetExtentChanged: anEvent [ 
	self visible ifTrue: [ self relocate ]
]

{ #category : #'event handling' }
BrWithExplicitPopoverAptitude >> onWidgetPositionChanged: anEvent [ 
	self visible ifTrue: [ self relocate ]
]

{ #category : #'event handling' }
BrWithExplicitPopoverAptitude >> onWidgetRemovedFromSceneGraph: anEvent [
	anEvent consumed: true.
	self temporarilyHide
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> preferredChildWeight: aNumber [
	"Argument is a value between 0.0 and 1.0.
	The value is used to compute maximum child width.
	See BlSteppedLayoutState>>#estimateWidthSpecOf: for more details."

	menuContainer layout preferredChildWeight: aNumber
]

{ #category : #deprecated }
BrWithExplicitPopoverAptitude >> preferredExtent: aPoint [
	"ignore"

	
]

{ #category : #private }
BrWithExplicitPopoverAptitude >> relocate [
	self widgetDo: [ :aWidget | 
		relocator relocateGiven: aWidget.
		self visibilityUpdater updateGiven: aWidget ]
]

{ #category : #'api - relocating' }
BrWithExplicitPopoverAptitude >> relocator [
	<return: #BrPopoverContainerRelocator>
	^ relocator
]

{ #category : #'api - relocating' }
BrWithExplicitPopoverAptitude >> relocator: aBrMenuContainerRelocator [
	aBrMenuContainerRelocator menuContainer: menuContainer.
	relocator := aBrMenuContainerRelocator
]

{ #category : #'api - demo' }
BrWithExplicitPopoverAptitude >> removeClickOutsideEventHandler [
	"I am used for demo purposes, e.g., creating slides"

	menuContainerParent ifNotNil: [ :aParent | 
		aParent removeEventFilter: clickOutsideEventHandler ]
]

{ #category : #'api - demo' }
BrWithExplicitPopoverAptitude >> removePressEscEventHandler [
	"I am used for demo purposes, e.g., creating slides"
	
	menuContainerParent ifNotNil: [ :aParent | 
		aParent removeShortcut: pressEscEventHandler ]
]

{ #category : #'api - demo' }
BrWithExplicitPopoverAptitude >> removeSceneEventHandlers [
	"I am used for demo purposes, e.g., creating slides"
	
	self widgetDo: [ :aWidget | 
		aWidget
			removeEventHandler: addedToSceneEventHandler;
			removeEventHandler: removedFromSceneEventHandler ]
]

{ #category : #'api - displaying' }
BrWithExplicitPopoverAptitude >> show [
	self showDueTo: nil
]

{ #category : #'api - displaying' }
BrWithExplicitPopoverAptitude >> showDueTo: anEventOrNil [
	"The event parameter must be one with a position, `nil` otherwise."

	self canShow ifFalse: [ ^ self ].

	self
		widgetDo: [ :aWidget | 
			| aParent |
			aWidget dispatchEvent: BrTooltipHideWish new.
			aParent := aWidget topMostParent.
			self showIn: aParent dueToEvent: anEventOrNil ]
]

{ #category : #private }
BrWithExplicitPopoverAptitude >> showIn: aParentElement dueToEvent: anEventOrNil [
	"The event parameter must be one with a position, `nil` otherwise."

	| aMenu |
	menuStencil ifNil: [ ^ self ].
	self hide.
	
	self widgetDo: [ :aWidget |
		aMenu := menuStencil 
			context: (BrMenuInitialContext new
				elementBuilder: menuContainer elementBuilder;
				anchorElement: aWidget;
				menuAptitude: self;
				dueToEvent: anEventOrNil);
			build ].
	aMenu ifNil: [ ^ self ].
	menuContainer menuModel: aMenu.
	menuContainer show.
	
	self widgetDo: [ :aWidget |
		aWidget 
			addEventHandler: extentChangedEventHandler;
			addEventHandler: positionInSpaceChangedEventHandler;
			addEventHandler: addedToSceneEventHandler;
			addEventHandler: removedFromSceneEventHandler ].
	
	self temporarilyShowIn: aParentElement.
	
	self fireEvent: (BrPopoverIsVisibleEvent new
			menuModel: aMenu;
			menuContainer: menuContainer).
	self onShown.
]

{ #category : #'api - menu' }
BrWithExplicitPopoverAptitude >> stencil [
	<return: #BrMenuInitialStencilBuilder or: nil>
	^ menuStencil
]

{ #category : #'api - menu' }
BrWithExplicitPopoverAptitude >> stencil: aStencilBuilder [
	"Set a stencil that creates a menu model.
	The stencil builder can be a block with one argument: [ :aBrMenuInitialContext | ].
	The stencil builder returns a BrMenuModel instance or nil.
	The stencil builder is responsible for building BrMenuHandle models if expected to be used."

	menuStencil := aStencilBuilder asStencilBuilder: BrMenuInitialStencilBuilder
]

{ #category : #accessing }
BrWithExplicitPopoverAptitude >> submenus [
	"Return menu container elements that were opened from this context menu"

	<return: #IdentitySet of: #BrMenuSteppedElement>
	^ submenus ifNil: [ submenus := IdentitySet new: 1 ]
]

{ #category : #private }
BrWithExplicitPopoverAptitude >> temporarilyHide [
	"Temporarily hide without destroying menu content"

	menuContainer removeFromParent.
	menuContainerParent ifNotNil: [ :aParent | 
		menuContainerParent := nil.
		aParent removeEventFilter: clickOutsideEventHandler.
		aParent removeShortcut: pressEscEventHandler. ].
]

{ #category : #private }
BrWithExplicitPopoverAptitude >> temporarilyShow [
	"Re-add temporarily hiden menu container without reconstructing its menu content"

	self widgetDo: [ :aWidget | 
		| aParent |
		aParent := aWidget topMostParent.
		self temporarilyShowIn: aParent ]
]

{ #category : #private }
BrWithExplicitPopoverAptitude >> temporarilyShowIn: aParentElement [
	menuContainerParent := aParentElement.
	aParentElement addEventFilter: clickOutsideEventHandler.
	aParentElement addShortcut: pressEscEventHandler.
	
	menuContainer parent == aParentElement ifFalse: [
		menuContainer removeFromParent.
		aParentElement addChild: menuContainer ].
	self relocate.
]

{ #category : #'api - menu' }
BrWithExplicitPopoverAptitude >> useSecondaryMouseButton [
	self withSecondaryMouseButton
]

{ #category : #accessing }
BrWithExplicitPopoverAptitude >> visibilityUpdater [
	<return: #BrPopoverContainerVisibilityUpdater>
	^ visibilityUpdater ifNil: [ visibilityUpdater := BrPopoverContainerInSpaceVisibilityUpdater new menuContainer: menuContainer ].
]

{ #category : #accessing }
BrWithExplicitPopoverAptitude >> visibilityUpdater: aBrPopoverContainerVisibilityUpdater [
	aBrPopoverContainerVisibilityUpdater menuContainer: menuContainer.

	visibilityUpdater := aBrPopoverContainerVisibilityUpdater
]

{ #category : #testing }
BrWithExplicitPopoverAptitude >> visible [
	<return: #Boolean>
	^ menuContainer isAttachedToSceneGraph
]

{ #category : #'api - displaying' }
BrWithExplicitPopoverAptitude >> visible: aBoolean [
	aBoolean ifTrue: [ self show ] ifFalse: [ self hide ]
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> withAllExtraEventHandlers [
	"Let's initialize menu container with other event handlers, e.g., spawn."
	| allPragmas |
	allPragmas := Pragma 
		allNamed: #menuContainerInitialization 
		from: self class 
		to: BrWithExplicitPopoverAptitude.
	allPragmas do: [ :eachPragma |
		self perform: eachPragma methodSelector ]
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> withCenteredHandle [
	menuContainer withCenteredHandle
]

{ #category : #'api - relocating' }
BrWithExplicitPopoverAptitude >> withClickPositionRelocator [
	self relocator: BrPopoverClickPositionRelocator new
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> withContainerAreaBuilders: aCollectionOfAreaBuilders [
	menuContainer layout areaBuilders: aCollectionOfAreaBuilders
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> withContainerContextMenuAreas [
	menuContainer withContextMenuAreas
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> withContainerDownUpDropdown [
	"Place dropdowns only down or up"

	menuContainer withDownUpDropdownAreas
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> withContainerDropdown [
	menuContainer withDropdownAreas
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> withContainerInSpaceVisibilityUpdater [
	self visibilityUpdater: (BrPopoverContainerInSpaceVisibilityUpdater new menuContainer: menuContainer)
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> withContainerPermanentVisibilityUpdater [
	self visibilityUpdater: (BrPopoverContainerPermanentVisibilityUpdater new menuContainer: menuContainer)
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> withContainerTooltipAreas [
	menuContainer withTooltipAreas
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> withDefaultHandle [
	self withCenteredHandle
]

{ #category : #'api - menu' }
BrWithExplicitPopoverAptitude >> withHandleSubmenu: aMenuBlock [
	self
		deprecated: 'Use handleSubmenu: instead'
		transformWith: '`@receiver withHandleSubmenu: `@argument'
			-> '`@receiver handleSubmenu: `@argument'.
	self handleSubmenu: aMenuBlock
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> withKeepAllCacheCleaner [
	self cacheCleaner: BrPopoverCacheCleaner allKeeper
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> withMouseHoverEventHandler [
	"Show menu on mouse enter events."

	self mouseEventHandler: self newMouseHoverEventHandler
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> withMouseUpEventHandler [
	"Show menu on click events."

	self mouseEventHandler: self newMouseUpEventHandler
]

{ #category : #'api - menu' }
BrWithExplicitPopoverAptitude >> withPrimaryMouseButton [
	mouseButton := BlMouseButton primary
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> withRemoveAllCacheCleaner [
	self cacheCleaner: BrPopoverCacheCleaner allCleaner
]

{ #category : #'api - menu' }
BrWithExplicitPopoverAptitude >> withSecondaryMouseButton [
	mouseButton := BlMouseButton secondary
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> withSuboptimalAreaFinder: anAreaFinder [
	"Set area finder that is used when there is not an available area 
	with enough space for a given child node.
	See {{gtMethod:BlSteppedLayoutState>>#placeMeasuredChild:}} for more details."
	
	menuContainer suboptimalAreaFinder: anAreaFinder
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> withTooltipHandle [
	menuContainer withTooltipHandle
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> withTopLeftHandle [
	menuContainer withTopLeftHandle
]

{ #category : #'api - relocating' }
BrWithExplicitPopoverAptitude >> withVisibleWidgetBoundsRelocator [
	self relocator: BrPopoverVisibleWidgetBoundsRelocator new
]

{ #category : #'api - relocating' }
BrWithExplicitPopoverAptitude >> withWidgetBoundsRelocator [
	self relocator: BrPopoverWidgetBoundsRelocator new
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> withoutHandle [
	menuContainer withoutHandle
]

{ #category : #'api - initialization' }
BrWithExplicitPopoverAptitude >> withoutMouseEventHandler [
	"Do not show menu on click"

	mouseEventHandler ifNil: [ ^ self ].
	self removeEventHandler: mouseEventHandler.
	mouseEventHandler := nil
]
