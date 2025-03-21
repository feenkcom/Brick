Class {
	#name : #BrWithTooltipAptitude,
	#superclass : #BrWithAnchoredAptitude,
	#instVars : [
		'clickEventHandler',
		'overEventHandler',
		'outEventHandler',
		'hideLaterTask',
		'showLaterTask',
		'showDelay',
		'hideDelay',
		'hoverShowCondition'
	],
	#category : #'Brick-Tooltip - Look'
}

{ #category : #accessing }
BrWithTooltipAptitude class >> anchoredAptitudeClass [
	^ BrTooltipAptitude
]

{ #category : #initialization }
BrWithTooltipAptitude >> attachToLeftAndRight [
	strategy := BrAnchoredCompositeStrategy builder
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredCenterRightReferencePoint;
				availableBounds: BrAnchoredCenterRightAvailableBounds;
				apply: [ self removeInnerContainerDropdownAptitudes. 
					innerContainer addAptitude: BrDropdownCenterLeftAptitude ] ];
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredCenterLeftReferencePoint;
				availableBounds: BrAnchoredBottomLeftAvailableBounds;
				apply: [ self removeInnerContainerDropdownAptitudes. 
					innerContainer addAptitude: BrDropdownBottomLeftAptitude ] ];
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredCenterRightReferencePoint;
				availableBounds: BrAnchoredTopRightAvailableBounds;
				apply: [ self removeInnerContainerDropdownAptitudes. 
					innerContainer addAptitude: BrDropdownTopLeftAptitude ] ];
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredCenterLeftReferencePoint;
				availableBounds: BrAnchoredTopLeftAvailableBounds;
				apply: [ self removeInnerContainerDropdownAptitudes. 
					innerContainer addAptitude: BrDropdownTopRightAptitude ] ];
		build.
]

{ #category : #accessing }
BrWithTooltipAptitude >> cancelHideLater [
	hideLaterTask ifNotNil: [ :aTask | aTask stop ].
	hideLaterTask := nil
]

{ #category : #accessing }
BrWithTooltipAptitude >> cancelShowLater [
	showLaterTask ifNotNil: [ :aTask | aTask stop ].
	showLaterTask := nil
]

{ #category : #accessing }
BrWithTooltipAptitude >> contentStencil: aStencil [
	self stencil: [ 
		BrAnchoredElement new
			aptitude: (self class anchoredAptitude content: aStencil asStencil asElement) ]
]

{ #category : #accessing }
BrWithTooltipAptitude >> hide [
	super hide.
	self willShowLater
		ifTrue: [ self cancelShowLater ].
	self willHideLater
		ifTrue: [ self cancelHideLater ]
]

{ #category : #accessing }
BrWithTooltipAptitude >> hideDelay [
	^ hideDelay
]

{ #category : #accessing }
BrWithTooltipAptitude >> hideDelay: anObject [
	hideDelay := anObject
]

{ #category : #accessing }
BrWithTooltipAptitude >> hideLater [
	self canHide ifFalse: [ ^ self ].
	self cancelHideLater.
	self hideDelay ifNil: [ ^ self ].
	hideLaterTask := BlDelayedTaskAction new
			delay: self hideDelay;
			action: [ self canHide ifTrue: [ self hide ].
				hideLaterTask := nil ];
			yourself.
	innerContainer enqueueTask: hideLaterTask
]

{ #category : #initialization }
BrWithTooltipAptitude >> initialize [
	super initialize.
	
	hoverShowCondition := [ :anEvent | true ].
	preferredExtent := 200 @ 50.
	strategy := BrAnchoredCompositeStrategy builder
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredBottomCenterReferencePoint;
				availableBounds: BrAnchoredBottomCenterAvailableBounds;
				scaleFactor: BrAnchoredGlobalScaleFactor;
				apply: [ self removeInnerContainerTooltipAptitudes.
					innerContainer addAptitude: BrTooltipBottomCenterAptitude ] ];
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredTopCenterReferencePoint;
				availableBounds: BrAnchoredTopCenterAvailableBounds;
				scaleFactor: BrAnchoredGlobalScaleFactor;
				apply: [ self removeInnerContainerTooltipAptitudes.
					innerContainer addAptitude: BrTooltipTopCenterAptitude ] ];
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredCenterRightReferencePoint;
				availableBounds: BrAnchoredCenterRightAvailableBounds;
				scaleFactor: BrAnchoredGlobalScaleFactor;
				apply: [ self removeInnerContainerTooltipAptitudes.
					innerContainer addAptitude: BrTooltipCenterRightAptitude ] ];
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredCenterLeftReferencePoint;
				availableBounds: BrAnchoredCenterLeftAvailableBounds;
				scaleFactor: BrAnchoredGlobalScaleFactor;
				apply: [ self removeInnerContainerTooltipAptitudes.
					innerContainer addAptitude: BrTooltipCenterLeftAptitude ] ];
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredBottomLeftReferencePoint;
				availableBounds: BrAnchoredBottomLeftAvailableBounds;
				scaleFactor: BrAnchoredGlobalScaleFactor;
				apply: [ self removeInnerContainerTooltipAptitudes.
					innerContainer addAptitude: BrTooltipBottomLeftAptitude ] ];
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredBottomRightReferencePoint;
				availableBounds: BrAnchoredBottomRightAvailableBounds;
				scaleFactor: BrAnchoredGlobalScaleFactor;
				apply: [ self removeInnerContainerTooltipAptitudes.
					innerContainer addAptitude: BrTooltipBottomRightAptitude ] ];
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredTopLeftReferencePoint;
				availableBounds: BrAnchoredTopLeftAvailableBounds;
				scaleFactor: BrAnchoredGlobalScaleFactor;
				apply: [ self removeInnerContainerTooltipAptitudes.
					innerContainer addAptitude: BrTooltipTopLeftAptitude ] ];
		single: [ :e | 
			e
				anchorBounds: [ :f | widget bounds inParent: f ];
				referencePoint: BrAnchoredTopRightReferencePoint;
				availableBounds: BrAnchoredTopRightAvailableBounds;
				scaleFactor: BrAnchoredGlobalScaleFactor;
				apply: [ self removeInnerContainerTooltipAptitudes.
					innerContainer addAptitude: BrTooltipTopRightAptitude ] ];
		build.
	clickEventHandler := BlEventHandler
		on: BlClickEvent
		do: [ self willHideLater
				ifTrue: [ self cancelHideLater ].
			self canHide
				ifTrue: [ self hide ] ].
	overEventHandler := BlEventHandler
		on: BlMouseEnterEvent
		do: [ :e |
			(self shouldShowDueToHover: e)
				ifTrue: [
					self willHideLater
						ifTrue: [ self cancelHideLater ].
					self canShow
						ifTrue: [ self showLater ] ]
			 ].
	outEventHandler := BlEventHandler
		on: BlMouseLeaveEvent
		do: [ :e | 
			self willShowLater
				ifTrue: [ self cancelShowLater ].
			self canHide
				ifTrue: [ self hideLater ] ].
	self
		addChange:
			(BrLookChange new
				up: [ :e | 
					widget
						addEventHandler: clickEventHandler;
						addEventHandler: overEventHandler;
						addEventHandler: outEventHandler ];
				down: [ :e | 
					widget
						removeEventHandler: clickEventHandler;
						removeEventHandler: overEventHandler;
						removeEventHandler: outEventHandler ];
				yourself);
		addChange:
			(BrLookChange new
				up: [ :e |  ];
				down: [ :e | 
					self willShowLater
						ifTrue: [ self cancelShowLater ].
					self willHideLater
						ifTrue: [ self cancelHideLater ] ];
				yourself).
	self showDelay: 1000 milliSeconds.
	self hideDelay: 300 milliSeconds
]

{ #category : #initialization }
BrWithTooltipAptitude >> initializeListeners [
	super initializeListeners.

	self
		when: BrTooltipRelocateWish
		do: [ :aWish | self onRelocateWish: aWish ].
		
	self
		when: BrTooltipShowWish
		do: [ :aWish | self onShowWish: aWish ].
		
	self
		when: BrTooltipHideWish
		do: [ :aWish | self onHideWish: aWish ]
]

{ #category : #'api - displaying' }
BrWithTooltipAptitude >> onPrimaryHover [
	hoverShowCondition := [ :anEvent | anEvent modifiers isPrimaryModifier ]
]

{ #category : #'api - displaying' }
BrWithTooltipAptitude >> onShiftHover [
	hoverShowCondition := [ :anEvent | anEvent modifiers isShift ]
]

{ #category : #private }
BrWithTooltipAptitude >> removeInnerContainerDropdownAptitudes [
	innerContainer
		aptitudeDo: [ :anAptitude | 
			anAptitude 
				- BrDropdownBottomLeftAptitude 
				- BrDropdownBottomRightAptitude
				- BrDropdownTopLeftAptitude 
				- BrDropdownTopRightAptitude
				- BrDropdownCenterLeftAptitude ]
]

{ #category : #initialization }
BrWithTooltipAptitude >> removeInnerContainerTooltipAptitudes [

	innerContainer
		aptitudeDo: [ :anAptitude | 
			anAptitude 
				- BrTooltipTopCenterAptitude 
				- BrTooltipCenterLeftAptitude
				- BrTooltipCenterRightAptitude 
				- BrTooltipBottomLeftAptitude 
				- BrTooltipBottomRightAptitude
				- BrTooltipTopLeftAptitude
				- BrTooltipTopRightAptitude
				- BrTooltipBottomCenterAptitude ]
]

{ #category : #'private - testing' }
BrWithTooltipAptitude >> shouldShowDueToHover: aMouseOverEvent [
	^ hoverShowCondition value: aMouseOverEvent
]

{ #category : #'host space - displaying' }
BrWithTooltipAptitude >> show [

	self canShow ifFalse: [ ^ self ].
	super show.
	self willShowLater
		ifTrue: [ self cancelShowLater ].
	self willHideLater
		ifTrue: [ self cancelHideLater ].
	innerContainer
		addEventFilterOn: BlMouseEnterEvent do: [ :e | self cancelHideLater ];
		addEventFilterOn: BlMouseLeaveEvent do: [ :e | self hideLater ]
]

{ #category : #accessing }
BrWithTooltipAptitude >> showDelay [
	^ showDelay
]

{ #category : #accessing }
BrWithTooltipAptitude >> showDelay: anObject [
	showDelay := anObject
]

{ #category : #accessing }
BrWithTooltipAptitude >> showLater [
	self assert: [ self canShow ].
	self cancelShowLater.
	showLaterTask := BlDelayedTaskAction new
		delay: self showDelay;
		action: [ self canShow
				ifTrue: [ self show ].
			showLaterTask := nil ];
		yourself.
	widget enqueueTask: showLaterTask
]

{ #category : #testing }
BrWithTooltipAptitude >> willHideLater [
	^ hideLaterTask isNotNil
]

{ #category : #testing }
BrWithTooltipAptitude >> willShowLater [
	^ showLaterTask isNotNil
]
