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
		'addedToSceneEventHandler'
	],
	#category : #'Brick-Menu - Aptitude'
}

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
	"Hide when clicked outside of container" 
	anEvent target == menuContainer ifTrue: [ ^ self ].
	(anEvent target hasParent: menuContainer) ifTrue: [ ^ self ].
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
		aMenu hide.
		menuContainer childrenCount isZero ifFalse: [
			"Only pinned children remains. 
			We therefore keep the menu container."
			^ self ] ].
	
	self
		widgetDo: [ :aWidget | 
			| aContainerParent |
			aWidget
				removeEventHandler: extentChangedEventHandler;
				removeEventHandler: positionInSpaceChangedEventHandler;
				removeEventHandler: addedToSceneEventHandler;
				removeEventHandler: removedFromSceneEventHandler.
			aContainerParent := menuContainer parent.
			aContainerParent removeEventFilter: clickOutsideEventHandler.
			aContainerParent removeShortcut: pressEscEventHandler.
			menuContainer removeFromParent. ]
]

{ #category : #initialization }
BrWithExplicitMenuAptitude >> initialize [
	super initialize.
	mouseButton := BlMouseButton secondary.
	modifiersMatcher := [ :aBlKeyModifiers | true ].

	menuContainer := BrMenuSteppedElement new.
	
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
		do: [ :anEvent |  self onMouseUp: anEvent ]
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
	
	self show
]

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> onWidgetAddedToSceneGraph: anEvent [
	menuContainer visibility: BlVisibility visible
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
	menuContainer visibility: BlVisibility gone
]

{ #category : #private }
BrWithExplicitMenuAptitude >> relocate [
	self widgetDo: [ :aWidget | 
		aWidget isVisibleInSpace 
			ifFalse: [ menuContainer visibility: BlVisibility gone ]
			ifTrue: [ menuContainer visibility: BlVisibility visible ].
		menuContainer parent ifNotNil: [ :aParent |
			menuContainer layoutDo: [ :aLayout | 
				aLayout anchorBounds: (aWidget bounds 
					inParent: aParent) asRectangle ] ] ]
]

{ #category : #'api - displaying' }
BrWithExplicitMenuAptitude >> show [
	self canShow ifFalse: [ ^ self ].
	
	self widgetDo: [ :aWidget | 
		| aParent |
		aParent := aWidget space root.
		self showIn: aParent ]
]

{ #category : #private }
BrWithExplicitMenuAptitude >> showIn: anElement [
	stencil ifNil: [ ^ self ].
	self hide.
	menuContainer menuModel: stencil create.
	menuContainer show.
	anElement addEventFilter: clickOutsideEventHandler.
	anElement addShortcut: pressEscEventHandler.

	self widgetDo: [ :aWidget |
		aWidget 
			addEventHandler: extentChangedEventHandler;
			addEventHandler: positionInSpaceChangedEventHandler;
			addEventHandler: addedToSceneEventHandler;
			addEventHandler: removedFromSceneEventHandler ].
	
	menuContainer parent == anElement ifFalse: [
		anElement addChild: menuContainer ].
	self relocate
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
