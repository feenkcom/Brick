Class {
	#name : #BrWithExplicitDropdownAptitude,
	#superclass : #BrWithExplicitPopoverAptitude,
	#instVars : [
		'shouldHideWidget'
	],
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #'instance creation' }
BrWithExplicitDropdownAptitude class >> handle: aHandleStencil content: aContentStencil containerDo: aContainerBlock [
	"Create a menu with a handle element and with an explicit menu element.
	aHandleStencil is a stencil that creates a BlElement instance.
	aContentStencil is a stencil that creates a BlElement instance."

	^ self new
		handle: aHandleStencil content: aContentStencil;
		menuContainerDo: aContainerBlock
]

{ #category : #'instance creation' }
BrWithExplicitDropdownAptitude class >> handle: aHandleStencil content: aContentStencil do: anAptitudeBlock [
	"Create a menu with a handle element and with an explicit menu element.
	aHandleStencil is a stencil that creates a BlElement instance.
	aContentStencil is a stencil that creates a BlElement instance.
	anAptitudeBlock is a block that receives the aptitude instance."

	^ self new 
		handle: aHandleStencil content: aContentStencil;
		in: [ :anAptitude | anAptitudeBlock value: anAptitude ];
		yourself
]

{ #category : #'instance creation' }
BrWithExplicitDropdownAptitude class >> handle: aHandleStencil menu: aMenuStencil [
	"Create a menu with a handle element and with an explicit menu element.
	aHandleStencil is a stencil that creates a BlElement instance.
	aMenuBlock is a stencil that creates a BrMenu instance."

	^ self handle: aHandleStencil menu: aMenuStencil do: [ :anAptitude | ]
]

{ #category : #'instance creation' }
BrWithExplicitDropdownAptitude class >> handle: aHandleStencil menu: aMenuStencil do: anAptitudeBlock [
	"Create a menu with a handle element and with an explicit menu element.
	aHandleStencil is a stencil that creates a BlElement instance.
	aMenuBlock is a stencil that creates a BrMenu instance.
	anAptitudeBlock is a block that receives the aptitude instance."

	^ self new 
		handle: aHandleStencil submenu: aMenuStencil;
		in: [ :anAptitude | anAptitudeBlock value: anAptitude ];
		yourself
]

{ #category : #'api - displaying' }
BrWithExplicitDropdownAptitude >> doNotHideWidget [
	self shouldHideWidget: false
]

{ #category : #initialization }
BrWithExplicitDropdownAptitude >> initialize [
	super initialize.
	self beDropdown.
	self withAllExtraEventHandlers.
	
	"when true, the widget under the dropdown will be hidden"
	shouldHideWidget := true.
]

{ #category : #initialization }
BrWithExplicitDropdownAptitude >> initializeListeners [
	super initializeListeners.
	self when: BrDropdownShowWish do: [ :anEvent | self onShowWish: anEvent ].
	self when: BrDropdownHideWish do: [ :anEvent | self onHideWish: anEvent ]
]

{ #category : #initialization }
BrWithExplicitDropdownAptitude >> initializeMenuContainer [
	super initializeMenuContainer.
	menuContainer when: BrDropdownShowWish do: [ :anEvent | self onShowWish: anEvent ].
	menuContainer when: BrDropdownHideWish do: [ :anEvent | self onHideWish: anEvent ]
]

{ #category : #'private - event management' }
BrWithExplicitDropdownAptitude >> onHidden [
	super onHidden.
	
	true ifFalse: [
		"It requires more changes. Currently, it breaks the menu behavior."
		self shouldHideWidget
			ifTrue: [ self widgetDo: [ :aWidget | aWidget visibility: BlVisibility visible ] ] ].
	
	self dispatchEvent: BrDropdownIsHidden new
]

{ #category : #'private - event management' }
BrWithExplicitDropdownAptitude >> onShown [
	super onShown.
	
	true ifFalse: [
		"It requires more changes. Currently, it breaks the menu behavior."
		self shouldHideWidget
			ifTrue: [ self widgetDo: [ :aWidget | aWidget visibility: BlVisibility hidden ] ] ].
	
	self dispatchEvent: BrDropdownIsVisible new.
]

{ #category : #'api - displaying' }
BrWithExplicitDropdownAptitude >> shouldHideWidget [
	^ shouldHideWidget ifNil: [ true ]
]

{ #category : #'api - displaying' }
BrWithExplicitDropdownAptitude >> shouldHideWidget: aBoolean [
	shouldHideWidget := aBoolean
]

{ #category : #'api - initialization' }
BrWithExplicitDropdownAptitude >> withDefaultHandle [
	self withTopLeftHandle
]
