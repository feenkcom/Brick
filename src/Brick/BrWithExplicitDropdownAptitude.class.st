Class {
	#name : #BrWithExplicitDropdownAptitude,
	#superclass : #BrWithExplicitMenuAptitude,
	#instVars : [
		'shouldHideWidget'
	],
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #'instance creation' }
BrWithExplicitDropdownAptitude class >> handle: aHandleStencil content: aContentStencil [
	"Create a menu with a handle element and with an explicit menu element.
	aHandleStencil is a stencil that creates a BlElement instance.
	aContentStencil is a stencil that creates a BlElement instance."

	^ self new handle: aHandleStencil content: aContentStencil
]

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
	
	self shouldHideWidget
		ifTrue: [ self widgetDo: [ :aWidget | aWidget visibility: BlVisibility visible ] ].
	
	self dispatchEvent: BrDropdownIsHidden new
]

{ #category : #'private - event management' }
BrWithExplicitDropdownAptitude >> onShown [
	super onShown.
	
	self shouldHideWidget
		ifTrue: [ self widgetDo: [ :aWidget | aWidget visibility: BlVisibility hidden ] ].
	
	self dispatchEvent: BrDropdownIsVisible new.
]

{ #category : #'api - displaying' }
BrWithExplicitDropdownAptitude >> shouldHideWidget [
	^ shouldHideWidget ifNil: [ true ]
]

{ #category : #'api - displaying' }
BrWithExplicitDropdownAptitude >> shouldHideWidget: anObject [
	shouldHideWidget := anObject
]

{ #category : #'api - initialization' }
BrWithExplicitDropdownAptitude >> withDefaultHandle [
	self withTopLeftHandle
]
