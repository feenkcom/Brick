Class {
	#name : #BrWithAnchoredAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'root',
		'outerContainer',
		'innerContainer',
		'stencil',
		'strategy',
		'preferredExtent',
		'watchDog',
		'clickOutsideEventHandler',
		'pressEscEventHandler',
		'extentChangedEventHandler',
		'positionInSpaceChangedEventHandler',
		'hideEventHandler',
		'showEventHandler',
		'relocateEventHandler',
		'dragStartEventHandler'
	],
	#category : #'Brick-Anchored - Look'
}

{ #category : #accessing }
BrWithAnchoredAptitude class >> anchoredAptitude [
	^ self anchoredAptitudeClass new
]

{ #category : #accessing }
BrWithAnchoredAptitude class >> content: anObject [
	^ self
		stencil: [ :aWidget |
			| aContentStencil aContentElement |
			aContentStencil := anObject asStencilBuilder: BrAnchoredAptitudeStencilBuilder.
			
			aContentElement := aContentStencil
				widget: aWidget;
				asElement.
				
			BrAnchoredElement new
				aptitude: (self anchoredAptitude
						content: aContentElement;
						yourself);
				yourself ]
]

{ #category : #'instance creation' }
BrWithAnchoredAptitude class >> handle: anObject content: anotherObject [
	^ self
		handle: anObject
		content: anotherObject
		aptitudeDo: [ :anAnchoredLook | ]
]

{ #category : #'instance creation' }
BrWithAnchoredAptitude class >> handle: anObject content: anotherObject aptitudeDo: aBlock [
	^ self
		stencil: [ :aWidget |
			| anAnchoredAptitude aContentStencil aContentElement|
			
			aContentStencil := anotherObject asStencilBuilder: BrAnchoredAptitudeStencilBuilder.
			
			aContentElement := aContentStencil
				widget: aWidget;
				asElement.

			anAnchoredAptitude := self anchoredAptitude
					handle: anObject asStencil asElement;
					content: aContentElement;
					yourself.

			aBlock value: anAnchoredAptitude.

			BrAnchoredElement new
				aptitude: anAnchoredAptitude;
				yourself ]
]

{ #category : #accessing }
BrWithAnchoredAptitude class >> stencil: anObject [
	^ self new
		stencil: anObject;
		yourself
]

{ #category : #testing }
BrWithAnchoredAptitude >> canHide [
	^ self visible
]

{ #category : #testing }
BrWithAnchoredAptitude >> canRelocate [
	^ widget isNotNil
		and: [ widget isAttachedToSceneGraph
				and: [ outerContainer isNotNil
						and: [ outerContainer isAttachedToSceneGraph 
							and: [ innerContainer isNotNil
								and: [ innerContainer hasChildren ] ] ] ] ]
]

{ #category : #testing }
BrWithAnchoredAptitude >> canShow [
	^ self visible not
		and: [ widget isNotNil
				and:
					[ widget isAttachedToSceneGraph and: [ widget visibility shouldDraw ] ] ]
]

{ #category : #initialization }
BrWithAnchoredAptitude >> handleDragStartEvent: anEvent [
	self canHide
		ifTrue: [ self hide ]
]

{ #category : #initialization }
BrWithAnchoredAptitude >> handleMouseUpEvent: e [
	"hide when clicked outside of container" 
	((e target ~~ innerContainer and: [ 
		  (e target hasParent: innerContainer) not ]) and: [ self canHide ]) 
		ifTrue: [ self hide ]
]

{ #category : #initialization }
BrWithAnchoredAptitude >> hasModifiers: anEvent [

	"Return true if any modifiers are pressed"

	<return: #Boolean>
	^ anEvent modifiers isAlt or: [ 
		  anEvent modifiers isCmd or: [ 
			  anEvent modifiers isCtrl or: [ 
				  anEvent modifiers isShift ] ] ]
]

{ #category : #'api - displaying' }
BrWithAnchoredAptitude >> hide [
	self canHide
		ifFalse: [ ^ self ].

	widget
		removeEventHandler: extentChangedEventHandler;
		removeEventHandler: positionInSpaceChangedEventHandler;
		removeEventHandler: dragStartEventHandler.
	self root
		removeChild: outerContainer;
		removeEventFilter: clickOutsideEventHandler;
		removeShortcut: pressEscEventHandler.
	outerContainer := nil.
	self
		flag: 'TODO extentChangedEventHandler really needed on inner container?'.
	innerContainer
		dequeueTask: watchDog;
		removeEventHandler: extentChangedEventHandler.
	
	self onAnchoredElementRemoved: innerContainer.	
	innerContainer := nil
]

{ #category : #initialization }
BrWithAnchoredAptitude >> initialize [
	super initialize.
	self stencil: [ :aWidget | BlElement new ].
	watchDog := BlRepeatedTaskAction new
			delay: 500 milliSeconds;
			action: [  "hide when widget removed from scene by checking repeatedly"(widget
					isAttachedToSceneGraph not and: [ self canHide ]) ifTrue: [ self hide ] ];
			yourself.

	clickOutsideEventHandler := BlEventHandler
			on: BlMouseUpEvent
			do: [ :e | (self hasModifiers: e) ifFalse: [ self handleMouseUpEvent: e ] ].

	dragStartEventHandler := BlEventHandler
			on: BlDragStartEvent
			do: [ :e | self handleDragStartEvent: e ].

	pressEscEventHandler := BlShortcutWithAction new
			combination: BlKeyCombination escape;
			action: [ self canHide ifTrue: [ self hide ] ].

	extentChangedEventHandler := BlEventHandler
			on: BlElementExtentChangedEvent
			do: [  "relocate when extent changes":e | self visible ifTrue: [ self relocate ] ].

	positionInSpaceChangedEventHandler := BlEventHandler
			on: BlElementPositionInSpaceChangedEvent
			do: [  "relocate when position in space changes"self visible
					ifTrue: [ self relocate ] ].

	self
		addChange: (BrLookChange new
				up: [ :e |  ];
				down: [ :e | self canHide ifTrue: [ self hide ] ];
				yourself)
]

{ #category : #initialization }
BrWithAnchoredAptitude >> initializeListeners [
	super initializeListeners.

	self
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | self onAddedToSceneGraphEvent: anEvent ]
]

{ #category : #'event handling' }
BrWithAnchoredAptitude >> onAddedToSceneGraphEvent: anEvent [ 
	root ifNil: [ ^ self ].
	self widget space == self root space ifTrue: [ ^ self ].
	
	"Since the widget is displayed in another space, 
	we need to reset the root element in order to display
	anchored elements in the same space as the widget.
	See https://github.com/feenkcom/gtoolkit/issues/3945"
	self root: nil
]

{ #category : #'private - hooks' }
BrWithAnchoredAptitude >> onAnchoredElementCreated: anAnchoredElement [
]

{ #category : #'private - hooks' }
BrWithAnchoredAptitude >> onAnchoredElementRemoved: anAnchoredElement [
]

{ #category : #'private - event handling' }
BrWithAnchoredAptitude >> onHideWish: aWish [
	"hide on wish"

	"if an anchor is explicitely specified we can hide"
	(aWish anchor = widget)
		ifTrue: [
			aWish consumed: true.
			^ self hide ].
	
	"if anchor is not specified and the souce is within the widget - hide"
	(aWish anchor isNil and: [ aWish source = widget or: [ aWish source hasParent: widget ] ])
		ifTrue: [ 
			aWish consumed: true.
			^ self hide ].
		
	"if anchor is not specified and the souce is within the outer container - hide"
	((aWish anchor isNil and: [ outerContainer notNil ]) and: [ aWish source = outerContainer or: [ aWish source hasParent: outerContainer ] ])
		ifTrue: [ 
			aWish consumed: true.
			^ self hide ]
]

{ #category : #'private - event handling' }
BrWithAnchoredAptitude >> onRelocateWish: aWish [
	(aWish anchor = widget and: [ self canRelocate ])
		ifTrue: [ self relocate: aWish ]
]

{ #category : #'private - event handling' }
BrWithAnchoredAptitude >> onShowWish: aWish [
	self canShow
		ifFalse: [ ^ self ].
		
	"if an anchor is explicitely specified we can show"
	(aWish anchor = widget)
		ifTrue: [
			aWish consumed: true.
			^ self show ].
	
	"if anchor is not specify we can check the source of the wish"
	(aWish anchor isNil and: [ aWish source = widget or: [ aWish source hasParent: widget ] ])
		ifTrue: [ 
			aWish consumed: true.
			^ self show ]
]

{ #category : #accessing }
BrWithAnchoredAptitude >> preferredExtent [
	"Answer the minimum extent required by the widget.
	This will be used by the ${class:name=BrAnchoredAvailableBounds}$ to determine where the widget should be placed and its available extent."
	<return: #Point>

	^ preferredExtent
]

{ #category : #accessing }
BrWithAnchoredAptitude >> preferredExtent: anObject [
	preferredExtent = anObject
		ifTrue: [ ^ self ].
	preferredExtent := anObject.
	self canRelocate
		ifTrue: [ self canRelocate ]
]

{ #category : #'private - event handling' }
BrWithAnchoredAptitude >> relocate [
	self relocate: nil
]

{ #category : #'private - event handling' }
BrWithAnchoredAptitude >> relocate: aRelocateEvent [
	self canRelocate
		ifFalse: [ ^ self ].
	
	[ strategy
		invalidate: outerContainer
		forPreferredExtent: preferredExtent ]
			on: Error
			do: [ :anError |
				anError emit.

				NonInteractiveTranscript stdout
					nextPutAll: '[';
					nextPutAll: self class name;
					nextPutAll: '] ';
					print: anError;
					cr.
			]
]

{ #category : #accessing }
BrWithAnchoredAptitude >> root [
	^ root ifNil: [ root := widget topMostParent ]
]

{ #category : #accessing }
BrWithAnchoredAptitude >> root: anElement [
	| shouldHide |
	self flag: 'TODO root should be part of model'.
	shouldHide := self canHide.
	shouldHide
		ifTrue: [ self hide ].
	root := anElement.
	shouldHide
		ifTrue: [ self show ]
]

{ #category : #'api - displaying' }
BrWithAnchoredAptitude >> show [
	self canShow ifFalse: [ ^ self ].

	(stencil isKindOf: BrAnchoredAptitudeStencilBuilder)
		ifFalse: [ stencil := stencil asStencilBuilder: BrAnchoredAptitudeStencilBuilder].
	
	self flag: 'TODO extentChangedEventHandler really needed on inner container?'.
	innerContainer := stencil
		widget: widget;
		asElement.
	innerContainer addEventHandler: extentChangedEventHandler.

	self onAnchoredElementCreated: innerContainer.

	watchDog isRunning ifFalse: [ innerContainer enqueueTask: watchDog ].

	self flag: 'TODO get rid of having to set anchor'.
	innerContainer anchor: widget.

	outerContainer := BrAnchoredOuterContainer new
			addChild: innerContainer;
			yourself.
	self root
		addChild: outerContainer;
		addEventFilter: clickOutsideEventHandler;
		addShortcut: pressEscEventHandler.
	widget
		addEventHandler: extentChangedEventHandler;
		addEventHandler: positionInSpaceChangedEventHandler.
		
	dragStartEventHandler
		ifNotNil: [ widget addEventHandler: dragStartEventHandler ].
		
	self relocate
]

{ #category : #accessing }
BrWithAnchoredAptitude >> stencil [
	^ stencil
]

{ #category : #accessing }
BrWithAnchoredAptitude >> stencil: aValuable [
	stencil = aValuable
		ifTrue: [ ^ self ].
	stencil := aValuable asStencilBuilder: BrAnchoredAptitudeStencilBuilder.
	self canHide
		ifTrue: [ self
				hide;
				show ]
]

{ #category : #accessing }
BrWithAnchoredAptitude >> strategy [
	^ strategy
]

{ #category : #accessing }
BrWithAnchoredAptitude >> strategy: anObject [
	strategy = anObject
		ifTrue: [ ^ self ].
	strategy := anObject.
	self canRelocate
		ifTrue: [ self relocate ]
]

{ #category : #accessing }
BrWithAnchoredAptitude >> visible [
	^ innerContainer ifNil: [ false ] ifNotNil: #isAttachedToSceneGraph
]

{ #category : #accessing }
BrWithAnchoredAptitude >> visible: aBoolean [
	aBoolean
		ifTrue: [ self canShow
				ifTrue: [ self show ] ]
		ifFalse: [ self canHide
				ifTrue: [ self hide ] ]
]
