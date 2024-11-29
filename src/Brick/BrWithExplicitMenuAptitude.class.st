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
		'clickOutsideEventHandler'
	],
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #testing }
BrWithExplicitMenuAptitude >> canHide [
	^ self visible
]

{ #category : #testing }
BrWithExplicitMenuAptitude >> canShow [
	self visible ifTrue: [ ^ false ].
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

	self
		widgetDo: [ :aWidget | 
			| aParent |
			aWidget
				removeEventHandler: extentChangedEventHandler;
				removeEventHandler: positionInSpaceChangedEventHandler.
			aParent := menuContainer parent.
			aParent removeEventHandler: clickOutsideEventHandler.
			menuContainer removeFromParent ]
]

{ #category : #initialization }
BrWithExplicitMenuAptitude >> initialize [
	super initialize.
	mouseButton := BlMouseButton secondary.
	modifiersMatcher := [ :aBlKeyModifiers | true ].

	menuContainer := BrMenuSteppedElement new.
	
	self initializeEventHandlers.
]

{ #category : #initialization }
BrWithExplicitMenuAptitude >> initializeEventHandlers [
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
BrWithExplicitMenuAptitude >> onWidgetExtentChanged: anEvent [ 
	self visible ifTrue: [ self relocate ]
]

{ #category : #'event handling' }
BrWithExplicitMenuAptitude >> onWidgetPositionChanged: anEvent [ 
	self visible ifTrue: [ self relocate ]
]

{ #category : #private }
BrWithExplicitMenuAptitude >> relocate [
	menuContainer isAttachedToSceneGraph ifFalse: [ ^ self ].
	self widgetDo: [ :aWidget | 
		menuContainer layoutDo: [ :aLayout | 
			aLayout anchorBounds: (aWidget bounds 
				inParent: menuContainer parent) asRectangle ] ]
]

{ #category : #'api - displaying' }
BrWithExplicitMenuAptitude >> show [
	self canShow ifFalse: [ ^ self ].
	
	self widgetDo: [ :aWidget | 
		| aParent |
		aParent := aWidget space topMostParent.
		self showIn: aParent ]
]

{ #category : #private }
BrWithExplicitMenuAptitude >> showIn: anElement [
	stencil ifNil: [ ^ self ].
	self hide.
	menuContainer menuModel: stencil create.
	anElement addEventFilter: clickOutsideEventHandler.
	anElement addChild: menuContainer.
	
	self widgetDo: [ :aWidget |
		aWidget 
			addEventHandler: extentChangedEventHandler;
			addEventHandler: positionInSpaceChangedEventHandler ].
	
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
