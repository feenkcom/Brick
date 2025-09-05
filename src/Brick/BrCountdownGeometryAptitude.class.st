"
I use {{gtMethod:BlElement >> geometry:}}  to animate a countdown. When a time expires, {{gtMethod:BrCountdownGeometryAptitude>>#finishedAction:}} is executed.
I stop the countdown when:
- mouse is hovering the given element, or
- the element's context menu/dropdown is opened, or
- when the element is removed from its space.
#How to use it
{{gtExample:BrCountdownGeometryAptitudeExamples>>#countdownElement}}
#Example
In the following example, 3 out of 12 seconds passed out: {{gtExample:BrCountdownGeometryAptitudeExamples>>#first03seconds | noCode | previewShow=#gtSpaceFor:}} 
You can execute the following example and explore it interactively: {{gtExample:BrCountdownGeometryAptitudeExamples>>#tabgroupElement | codeExpanded=true}} 

 

"
Class {
	#name : #BrCountdownGeometryAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'animationStencil',
		'finishedAction',
		'geometryStencil',
		'state',
		'animation',
		'widgetSpace',
		'isFinishedActionEnabled'
	],
	#category : #'Brick-Countdown - Aptitude'
}

{ #category : #'api - initialization' }
BrCountdownGeometryAptitude >> animation: anAnimationStencilBuilder [
	animationStencil := anAnimationStencilBuilder
			asStencilBuilder: BrCountdownGeometryAnimationStencilBuilder
]

{ #category : #'api - animation' }
BrCountdownGeometryAptitude >> disableAnimation [
	"Stop and disable animation"

	self stopAnimation.
	state := BrCountdownGeometryState disabled
]

{ #category : #'api - animation' }
BrCountdownGeometryAptitude >> enableAnimation [
	"Enable and start animation"

	state := state enable.
	self startAnimation
]

{ #category : #accessing }
BrCountdownGeometryAptitude >> finishedAction [
	^ finishedAction
]

{ #category : #'api - initialization' }
BrCountdownGeometryAptitude >> finishedAction: aBlock [
	"Block that is evaluated when countdown reached its time.
	The block is not called if animation is stopped due to
	other reasons, e.g., mouse hover.
	The block receives one argument: [ :aWidget | ]."

	finishedAction := aBlock
]

{ #category : #'api - initialization' }
BrCountdownGeometryAptitude >> geometry: aStencil [
	"Set a default (initial) geometry"

	geometryStencil := aStencil asStencil
]

{ #category : #initialization }
BrCountdownGeometryAptitude >> initialize [
	super initialize.
	self initializeHoveredAptitude.
	
	geometryStencil := [ self newDefaultGeometry ] asStencil.
	animationStencil := [ :aWidget :aGeometryStencil | self newDefaultAnimation ] 
		asStencilBuilder:  BrCountdownGeometryAnimationStencilBuilder.
	finishedAction := [ :aWidget | ].
	isFinishedActionEnabled := true.
	animation := nil.
	state := BrCountdownGeometryState enabled
]

{ #category : #initialization }
BrCountdownGeometryAptitude >> initializeHoveredAptitude [
	self
		add: (BrLazyStyleCommonAptitude new
				hovered: [ :aStyle | 
					aStyle 
						do: [ :aWidget | self onHovered ] 
						after: [ :aWidget | self onUnhovered ] ])
]

{ #category : #initialization }
BrCountdownGeometryAptitude >> initializeListeners [
	super initializeListeners.

	self
		when: BrCountdownDisableAndStopWish
		do: [ :anEvent | self onGtTreePagerCountdownDisableWish: anEvent ].
	self
		when: BrCountdownEnableAndStartWish
		do: [ :anEvent | self onGtTreePagerCountdownEnableWish: anEvent ].
	self
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | self onBlElementAddedToSceneGraphEvent: anEvent ].
	self
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | self onBlElementRemovedFromSceneGraphEvent: anEvent ]
]

{ #category : #'private - event management' }
BrCountdownGeometryAptitude >> isFinishedActionEnabled [
	^ isFinishedActionEnabled ifNil: [ true ]
]

{ #category : #initialization }
BrCountdownGeometryAptitude >> newDefaultAnimation [
	^ BlNumberTransition new
		onStepDo: [ :eachOffset | 
			self widgetDo: [ :aWidget | 
				aWidget geometry: (self newDefaultGeometry startAngle: eachOffset) ] ];
		from: -90;
		to: 270;
		by: 6;
		duration: 12 seconds
]

{ #category : #initialization }
BrCountdownGeometryAptitude >> newDefaultGeometry [
	^ BlAnnulusSectorGeometry new
		startAngle: -90;
		endAngle: 270;
		innerRadius: 0
]

{ #category : #'private - event management' }
BrCountdownGeometryAptitude >> onAnimationFinished [
	| anAnimation aState |
	anAnimation := animation.
	aState := state.
	animation := nil.
	
	"Let's ensure we run the finished action only in running state.
	Other states, e.g., opened context menu, prevent execution."
	state ifRunFinished: [
		self widgetDo: [ :aWidget | 
			self isFinishedActionEnabled ifTrue: [
				finishedAction cull: aWidget ] ] ].
	
	state := state finish.
]

{ #category : #'api - hooks' }
BrCountdownGeometryAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.

	state ifReady: [ self startAnimation ]
]

{ #category : #initialization }
BrCountdownGeometryAptitude >> onBlElementAddedToSceneGraphEvent: anEvent [
	self widgetDo: [ :aWidget |
		widgetSpace := aWidget space ].

	state ifReady: [ self startAnimation ]
]

{ #category : #initialization }
BrCountdownGeometryAptitude >> onBlElementRemovedFromSceneGraphEvent: anEvent [
	| anAnimation aState |
	anAnimation := animation.
	aState := state.
	state ifRunning: [ 
		state := BrCountdownGeometryState ready.
		self stopAnimation ].
		
	widgetSpace := nil.
]

{ #category : #'private - event management' }
BrCountdownGeometryAptitude >> onGtTreePagerCountdownDisableWish: anEvent [
	anEvent consumed: true.
	anEvent isDisableFinishedAction 
		ifTrue: [ self withoutFinishedAction ]
		ifFalse: [ self withFinishedAction ].
	self disableAnimation
]

{ #category : #'private - event management' }
BrCountdownGeometryAptitude >> onGtTreePagerCountdownEnableWish: anEvent [
	anEvent consumed: true.
	anEvent isDisableFinishedAction 
		ifTrue: [ self withoutFinishedAction ]
		ifFalse: [ self withFinishedAction ].
	self enableAnimation
]

{ #category : #'private - event management' }
BrCountdownGeometryAptitude >> onHovered [
	state ifRunning: [
		state := BrCountdownGeometryState hovered.
		self stopAnimation.
		self setInitialGeometry ].
]

{ #category : #'private - event management' }
BrCountdownGeometryAptitude >> onPopoverIsHidden: anEvent [
	self widgetDo: [ :aWidget | 
		aWidget isAttachedToSceneGraph ifFalse: [ ^ self ] ].
		
	self widgetDo: [ :aWidget | 
		state := state unpopover.
		state ifReady: [ self startAnimation ] ]
]

{ #category : #'private - event management' }
BrCountdownGeometryAptitude >> onPopoverIsVisible: anEvent [
	anEvent consumed: true.

	state ifPopover: [ 
		state := BrCountdownGeometryState popover.
		self stopAnimation.
		self setInitialGeometry ]
]

{ #category : #'private - event management' }
BrCountdownGeometryAptitude >> onUnhovered [
	state := state unhover.
	state ifReady: [ self startAnimation ]
]

{ #category : #'private - updating' }
BrCountdownGeometryAptitude >> setInitialGeometry [
	self widgetDo: [ :aWidget | 
		aWidget geometry: geometryStencil create ]
]

{ #category : #'private - updating' }
BrCountdownGeometryAptitude >> startAnimation [
	animation ifNotNil: [
		state := BrCountdownGeometryState running.
		^ self ].

	state ifEnabled: [ 
		self
			widgetDo: [ :aWidget | 
				animation := animationStencil
						widget: aWidget;
						geometryStencil: geometryStencil;
						build.
				animation onFinishedDo: [ self onAnimationFinished ].
				aWidget addAnimation: animation.
				state := BrCountdownGeometryState running.
				^ self ].
		state := BrCountdownGeometryState ready ] 
]

{ #category : #'private - updating' }
BrCountdownGeometryAptitude >> stopAnimation [
	| oldAnimation aState isRunning isStarted |
	oldAnimation := animation.
	oldAnimation ifNotNil: [
		isRunning := oldAnimation isRunning.
		isStarted := oldAnimation isStarted ].
	aState := state.
	
	animation
		ifNotNil: [ :anAnimation | 
			anAnimation isStarted 
				ifFalse: [ 
					widgetSpace ifNotNil: [ :aSpace |
						aSpace dequeueTask: anAnimation.
						animation := nil ] ]
				ifTrue: [
					anAnimation stopIfRunning.
					animation := nil ] ].
	
	state := state enable
]

{ #category : #initialization }
BrCountdownGeometryAptitude >> withContextMenuEventHandlers [
	self
		when: BrContextMenuIsVisible
			do: [ :anEvent | self onPopoverIsVisible: anEvent ];
		when: BrContextMenuIsHidden
			do: [ :anEvent | self onPopoverIsHidden: anEvent ]
]

{ #category : #initialization }
BrCountdownGeometryAptitude >> withDropdownEventHandlers [
	self
		when: BrDropdownIsVisible
			do: [ :anEvent | self onPopoverIsVisible: anEvent ];
		when: BrDropdownIsHidden
			do: [ :anEvent | self onPopoverIsHidden: anEvent ]
]

{ #category : #'api - animation' }
BrCountdownGeometryAptitude >> withFinishedAction [
	isFinishedActionEnabled := true
]

{ #category : #'api - animation' }
BrCountdownGeometryAptitude >> withoutFinishedAction [
	isFinishedActionEnabled := false
]
