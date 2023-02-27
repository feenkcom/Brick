Class {
	#name : #BrWithDropdownAptitude,
	#superclass : #BrWithAnchoredAptitude,
	#instVars : [
		'hideWishHandler',
		'clickShowCondition',
		'shouldHideWidget'
	],
	#category : #'Brick-Dropdown - Look'
}

{ #category : #accessing }
BrWithDropdownAptitude class >> anchoredAptitude [
	^ self anchoredAptitudeClass new
]

{ #category : #accessing }
BrWithDropdownAptitude class >> anchoredAptitudeClass [
	^ BrDropdownAptitude
]

{ #category : #accessing }
BrWithDropdownAptitude class >> content: anObject [
	^ self
		stencil: [ BrAnchoredElement new
				aptitude: (self anchoredAptitude
						content: (self withResizingContainer: anObject asStencil asElement);
						yourself);
				yourself ]
]

{ #category : #'instance creation' }
BrWithDropdownAptitude class >> handle: anObject content: anotherObject [
	^ self
		handle: anObject
		content: anotherObject
		aptitudeDo: [ :anAnchoredLook | ]
]

{ #category : #'instance creation' }
BrWithDropdownAptitude class >> handle: anObject content: anotherObject aptitudeDo: aBlock [
	^ self
		stencil: [ | anAnchoredLook |
			anAnchoredLook := self anchoredAptitude
					handle: anObject asStencil asElement;
					content: (self withResizingContainer: anotherObject asStencil asElement);
					yourself.
			aBlock value: anAnchoredLook.
			BrAnchoredElement new
				aptitude: anAnchoredLook;
				yourself ]
]

{ #category : #'instance creation' }
BrWithDropdownAptitude class >> withResizingContainer: anElement [
	^ BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		addChild: anElement;
		addAptitude: BrGlamorousWithHorizontalResizerAptitude new
				+ BrGlamorousWithHorizontalResizerAptitude new beLeft
				+ BrGlamorousWithVerticalResizerAptitude new
]

{ #category : #'api - displaying' }
BrWithDropdownAptitude >> attachToCenter [
	strategy := BrAnchoredCompositeStrategy builder
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredCenterReferencePoint;
				availableBounds: BrAnchoredBottomRightAvailableBounds;
				apply: [ innerContainer
						removeAptitude: BrDropdownBottomLeftAptitude;
						removeAptitude: BrDropdownTopLeftAptitude;
						removeAptitude: BrDropdownTopRightAptitude;
						addAptitude: BrDropdownBottomRightAptitude ] ];
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredCenterReferencePoint;
				availableBounds: BrAnchoredBottomLeftAvailableBounds;
				apply: [ innerContainer
						removeAptitude: BrDropdownBottomRightAptitude;
						removeAptitude: BrDropdownTopLeftAptitude;
						removeAptitude: BrDropdownTopRightAptitude;
						addAptitude: BrDropdownBottomLeftAptitude ] ];
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredCenterReferencePoint;
				availableBounds: BrAnchoredTopRightAvailableBounds;
				apply: [ innerContainer
						removeAptitude: BrDropdownBottomRightAptitude;
						removeAptitude: BrDropdownBottomLeftAptitude;
						removeAptitude: BrDropdownTopRightAptitude;
						addAptitude: BrDropdownTopLeftAptitude ] ];
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredCenterReferencePoint;
				availableBounds: BrAnchoredTopLeftAvailableBounds;
				apply: [ innerContainer
						removeAptitude: BrDropdownBottomRightAptitude;
						removeAptitude: BrDropdownBottomLeftAptitude;
						removeAptitude: BrDropdownTopLeftAptitude;
						addAptitude: BrDropdownTopRightAptitude ] ];
		build.
]

{ #category : #'api - displaying' }
BrWithDropdownAptitude >> doNotHideWidget [
	self shouldHideWidget: false
]

{ #category : #'api - displaying' }
BrWithDropdownAptitude >> doNotShowOnClick [
	clickShowCondition := [ :anEvent | false ]
]

{ #category : #accessing }
BrWithDropdownAptitude >> handleMouseUpEvent: anEvent [
	
	innerContainer ifNil: [ ^ self ].

	"this checks whether this dropdown has nested dropdowns. if we do, we will not close the parent, since we might be in the child dropdown.
	
	problematic usecase: if you click outside all dropdowns, not all of them might be closed due to order of handling the click.
	"
	innerContainer withAllChildrenBreadthFirstDo: [ :eachChild | 
		(eachChild aptitude notNil and: [eachChild aptitude hasActorOfKind: BrWithDropdownAptitude]) ifTrue: [ 
			eachChild aptitude withAllChildren
				detect: [ :each | each isKindOf: BrWithDropdownAptitude ]
				ifFound: [ :aDropdownAptitude | 
					aDropdownAptitude visible ifTrue: [ ^ self ] ] ] ].
					
	super handleMouseUpEvent: anEvent
]

{ #category : #'api - displaying' }
BrWithDropdownAptitude >> hide [
	super hide.

	self shouldHideWidget
		ifTrue: [ self widgetDo: [ :aWidget | aWidget visibility: BlVisibility visible ] ]
]

{ #category : #initialization }
BrWithDropdownAptitude >> initialize [
	super initialize.
	
	hideWishHandler := BlEventHandler
		on: BrDropdownHideWish
		do: [ :aWish | self onHideWish: aWish ].

	clickShowCondition := [ :aClickEvent | (self hasModifiers: aClickEvent) not ].
	
	"when true, the widget under the dropdown will be hidden"
	shouldHideWidget := true.

	preferredExtent := 200 @ 300.
	strategy := BrAnchoredCompositeStrategy builder
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredTopLeftReferencePoint;
				availableBounds: BrAnchoredBottomRightAvailableBounds;
				apply: [ innerContainer
						removeAptitude: BrDropdownBottomLeftAptitude;
						removeAptitude: BrDropdownTopLeftAptitude;
						removeAptitude: BrDropdownTopRightAptitude;
						addAptitude: BrDropdownBottomRightAptitude ] ];
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredTopRightReferencePoint;
				availableBounds: BrAnchoredBottomLeftAvailableBounds;
				apply: [ innerContainer
						removeAptitude: BrDropdownBottomRightAptitude;
						removeAptitude: BrDropdownTopLeftAptitude;
						removeAptitude: BrDropdownTopRightAptitude;
						addAptitude: BrDropdownBottomLeftAptitude ] ];
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredBottomLeftReferencePoint;
				availableBounds: BrAnchoredTopRightAvailableBounds;
				apply: [ innerContainer
						removeAptitude: BrDropdownBottomRightAptitude;
						removeAptitude: BrDropdownBottomLeftAptitude;
						removeAptitude: BrDropdownTopRightAptitude;
						addAptitude: BrDropdownTopLeftAptitude ] ];
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredBottomRightReferencePoint;
				availableBounds: BrAnchoredTopLeftAvailableBounds;
				apply: [ innerContainer
						removeAptitude: BrDropdownBottomRightAptitude;
						removeAptitude: BrDropdownBottomLeftAptitude;
						removeAptitude: BrDropdownTopLeftAptitude;
						addAptitude: BrDropdownTopRightAptitude ] ];
		build.
]

{ #category : #initialization }
BrWithDropdownAptitude >> initializeListeners [
	super initializeListeners.

	self
		when: BrDropdownStencilChanged
		do: [ :anEvent | self stencil: anEvent stencil ].

	self
		when: BrDropdownVisibleChanged
		do: [ :anEvent | self visible: anEvent visible ].

	self
		when: BrDropdownRelocateWish
		do: [ :aWish | self onRelocateWish: aWish ].
		
	self
		when: BrDropdownShowWish
		do: [ :aWish | self onShowWish: aWish ].
		
	self
		when: BrDropdownHideWish
		do: [ :aWish | self onHideWish: aWish ].
	
	self
		when: BlClickEvent
		do: [ :anEvent |
			((self shouldShowDueToClick: anEvent)
				and: [ self isWidgetEnabled ])
					ifTrue: [
						anEvent consumed: true.
						self show ] ]
]

{ #category : #initialization }
BrWithDropdownAptitude >> initializeRequests [
	super initializeRequests.

	self request: BrDropdownStencilRequest new.
	self request: BrDropdownVisibleRequest new
]

{ #category : #'private - testing' }
BrWithDropdownAptitude >> isWidgetEnabled [	
	self widgetDo: [ :aWidget | ^ (aWidget states hasState: BlElementState disabled) not ].
	^ true
]

{ #category : #'private - hooks' }
BrWithDropdownAptitude >> onAnchoredElementCreated: anAnchoredElement [
	anAnchoredElement addEventHandler: hideWishHandler
]

{ #category : #'private - hooks' }
BrWithDropdownAptitude >> onAnchoredElementRemoved: anAnchoredElement [
	anAnchoredElement removeEventHandler: hideWishHandler
]

{ #category : #'api - displaying' }
BrWithDropdownAptitude >> onControlClick [
	clickShowCondition := [ :anEvent | anEvent modifiers isCtrl ]
]

{ #category : #'api - displaying' }
BrWithDropdownAptitude >> onPrimaryClick [
	clickShowCondition := [ :anEvent | anEvent modifiers isPrimaryModifier ]
]

{ #category : #'api - displaying' }
BrWithDropdownAptitude >> shouldHideWidget [
	^ shouldHideWidget
]

{ #category : #'api - displaying' }
BrWithDropdownAptitude >> shouldHideWidget: anObject [
	shouldHideWidget := anObject
]

{ #category : #'private - testing' }
BrWithDropdownAptitude >> shouldShowDueToClick: aClickEvent [
	^ clickShowCondition value: aClickEvent
]

{ #category : #'api - displaying' }
BrWithDropdownAptitude >> show [
	super show.

	self shouldHideWidget
		ifTrue: [ self widgetDo: [ :aWidget | aWidget visibility: BlVisibility hidden ] ]
]
