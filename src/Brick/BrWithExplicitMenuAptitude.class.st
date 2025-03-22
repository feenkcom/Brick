Class {
	#name : #BrWithExplicitMenuAptitude,
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
		'mouseEventHandler'
	],
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #'instance creation' }
BrWithExplicitMenuAptitude class >> handle: aHandleStencil content: aContentStencil [
	"Create a menu with a handle element and with an explicit menu element.
	aHandleStencil is a stencil that creates a BlElement instance.
	aContentStencil is a stencil that creates a BlElement instance."

	^ self new handle: aHandleStencil content: aContentStencil
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> beClickPositionRelocator [
	self
		deprecated: 'Use #withClickPositionRelocator instead.'
		transformWith: '`@receiver beClickPositionRelocator' -> '`@receiver withClickPositionRelocator'.
	self withClickPositionRelocator
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> beContextMenu [
	self withClickPositionRelocator.
	self withSecondaryMouseButton.
	self withContainerContextMenuAreas
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> beDropdown [
	self withWidgetBoundsRelocator.
	self withPrimaryMouseButton.
	self withContainerDropdown
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> beTooltipMenu [
	self withWidgetBoundsRelocator.
	self withContainerTooltipAreas.
	self withTooltipHandle
]

{ #category : #accessing }
BrWithExplicitMenuAptitude >> cacheCleaner [
	<return: #BrMenuCacheCleaner>
	^ cacheCleaner ifNil: [ cacheCleaner := self defaultCacheCleaner ]
]

{ #category : #accessing }
BrWithExplicitMenuAptitude >> cacheCleaner: anObject [
	cacheCleaner := anObject
]

{ #category : #testing }
BrWithExplicitMenuAptitude >> canHide [
	^ self visible or: [ self isTemporarilyHidden ]
]

{ #category : #testing }
BrWithExplicitMenuAptitude >> canShow [
	self visible ifTrue: [ 
		menuContainer hasPinnedChildrenOnly ifFalse: [
			^ false ] ].
	self widgetDo: [ :aWidget | 
		^ aWidget isAttachedToSceneGraph 
			and: [ aWidget visibility shouldDraw ] ].
	^ false
]

{ #category : #initialization }
BrWithExplicitMenuAptitude >> defaultCacheCleaner [
	^ BrMenuCacheCleaner allCleaner
]

{ #category : #initialization }
BrWithExplicitMenuAptitude >> defaultElementBuilder [
	^ BrMenuElementBuilder new
]

{ #category : #initialization }
BrWithExplicitMenuAptitude >> defaultMenuContainerPadding [
	^ BlInsets all: 20
]

{ #category : #initialization }
BrWithExplicitMenuAptitude >> defaultModifiersMatcher [
	^ [ :aBlKeyModifiers | true ]
]

{ #category : #initialization }
BrWithExplicitMenuAptitude >> defaultMouseEventHandler [
	^ self newMouseUpEventHandler
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> doNotShowOnClick [
	"Do not show menu on click"

	self withoutMouseEventHandler
]

{ #category : #accessing }
BrWithExplicitMenuAptitude >> elementBuilder [
	<return: #BrMenuElementBuilder>
	^ menuContainer elementBuilder
]

{ #category : #accessing }
BrWithExplicitMenuAptitude >> elementBuilder: anElementBuilder [
	menuContainer elementBuilder: anElementBuilder
]

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> handle: aHandleStencil content: aContentStencil [
	"Set a menu with a handle element and with an explicit menu element.
	aHandleStencil is a stencil that creates a BlElement instance.
	aContentStencil is a stencil that creates a BlElement instance."

	self
		handle: aHandleStencil
		submenu: (BrMenuExplicit new stencil: aContentStencil)
]

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> handle: aHandleStencil submenu: aMenuStencil [
	"Initialize a menu with a handle.
	aHandleBlock is a stencil that creates a BlElement instance.
	aMenuBlock is a stencil that creates a BrMenu instance."

	self stencil: (BrMenuExplicitHandle new
		handle: aHandleStencil;
		submenu: aMenuStencil)
]

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> handleSubmenu: aMenuBlockOrStencil [
	"Set a stencil that creates a menu model.
	The stencil returns a BrMenu instance."

	self stencil: (BrMenuExplicitHandle new submenu: aMenuBlockOrStencil)
]

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> hasModifiers: anEvent [
	"Return true if any modifiers are pressed"

	<return: #Boolean>
	^ anEvent modifiers isAlt or: [ 
		  anEvent modifiers isCmd or: [ 
			  anEvent modifiers isCtrl or: [ 
				  anEvent modifiers isShift ] ] ]
]

{ #category : #testing }
BrWithExplicitMenuAptitude >> haveAnyVisibleSubmenu [
	^ self submenus anySatisfy: #isAttachedToSceneGraph
]

{ #category : #'api - displaying' }
BrWithExplicitMenuAptitude >> hide [
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
			self fireEvent: (BrMenuIsHiddenEvent new
				menuModel: menuContainer menuModel;
				menuContainer: menuContainer).
			self onHidden ] ]
]

{ #category : #private }
BrWithExplicitMenuAptitude >> hideSubmenus [
	self haveAnyVisibleSubmenu ifFalse: [ ^ self ].
	
	self submenus do: [ :eachElement | 
		eachElement fireEvent: BrMenuHideAllWish new ]
]

{ #category : #initialization }
BrWithExplicitMenuAptitude >> initialize [
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
BrWithExplicitMenuAptitude >> initializeEventHandlers [
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
BrWithExplicitMenuAptitude >> initializeMenuContainer [
	menuContainer := BrMenuSteppedElement new.
	menuContainer elementBuilder: self defaultElementBuilder.
	menuContainer addAptitude: BrMenuContainerAptitude new.
	menuContainer padding: self defaultMenuContainerPadding.
	menuContainerParent := nil.
	relocator := BrMenuClickPositionRelocator new menuContainer: menuContainer.
	menuContainer
		when: BrMenuWhoToPinToEvent
		do: [ :anEvent | self onWhoToPinToEvent: anEvent ].
	menuContainer
		when: BrMenuAnchorElementWish
		do: [ :anEvent | self onAnchorElementRequest: anEvent ].
	menuContainer
		when: BrMenuHideAllWish
		do: [ :anEvent | self onHideAllWish: anEvent ].
	menuContainer
		when: BrMenuIsVisibleEvent
		do: [ :anEvent | self onMenuIsVisibleEvent: anEvent ].
	menuContainer
		when: BrMenuIsHiddenEvent
		do: [ :anEvent | self onMenuIsHiddenEvent: anEvent ].
	menuContainer
		when: BrMenuElementAdded
		do: [ :anEvent | self onMenuElementAddedEvent: anEvent ].
	menuContainer
		when: BrMenuElementRemoved
		do: [ :anEvent | self onMenuElementRemovedEvent: anEvent ]
]

{ #category : #testing }
BrWithExplicitMenuAptitude >> isTemporarilyHidden [
	self
		widgetDo: [ :aWidget | 
			^ (aWidget hasEventHandler: addedToSceneEventHandler)
				and: [ (aWidget hasEventHandler: clickOutsideEventHandler) not ] ].
	^ false
]

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> menu: aMenuBlock [
	self stencil: aMenuBlock
]

{ #category : #accessing }
BrWithExplicitMenuAptitude >> menuContainer [
	<return: #BrMenuSteppedElement>
	^ menuContainer
]

{ #category : #accessing }
BrWithExplicitMenuAptitude >> menuContainerDo: aBlock [
	"Initialize menu container, e.g., setting background and border."

	aBlock value: menuContainer
]

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> modifiersMatcher [
	"Return the modifiers matcher in a form of [ :aBlKeyModifiers | true ] that is used
	to test whether the menu should be opened"

	^ modifiersMatcher ifNil: [ modifiersMatcher := self defaultModifiersMatcher ]
]

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> modifiersMatcher: aBlockOrSymbol [
	"Customize the modifiers matcher in a form of [ :aBlKeyModifiers | true ] that is used
	to test whether the context menu should be opened"

	modifiersMatcher := aBlockOrSymbol
]

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> mouseButton [
	^ mouseButton
]

{ #category : #accessing }
BrWithExplicitMenuAptitude >> mouseEventHandler [
	<return: #BrMenuMouseEventHandler>
	^ mouseEventHandler
]

{ #category : #accessing }
BrWithExplicitMenuAptitude >> mouseEventHandler: aBrMenuMouseEventHandler [
	mouseEventHandler == aBrMenuMouseEventHandler ifTrue: [ ^ self ].

	self withoutMouseEventHandler.
	mouseEventHandler := aBrMenuMouseEventHandler.
	self addEventHandler: aBrMenuMouseEventHandler
]

{ #category : #initialization }
BrWithExplicitMenuAptitude >> newMouseUpEventHandler [
	^ BrMenuMouseUpEventHandler new menuAptitude: self
]

{ #category : #initialization }
BrWithExplicitMenuAptitude >> newTooltipEventHandler [
	^ BrMenuTooltipEventHandler new menuAptitude: self
]

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> onAnchorElementRequest: anEvent [ 
	anEvent consumed: true.
	self widgetDo: [ :aWidget | 
		anEvent anchorElement: aWidget ]
]

{ #category : #'api - hooks' }
BrWithExplicitMenuAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.
	
	menuContainer anchor: anElement.
]

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> onClickedOutsideMouseUpEvent: anEvent [
	"Hide when clicked outside of the container" 
	anEvent target == menuContainer ifTrue: [ ^ self ].
	
	(menuContainer isUnpinnedChild: anEvent target)
		ifTrue: [ ^ self ].
	
	self submenus do: [ :eachSubmenuContainer |
		(eachSubmenuContainer isUnpinnedChild: anEvent target)
			ifTrue: [ ^ self ] ].

	anEvent consumed: true.
	self hide.
]

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> onEscapeKeyCombinationEvent: anEvent [ 
	anEvent consumed: true.
	self hide
]

{ #category : #'private - event management' }
BrWithExplicitMenuAptitude >> onHidden [
	"Subclasses may act when the menu is hidden"

	
]

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> onHideAllWish: anEvent [ 
	anEvent consumed: true.
	self hide
]

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> onHideWish: aWish [
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
BrWithExplicitMenuAptitude >> onMenuElementAddedEvent: anEvent [
	self
		dispatchEvent: (BrMenuElementAdded new
				menuModel: anEvent menuModel;
				menuElement: anEvent menuElement)
]

{ #category : #initialization }
BrWithExplicitMenuAptitude >> onMenuElementRemovedEvent: anEvent [
	self
		dispatchEvent: (BrMenuElementRemoved new
				menuModel: anEvent menuModel;
				menuElement: anEvent menuElement)
]

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> onMenuIsHiddenEvent: anEvent [
	anEvent consumed: true.
	self submenus remove: anEvent menuContainer ifAbsent: [ "ignore" ]
]

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> onMenuIsVisibleEvent: anEvent [
	anEvent consumed: true.
	self submenus add: anEvent menuContainer
]

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> onMouseUp: anEvent [
	"Note: to be removed.
	Replaced by BrMenuMouseUpEventHandler."

	anEvent button = mouseButton
		ifFalse: [ ^ self ].
	
	(modifiersMatcher value: anEvent modifiers)
		ifFalse: [ ^ self ].

	anEvent consumed: true.
	
	self widgetDo: [ :aWidget | 
		relocator mouseUp: anEvent given: aWidget ].
	
	self showDueTo: anEvent
]

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> onShowWish: aWish [
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
BrWithExplicitMenuAptitude >> onShown [
	"Subclasses may act when the menu is shown"

	
]

{ #category : #'api - hooks' }
BrWithExplicitMenuAptitude >> onUninstalledIn: anElement [
	self hide.
	menuContainer anchor: nil.

	super onUninstalledIn: anElement.
]

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> onWhoToPinToEvent: anEvent [ 
	anEvent consumed: true.
	self widgetDo: [ :aWidget |
		| anotherEvent |
		anotherEvent := BrMenuWhoToPinToEvent new.
		aWidget fireEvent: anotherEvent.
		anotherEvent anchorElement ifNotNil: [ :anElement |
			anEvent anchorElement: anElement ] ]
]

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> onWidgetAddedToSceneGraph: anEvent [
	self temporarilyShow
]

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> onWidgetExtentChanged: anEvent [ 
	self visible ifTrue: [ self relocate ]
]

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> onWidgetPositionChanged: anEvent [ 
	self visible ifTrue: [ self relocate ]
]

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> onWidgetRemovedFromSceneGraph: anEvent [
	anEvent consumed: true.
	self temporarilyHide
]

{ #category : #private }
BrWithExplicitMenuAptitude >> relocate [
	self widgetDo: [ :aWidget | 
		aWidget isVisibleInSpace 
			ifFalse: [ menuContainer visibility: BlVisibility gone ]
			ifTrue: [ menuContainer visibility: BlVisibility visible ].
		relocator relocateGiven: aWidget ]
]

{ #category : #'api - relocating' }
BrWithExplicitMenuAptitude >> relocator [
	<return: #BrMenuContainerRelocator>
	^ relocator
]

{ #category : #'api - relocating' }
BrWithExplicitMenuAptitude >> relocator: aBrMenuContainerRelocator [
	aBrMenuContainerRelocator menuContainer: menuContainer.
	relocator := aBrMenuContainerRelocator
]

{ #category : #'api - demo' }
BrWithExplicitMenuAptitude >> removeClickOutsideEventHandler [
	"I am used for demo purposes, e.g., creating slides"

	menuContainerParent ifNotNil: [ :aParent | 
		aParent removeEventFilter: clickOutsideEventHandler ]
]

{ #category : #'api - demo' }
BrWithExplicitMenuAptitude >> removePressEscEventHandler [
	"I am used for demo purposes, e.g., creating slides"
	
	menuContainerParent ifNotNil: [ :aParent | 
		aParent removeShortcut: pressEscEventHandler ]
]

{ #category : #'api - demo' }
BrWithExplicitMenuAptitude >> removeSceneEventHandlers [
	"I am used for demo purposes, e.g., creating slides"
	
	self widgetDo: [ :aWidget | 
		aWidget
			removeEventHandler: addedToSceneEventHandler;
			removeEventHandler: removedFromSceneEventHandler ]
]

{ #category : #'api - displaying' }
BrWithExplicitMenuAptitude >> show [
	self showDueTo: nil
]

{ #category : #'api - displaying' }
BrWithExplicitMenuAptitude >> showDueTo: anEventOrNil [
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
BrWithExplicitMenuAptitude >> showIn: aParentElement dueToEvent: anEventOrNil [
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
	
	self fireEvent: (BrMenuIsVisibleEvent new
			menuModel: aMenu;
			menuContainer: menuContainer).
	self onShown.
]

{ #category : #accessing }
BrWithExplicitMenuAptitude >> stencil [
	<return: #BrMenuInitialStencilBuilder or: nil>
	^ menuStencil
]

{ #category : #accessing }
BrWithExplicitMenuAptitude >> stencil: aStencilBuilder [
	"Set a stencil that creates a menu model.
	The stencil builder can be a block with one argument: [ :aBrMenuInitialContext | ].
	The stencil builder returns a BrMenu instance or nil."

	menuStencil := aStencilBuilder asStencilBuilder: BrMenuInitialStencilBuilder
]

{ #category : #accessing }
BrWithExplicitMenuAptitude >> submenus [
	"Return menu container elements that were opened from this context menu"

	<return: #IdentitySet of: #BrMenuSteppedElement>
	^ submenus ifNil: [ submenus := IdentitySet new: 1 ]
]

{ #category : #private }
BrWithExplicitMenuAptitude >> temporarilyHide [
	"Temporarily hide without destroying menu content"

	menuContainer removeFromParent.
	menuContainerParent ifNotNil: [ :aParent | 
		menuContainerParent := nil.
		aParent removeEventFilter: clickOutsideEventHandler.
		aParent removeShortcut: pressEscEventHandler. ].
		
	NonInteractiveTranscript stdout show: #temporaryHide:; cr.
]

{ #category : #private }
BrWithExplicitMenuAptitude >> temporarilyShow [
	"Re-add temporarily hiden menu container without reconstructing its menu content"

	self widgetDo: [ :aWidget | 
		| aParent |
		aParent := aWidget topMostParent.
		self temporarilyShowIn: aParent ]
]

{ #category : #private }
BrWithExplicitMenuAptitude >> temporarilyShowIn: aParentElement [
	menuContainerParent := aParentElement.
	aParentElement addEventFilter: clickOutsideEventHandler.
	aParentElement addShortcut: pressEscEventHandler.
	
	menuContainer parent == aParentElement ifFalse: [
		menuContainer removeFromParent.
		aParentElement addChild: menuContainer ].
	self relocate.
	
	NonInteractiveTranscript stdout show: #temporarilyShowIn:; cr.
]

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> useSecondaryMouseButton [
	self withSecondaryMouseButton
]

{ #category : #testing }
BrWithExplicitMenuAptitude >> visible [
	<return: #Boolean>
	^ menuContainer isAttachedToSceneGraph
]

{ #category : #'api - displaying' }
BrWithExplicitMenuAptitude >> visible: aBoolean [
	aBoolean ifTrue: [ self show ] ifFalse: [ self hide ]
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> withAllExtraEventHandlers [
	"Let's initialize menu container with other event handlers, e.g., spawn."
	| allPragmas |
	allPragmas := Pragma 
		allNamed: #menuContainerInitialization 
		from: self class 
		to: BrWithExplicitMenuAptitude.
	allPragmas do: [ :eachPragma |
		self perform: eachPragma methodSelector ]
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> withCenteredHandle [
	menuContainer withCenteredHandle
]

{ #category : #'api - relocating' }
BrWithExplicitMenuAptitude >> withClickPositionRelocator [
	self relocator: BrMenuClickPositionRelocator new
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> withContainerAreaBuilders: aCollectionOfAreaBuilders [
	menuContainer layout areaBuilders: aCollectionOfAreaBuilders
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> withContainerContextMenuAreas [
	menuContainer withContextMenuAreas
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> withContainerDownUpDropdown [
	"Place dropdowns only down or up"

	menuContainer withDownUpDropdownAreas
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> withContainerDropdown [
	menuContainer withDropdownAreas
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> withContainerTooltipAreas [
	menuContainer withTooltipAreas
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> withDefaultHandle [
	self withCenteredHandle
]

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> withHandleSubmenu: aMenuBlock [
	self
		deprecated: 'Use handleSubmenu: instead'
		transformWith: '`@receiver withHandleSubmenu: `@argument'
			-> '`@receiver handleSubmenu: `@argument'.
	self handleSubmenu: aMenuBlock
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> withKeepAllCacheCleaner [
	self cacheCleaner: BrMenuCacheCleaner allKeeper
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> withMouseUpEventHandler [
	"Show menu on click events."

	self mouseEventHandler: self newMouseUpEventHandler
]

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> withPrimaryMouseButton [
	mouseButton := BlMouseButton primary
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> withRemoveAllCacheCleaner [
	self cacheCleaner: BrMenuCacheCleaner allCleaner
]

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> withSecondaryMouseButton [
	mouseButton := BlMouseButton secondary
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> withSuboptimalAreaFinder: anAreaFinder [
	"Set area finder that is used when there is not an available area 
	with enough space for a given child node.
	See {{gtMethod:BlSteppedLayoutState>>#placeMeasuredChild:}} for more details."
	
	menuContainer suboptimalAreaFinder: anAreaFinder
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> withTooltipEventHandler [
	"Show menu on mouse enter events."

	self mouseEventHandler: self newTooltipEventHandler
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> withTooltipHandle [
	menuContainer withTooltipHandle
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> withTopLeftHandle [
	menuContainer withTopLeftHandle
]

{ #category : #'api - relocating' }
BrWithExplicitMenuAptitude >> withWidgetBoundsRelocator [
	self relocator: BrMenuWidgetBoundsRelocator new
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> withoutHandle [
	menuContainer withoutHandle
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> withoutMouseEventHandler [
	"Do not show menu on click"

	mouseEventHandler ifNil: [ ^ self ].
	self removeEventHandler: mouseEventHandler.
	mouseEventHandler := nil
]
