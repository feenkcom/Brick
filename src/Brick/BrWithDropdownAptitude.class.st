Class {
	#name : #BrWithDropdownAptitude,
	#superclass : #BrWithAnchoredAptitude,
	#instVars : [
		'hideWishHandler',
		'clickShowCondition',
		'shouldHideWidget',
		'isResizable',
		'whenResizedHandler',
		'resizerAptitudes',
		'isKeepRatio'
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
		stencil: [ :aDecorator | BrAnchoredElement new
				aptitude: (self anchoredAptitude
						content: (aDecorator value: anObject asStencil asElement);
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
		stencil: [ :aDecorator | | anAnchoredAptitude |
			anAnchoredAptitude := self anchoredAptitude
					handle: anObject asStencil asElement;
					content: (aDecorator value: anotherObject asStencil asElement);
					yourself.
			aBlock value: anAnchoredAptitude.
			BrAnchoredElement new
				aptitude: anAnchoredAptitude;
				yourself ]
]

{ #category : #'api - displaying' }
BrWithDropdownAptitude >> attachToCenter [
	strategy := BrAnchoredCompositeStrategy builder
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredCenterReferencePoint;
				availableBounds: BrAnchoredBottomRightAvailableBounds;
				apply: [ self removeInnerContainerDropdownAptitudes. 
					innerContainer addAptitude: BrDropdownBottomRightAptitude ] ];
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredCenterReferencePoint;
				availableBounds: BrAnchoredBottomLeftAvailableBounds;
				apply: [ self removeInnerContainerDropdownAptitudes. 
					innerContainer addAptitude: BrDropdownBottomLeftAptitude ] ];
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredCenterReferencePoint;
				availableBounds: BrAnchoredTopRightAvailableBounds;
				apply: [ self removeInnerContainerDropdownAptitudes. 
					innerContainer addAptitude: BrDropdownTopLeftAptitude ] ];
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredCenterReferencePoint;
				availableBounds: BrAnchoredTopLeftAvailableBounds;
				apply: [ self removeInnerContainerDropdownAptitudes. 
					innerContainer addAptitude: BrDropdownTopRightAptitude ] ];
		build.
]

{ #category : #accessing }
BrWithDropdownAptitude >> beNotResizable [
	isResizable := false
]

{ #category : #accessing }
BrWithDropdownAptitude >> beResizable [
	isResizable := true
]

{ #category : #private }
BrWithDropdownAptitude >> createResizeAptitudeWith: anAptitude [
	whenResizedHandler ifNotNil: [ anAptitude whenResizedDo: whenResizedHandler ].
	anAptitude keepRatio: self isKeepRatio.
	^ anAptitude
]

{ #category : #private }
BrWithDropdownAptitude >> createResizerOn: anElement [
	self isResizable ifFalse: [ ^ anElement ].

	self resizerAptitudes isAttachedToWidget
		ifTrue: [ self resizerAptitudes widget removeAptitude: self resizerAptitudes ].

	^ anElement addAptitude: self resizerAptitudes
]

{ #category : #accessing }
BrWithDropdownAptitude >> doKeepRatio [
	"Keep dropdown extent ratio while resizing"

	isKeepRatio := true.
	self updateResizerAptitudesKeepRatio
]

{ #category : #'api - displaying' }
BrWithDropdownAptitude >> doNotHideWidget [
	self shouldHideWidget: false
]

{ #category : #accessing }
BrWithDropdownAptitude >> doNotKeepRatio [
	"Do not keep dropdown extent ratio while resizing"

	isKeepRatio := false
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

	isResizable := true.
	isKeepRatio := false.
	self resizersOnBottomLeft.

	hideWishHandler := BlEventHandler
			on: BrDropdownHideWish
			do: [ :aWish | self onHideWish: aWish ].

	clickShowCondition := [ :aClickEvent | (self hasModifiers: aClickEvent) not ].	"when true, the widget under the dropdown will be hidden"
	shouldHideWidget := true.

	preferredExtent := 200 @ 300.
	strategy := BrAnchoredCompositeStrategy builder
			single: [ :e | 
				e
					anchorBounds: [ :f | widget bounds inParent: f ];
					referencePoint: BrAnchoredTopLeftReferencePoint;
					availableBounds: BrAnchoredBottomRightAvailableBounds;
					apply: [ self removeInnerContainerDropdownAptitudes.
						innerContainer addAptitude: BrDropdownBottomRightAptitude.
						self resizersOnBottomRight ] ];
			single: [ :e | 
				e
					anchorBounds: [ :f | widget bounds inParent: f ];
					referencePoint: BrAnchoredTopRightReferencePoint;
					availableBounds: BrAnchoredBottomLeftAvailableBounds;
					apply: [ self removeInnerContainerDropdownAptitudes.
						innerContainer addAptitude: BrDropdownBottomLeftAptitude.
						self resizersOnBottomLeft ] ];
			single: [ :e | 
				e
					anchorBounds: [ :f | widget bounds inParent: f ];
					referencePoint: BrAnchoredBottomLeftReferencePoint;
					availableBounds: BrAnchoredTopRightAvailableBounds;
					apply: [ self removeInnerContainerDropdownAptitudes.
						innerContainer addAptitude: BrDropdownTopLeftAptitude.
						self resizersOnTopRight ] ];
			single: [ :e | 
				e
					anchorBounds: [ :f | widget bounds inParent: f ];
					referencePoint: BrAnchoredBottomRightReferencePoint;
					availableBounds: BrAnchoredTopLeftAvailableBounds;
					apply: [ self removeInnerContainerDropdownAptitudes.
						innerContainer addAptitude: BrDropdownTopRightAptitude.
						self resizersOnTopLeft ] ];
			build
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

{ #category : #testing }
BrWithDropdownAptitude >> isKeepRatio [
	^ isKeepRatio ifNil: [ false ]
]

{ #category : #accessing }
BrWithDropdownAptitude >> isResizable [
	^ isResizable
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

{ #category : #private }
BrWithDropdownAptitude >> removeInnerContainerDropdownAptitudes [
	innerContainer
		aptitudeDo: [ :anAptitude | 
			anAptitude 
				- BrDropdownBottomLeftAptitude 
				- BrDropdownBottomRightAptitude
				- BrDropdownTopLeftAptitude 
				- BrDropdownTopRightAptitude 
				- BrDropdownCenterLeftAptitude]
]

{ #category : #accessing }
BrWithDropdownAptitude >> resizerAptitudes [
	^ resizerAptitudes
]

{ #category : #accessing }
BrWithDropdownAptitude >> resizerAptitudes: anObject [
	(resizerAptitudes isNotNil and: [ resizerAptitudes isAttachedToWidget ])
		ifTrue: [ | aWidget |
			aWidget := resizerAptitudes widget.
			aWidget removeAptitude: resizerAptitudes.
			aWidget addAptitude: anObject ].
	resizerAptitudes := anObject
]

{ #category : #accessing }
BrWithDropdownAptitude >> resizersOnBottom [
	self
		resizerAptitudes: (self
				createResizeAptitudeWith: BrGlamorousWithHorizontalResizerAptitude new beRight)
				+ (self
						createResizeAptitudeWith: BrGlamorousWithHorizontalResizerAptitude new beLeft)
				+ (self createResizeAptitudeWith: BrGlamorousWithVerticalResizerAptitude new)
]

{ #category : #accessing }
BrWithDropdownAptitude >> resizersOnBottomLeft [
	self
		resizerAptitudes: (self
				createResizeAptitudeWith: BrGlamorousWithHorizontalResizerAptitude new beLeft)
				+ (self createResizeAptitudeWith: BrGlamorousWithVerticalResizerAptitude new)
]

{ #category : #accessing }
BrWithDropdownAptitude >> resizersOnBottomRight [
	self
		resizerAptitudes: (self
				createResizeAptitudeWith: BrGlamorousWithHorizontalResizerAptitude new beRight)
				+ (self createResizeAptitudeWith: BrGlamorousWithVerticalResizerAptitude new)
]

{ #category : #accessing }
BrWithDropdownAptitude >> resizersOnTop [
	self
		resizerAptitudes: (self
				createResizeAptitudeWith: BrGlamorousWithHorizontalResizerAptitude new beRight)
				+ (self
						createResizeAptitudeWith: BrGlamorousWithHorizontalResizerAptitude new beLeft)
				+ (self createResizeAptitudeWith: BrGlamorousWithVerticalResizerAptitude new beTop)
]

{ #category : #accessing }
BrWithDropdownAptitude >> resizersOnTopLeft [
	self
		resizerAptitudes: (self
				createResizeAptitudeWith: BrGlamorousWithHorizontalResizerAptitude new beLeft)
				+ (self createResizeAptitudeWith: BrGlamorousWithVerticalResizerAptitude new beTop)
]

{ #category : #accessing }
BrWithDropdownAptitude >> resizersOnTopRight [
	self
		resizerAptitudes: (self
				createResizeAptitudeWith: BrGlamorousWithHorizontalResizerAptitude new beRight)
				+ (self createResizeAptitudeWith: BrGlamorousWithVerticalResizerAptitude new beTop)
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

{ #category : #'api - displaying' }
BrWithDropdownAptitude >> stencil: aValuable [
	stencil := BrDropdownContentStencil new
			contentStencil: aValuable;
			decorator: [ :anElement | self createResizerOn: anElement ]
]

{ #category : #private }
BrWithDropdownAptitude >> updateResizerAptitudesKeepRatio [
	resizerAptitudes ifNil: [ ^ self ].
	resizerAptitudes withAllActorsDepthFirstDo: [ :anAptitude |
		anAptitude keepRatio: self isKeepRatio ]
]

{ #category : #accessing }
BrWithDropdownAptitude >> whenResizedDo: aBlock [
	whenResizedHandler := aBlock
]
