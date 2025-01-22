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
		'menuStencil'
	],
	#category : #'Brick-Menu - Aptitude'
}

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

{ #category : #testing }
BrWithExplicitMenuAptitude >> canHide [
	^ self visible
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

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> handle: aHandleBlock submenu: aMenuBlock [
	self withDefaultHandle.
	self stencil: (BrMenuExplicitHandle new
		handle: aHandleBlock;
		submenu: aMenuBlock)
]

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> handleSubmenu: aMenuBlock [
	self withDefaultHandle.
	self stencil: (BrMenuExplicitHandle new submenu: aMenuBlock)
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

{ #category : #'api - displaying' }
BrWithExplicitMenuAptitude >> hide [
	self canHide ifFalse: [ ^ self ].
	menuContainer menuModel ifNotNil: [ :aMenu | 
		aMenu hide ].
	
	"Widgets enqueue their hide actions, therefore
	let's check remaining menu widgets in the next pulse."
	self widgetDo: [ :aWidget | 
		BlTaskAction
			enqueueElement: aWidget
			action: [
				menuContainer childrenCount isZero ifTrue: [
					aWidget
						removeEventHandler: extentChangedEventHandler;
						removeEventHandler: positionInSpaceChangedEventHandler;
						removeEventHandler: addedToSceneEventHandler;
						removeEventHandler: removedFromSceneEventHandler.
					self temporaryHide ] ] ]
]

{ #category : #initialization }
BrWithExplicitMenuAptitude >> initialize [
	super initialize.
	mouseButton := BlMouseButton secondary.
	modifiersMatcher := [ :aBlKeyModifiers | true ].
	
	self initializeMenuContainer.
	self initializeEventHandlers.
	
	self addChange: (BrLookChange new
				up: [ :e |  ];
				down: [ :e | self hide ];
				yourself)
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
			do: [ :anEvent | 
				self onClickedOutsideMouseUpEvent: anEvent ].
				
	pressEscEventHandler := BlShortcutWithAction new
			combination: BlKeyCombination escape;
			action: [ :anEvent | self hide ].
]

{ #category : #initialization }
BrWithExplicitMenuAptitude >> initializeListeners [
	super initializeListeners.

	self
		when: BlMouseUpEvent
		do: [ :anEvent |  self onMouseUp: anEvent ].
		
	self 
		when: BrDropdownShowWish
		do: [ :anEvent | self showDueTo: nil ].
	self 
		when: BrDropdownHideWish
		do: [ :anEvent | self hide ].
	self 
		when: BrContextMenuShowWish
		do: [ :anEvent | self showDueTo: nil ].
	self 
		when: BrContextMenuHideWish
		do: [ :anEvent | self hide ].
]

{ #category : #initialization }
BrWithExplicitMenuAptitude >> initializeMenuContainer [
	menuContainer := BrMenuSteppedElement new.
	menuContainer addAptitude: BrMenuContainerAptitude new.
	menuContainerParent := nil.
	relocator := BrMenuClickPositionRelocator new
		menuContainer: menuContainer.
	menuContainer
		when: BrMenuWhoToPinToEvent
		do: [ :anEvent | self onWhoToPinToEvent: anEvent ].
	menuContainer 
		when: BrMenuAnchorElementRequest 
		do: [ :anEvent | self onAnchorElementRequest: anEvent ]
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
	aBlock value: menuContainer
]

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> modifiersMatcher: aBlockOrSymbol [
	"Customize the modifiers matcher in a form of [ :aBlKeyModifiers | true ] that is used
	to test whether the context menu should be opened"

	modifiersMatcher := aBlockOrSymbol
]

{ #category : #initialization }
BrWithExplicitMenuAptitude >> onAnchorElementRequest: anEvent [ 
	anEvent consumed: true.
	self widgetDo: [ :aWidget | 
		anEvent sourceElement: aWidget ]
]

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> onClickedOutsideMouseUpEvent: anEvent [
	"Hide when clicked outside of the container" 
	anEvent target == menuContainer ifTrue: [ ^ self ].
	(menuContainer isUnpinnedChild: anEvent target)
		ifTrue: [ ^ self ].
	self hide.
]

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> onMouseUp: anEvent [
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
	self temporaryShow
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
	self temporaryHide
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
BrWithExplicitMenuAptitude >> showIn: anElement dueToEvent: anEventOrNil [
	"The event parameter must be one with a position, `nil` otherwise."

	| aMenu |
	menuStencil ifNil: [ ^ self ].
	self hide.
	
	self widgetDo: [ :aWidget |
		aMenu := menuStencil 
			context: (BrMenuInitialContext new
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
	
	self temporaryShowIn: anElement
]

{ #category : #accessing }
BrWithExplicitMenuAptitude >> stencil [
	<return: #BrMenuInitialStencilBuilder or: nil>
	^ menuStencil
]

{ #category : #accessing }
BrWithExplicitMenuAptitude >> stencil: aStencilBuilder [
	"Set a stencil that creates a menu model"

	menuStencil := aStencilBuilder asStencilBuilder: BrMenuInitialStencilBuilder
]

{ #category : #private }
BrWithExplicitMenuAptitude >> temporaryHide [
	"Temporary hide without destroying menu content"

	menuContainer removeFromParent.
	menuContainerParent ifNotNil: [ :aParent | 
		menuContainerParent := nil.
		aParent removeEventFilter: clickOutsideEventHandler.
		aParent removeShortcut: pressEscEventHandler. ]
]

{ #category : #private }
BrWithExplicitMenuAptitude >> temporaryShow [
	"Re-add temporary hiden menu container without reconstructing its menu content"

	self widgetDo: [ :aWidget | 
		| aParent |
		aParent := aWidget topMostParent.
		self temporaryShowIn: aParent ]
]

{ #category : #private }
BrWithExplicitMenuAptitude >> temporaryShowIn: anElement [
	menuContainerParent := anElement.
	anElement addEventFilter: clickOutsideEventHandler.
	anElement addShortcut: pressEscEventHandler.
	
	menuContainer parent == anElement ifFalse: [
		menuContainer removeFromParent.
		anElement addChild: menuContainer ].
	self relocate
]

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> usePrimaryMouseButton [
	mouseButton := BlMouseButton primary
]

{ #category : #testing }
BrWithExplicitMenuAptitude >> visible [
	<return: #Boolean>
	^ menuContainer isAttachedToSceneGraph
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
BrWithExplicitMenuAptitude >> withContainerContextMenuAreas [
	menuContainer withContextMenuAreas
]

{ #category : #'api - initialization' }
BrWithExplicitMenuAptitude >> withContainerDropdown [
	menuContainer withDropdownAreas
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

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> withPrimaryMouseButton [
	mouseButton := BlMouseButton primary
]

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> withSecondaryMouseButton [
	mouseButton := BlMouseButton secondary
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
