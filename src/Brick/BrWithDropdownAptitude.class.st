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
		'isKeepRatio',
		'resizerAptitudeStencil'
	],
	#category : #'Brick-Dropdown - Look'
}

{ #category : #accessing }
BrWithDropdownAptitude class >> anchoredAptitudeClass [
	^ BrDropdownAptitude
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

{ #category : #'api - displaying' }
BrWithDropdownAptitude >> detachResizerAptitudes [
	"Detach aptitudes from widgets since keeping them
	around may produce memory leaks.
	See https://github.com/feenkcom/gtoolkit/issues/3915"
	
	self resizerAptitudes ifNotNil: [ :anAptitude |
		anAptitude isAttachedToWidget ifTrue: [ 
			 anAptitude widget removeAptitude: anAptitude ] ]
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

	self detachResizerAptitudes.
	self shouldHideWidget
		ifTrue: [ self widgetDo: [ :aWidget | aWidget visibility: BlVisibility visible ] ].
		
	self visible ifFalse: [ 
		self dispatchEvent: BrDropdownIsHidden new ]
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
BrWithDropdownAptitude >> resizerAptitudeStencil: aStencil [
	"Set resizer aptitude stencil.
	Since this method is called on every extent change (e.g., when users use resizers),
	we want to update resizer aptitudes only if necessary. This is the main purpose
	of {{gtClass:BrGlamorousResizerAptitudeStencil}} instances (plus the resizer aptitude creation).
	
	Example GtWorldByScripterExamples>>#worldSpotter_ResizeVertically_ClosePressingEscape"

	resizerAptitudeStencil = aStencil ifTrue: [ ^ self ].

	resizerAptitudeStencil := aStencil.
	resizerAptitudeStencil isKeepRatio: self isKeepRatio.
	resizerAptitudeStencil whenResizedDo: whenResizedHandler.
	self resizerAptitudes: aStencil create
]

{ #category : #accessing }
BrWithDropdownAptitude >> resizerAptitudes [
	^ resizerAptitudes
]

{ #category : #accessing }
BrWithDropdownAptitude >> resizerAptitudes: aResizerAptitude [
	(resizerAptitudes isNotNil and: [ resizerAptitudes isAttachedToWidget ])
		ifTrue: [ | aWidget |
			aWidget := resizerAptitudes widget.
			aWidget removeAptitude: resizerAptitudes.
			aWidget addAptitude: aResizerAptitude ].
	resizerAptitudes := aResizerAptitude
]

{ #category : #accessing }
BrWithDropdownAptitude >> resizersOnBottom [
	self resizerAptitudeStencil: BrGlamorousResizerBottomAptitudeStencil new.
]

{ #category : #accessing }
BrWithDropdownAptitude >> resizersOnBottomLeft [
	self resizerAptitudeStencil: BrGlamorousResizerBottomLeftAptitudeStencil new.
]

{ #category : #accessing }
BrWithDropdownAptitude >> resizersOnBottomRight [
	self resizerAptitudeStencil: BrGlamorousResizerBottomRightAptitudeStencil new.
]

{ #category : #accessing }
BrWithDropdownAptitude >> resizersOnTop [
	self resizerAptitudeStencil: BrGlamorousResizerTopAptitudeStencil new.
]

{ #category : #accessing }
BrWithDropdownAptitude >> resizersOnTopLeft [
	self resizerAptitudeStencil: BrGlamorousResizerTopLeftAptitudeStencil new.
]

{ #category : #accessing }
BrWithDropdownAptitude >> resizersOnTopRight [
	self resizerAptitudeStencil: BrGlamorousResizerTopRightAptitudeStencil new.
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
		ifTrue: [ self widgetDo: [ :aWidget | aWidget visibility: BlVisibility hidden ] ].
		
	self visible ifTrue: [ 
		self dispatchEvent: BrDropdownIsVisible new ]
]

{ #category : #'api - displaying' }
BrWithDropdownAptitude >> stencil: aValuable [
	super stencil: (BrDropdownContentStencil new
		contentStencil: aValuable;
		decorator: [ :anElement | self createResizerOn: anElement ])
]

{ #category : #private }
BrWithDropdownAptitude >> updateResizerAptitudesKeepRatio [
	resizerAptitudeStencil ifNotNil: [ :aStencil | 
		aStencil isKeepRatio: self isKeepRatio ].

	resizerAptitudes ifNil: [ ^ self ].
	resizerAptitudes withAllActorsDepthFirstDo: [ :anAptitude |
		anAptitude keepRatio: self isKeepRatio ]
]

{ #category : #accessing }
BrWithDropdownAptitude >> whenResizedDo: aBlock [
	whenResizedHandler := aBlock.
	resizerAptitudeStencil ifNotNil: [ :aStencil | 
		aStencil whenResizedDo: aBlock ].
	resizerAptitudes ifNotNil: [
		resizerAptitudes withAllActorsDepthFirstDo: [ :anAptitude |
			anAptitude whenResizedDo: whenResizedHandler ] ]
]
