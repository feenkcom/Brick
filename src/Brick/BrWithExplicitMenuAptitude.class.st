Class {
	#name : #BrWithExplicitMenuAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'stencil',
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
		'relocator'
	],
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #'api - relocating' }
BrWithExplicitMenuAptitude >> beClickPositionRelocator [
	self relocator: BrMenuClickPositionRelocator new
]

{ #category : #'api - relocating' }
BrWithExplicitMenuAptitude >> beWidgetBoundsRelocator [
	self relocator: BrMenuWidgetBoundsRelocator new
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

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> handleClickedOutsideMouseUpEvent: anEvent [
	"Hide when clicked outside of the container" 
	anEvent target == menuContainer ifTrue: [ ^ self ].
	(menuContainer isUnpinnedChild: anEvent target)
		ifTrue: [ ^ self ].
	self hide.
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
				self handleClickedOutsideMouseUpEvent: anEvent ].
				
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
]

{ #category : #initialization }
BrWithExplicitMenuAptitude >> initializeMenuContainer [
	menuContainer := BrMenuSteppedElement new.
	menuContainerParent := nil.
	relocator := BrMenuClickPositionRelocator new
		menuContainer: menuContainer.
	menuContainer
		when: BrMenuWhoToPinToEvent
		do: [ :anEvent | self onWhoToPinToEvent: anEvent ].
	menuContainer 
		when: BrMenuSourceElementRequest 
		do: [ :anEvent | self onSourceElementRequest: anEvent ]
]

{ #category : #accessing }
BrWithExplicitMenuAptitude >> menuContainer [
	<return: #BrMenuSteppedElement>
	^ menuContainer
]

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> modifiersMatcher: aBlockOrSymbol [
	"Customize the modifiers matcher in a form of [ :aBlKeyModifiers | true ] that is used
	to test whether the context menu should be opened"

	modifiersMatcher := aBlockOrSymbol
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
	
	self show
]

{ #category : #initialization }
BrWithExplicitMenuAptitude >> onSourceElementRequest: anEvent [ 
	anEvent consumed: true.
	self widgetDo: [ :aWidget | 
		anEvent sourceElement: aWidget ]
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
	self canShow ifFalse: [ ^ self ].
	
	self widgetDo: [ :aWidget | 
		| aParent |
		aWidget dispatchEvent: BrTooltipHideWish new.
		aParent := aWidget topMostParent.
		self showIn: aParent ]
]

{ #category : #private }
BrWithExplicitMenuAptitude >> showIn: anElement [
	| aMenu |
	stencil ifNil: [ ^ self ].
	self hide.
	aMenu := stencil create.
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
	^ stencil
]

{ #category : #accessing }
BrWithExplicitMenuAptitude >> stencil: aStencil [
	"Set a stencil that creates a menu model"

	stencil := aStencil asStencil
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
		anElement addChild: menuContainer ].
	self relocate
]

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> usePrimaryMouseButton [
	mouseButton := BlMouseButton primary
]

{ #category : #'api - menu' }
BrWithExplicitMenuAptitude >> useSecondaryMouseButton [
	mouseButton := BlMouseButton secondary
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
