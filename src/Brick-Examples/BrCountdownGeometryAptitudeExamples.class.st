Class {
	#name : #BrCountdownGeometryAptitudeExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Countdown'
}

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> assertScripter: aScripter animationTasks: anInteger running: aBoolean progress: aProgress [
	| animationTasks |
	animationTasks := aScripter space taskQueue tasks
			select: [ :each | each isKindOf: BlBaseAnimation ].

	self assert: animationTasks size equals: anInteger.

	self
		assert: (animationTasks allSatisfy: [ :each | each isRunning = aBoolean ])
		description: [ aBoolean
				ifTrue: [ 'Animation tasks must be running' ]
				ifFalse: [ 'Animation tasks must be stopped' ] ].


	aProgress ifNil: [ ^ self ].
	animationTasks
		do: [ :each | 
			self
				assert: (each progress closeTo: aProgress precision: 0.01)
				description: [ 'Actual progress is {1}, expected is {2}'
						format: {each progress.
								aProgress} ] ]
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> assertScripter: aScripter finishCallbackCalled: anInteger [
	| aCountdown aCallsCount |
	aCountdown := aScripter userData at: #countdownElement.
	self assert: aCountdown isNotNil.
	aCallsCount := aCountdown userData
			at: self countdownId
			ifPresent: [ :aValue | aValue ]
			ifAbsent: [ 0 ].
	self assert: aCallsCount equals: anInteger
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> assertScripter: aScripter startAngle: anAngle [
	| aCountdown |
	aCountdown := aScripter userData at: #countdownElement.
	self assert: aCountdown isNotNil.
	self assert: (aCountdown geometry isKindOf: BlAnnulusSectorGeometry).
	self assert: aCountdown geometry startAngle equals: anAngle
]

{ #category : #'examples - elements' }
BrCountdownGeometryAptitudeExamples >> countdownElement [
	<gtExample>
	^ BlElement new
		id: self countdownId;
		size: 100 @ 100;
		background: (Color black alpha: 0.5);
		addAptitude: (BrCountdownGeometryAptitude new
				withContextMenuEventHandlers;
				geometry: [ self newGeometry ];
				finishedAction: [ :aWidget | 
					aWidget userData
						at: self countdownId
						ifPresent: [ :aValue | aWidget userData at: self countdownId put: aValue + 1 ]
						ifAbsentPut: [ 1 ] ];
				animation: [ :aWidget :aGeometryStencil | 
					BlNumberTransition new
						onStepDo: [ :eachOffset | aWidget geometry: (aGeometryStencil create startAngle: eachOffset) ];
						from: -90;
						to: 270;
						by: 6;
						duration: 12 seconds ];
				enableAnimation);
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude new
				handleSubmenu: [ BrMenuExamples new menuItems ]);
		addChild: (BlElement new
				id: self spotId;
				size: 10 @ 10;
				relocate: 20 @ 20;
				geometry: BlCircleGeometry new;
				background: Color white)
]

{ #category : #'examples - elements' }
BrCountdownGeometryAptitudeExamples >> countdownId [
	^ #countdown
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first00seconds [
	<gtExample>
	| anElement aCountdown aScripter |
	anElement := self tabgroupElement.
	aCountdown := (anElement query // self countdownId) anyOne.
	aScripter := BlScripter new.
	aScripter userData at: #countdownElement put: aCountdown.
	aScripter userData at: #countdownAptitude put: aCountdown aptitude.
	aScripter space time: BlTime simulated.

	aScripter setElement: anElement.
	aScripter pulse.

	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 1
		running: true
		progress: 0.0.

	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first03seconds [
	<gtExample>
	| aScripter |
	aScripter := self first00seconds.

	self scripter: aScripter wait: 1 second.
	self assertScripter: aScripter startAngle: -60.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 1
		running: true
		progress: 0.08.

	self scripter: aScripter wait: 1 second.
	self assertScripter: aScripter startAngle: -30.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 1
		running: true
		progress: 0.16.

	self scripter: aScripter wait: 1 second.
	self assertScripter: aScripter startAngle: 0.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 1
		running: true
		progress: 0.25.

	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first03seconds_clickTab1 [
	"display tab2 content"

	<gtExample>
	| aScripter |
	aScripter := self first03seconds_clickTab2.

	aScripter click
		label: 'Display tab1 content';
		// self tab1Id;
		playPulseOnce.

	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 1
		running: true
		progress: 0.0.

	self scripter: aScripter wait: 1 second.
	self assertScripter: aScripter startAngle: -60.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 1
		running: true
		progress: 0.08.

	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first03seconds_clickTab1_finish [
	"Timeout without any futhere interactions"

	<gtExample>
	| aScripter |
	aScripter := self first03seconds_clickTab1.

	self scripter: aScripter wait: 1 second.
	self assertScripter: aScripter startAngle: -30.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 1
		running: true
		progress: 0.16.

	self scripter: aScripter wait: 10 second.
	self assertScripter: aScripter startAngle: 270.
	self assertScripter: aScripter finishCallbackCalled: 1.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.0.
		
	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first03seconds_clickTab2 [
	"display tab2 content"

	<gtExample>
	| aScripter |
	aScripter := self first03seconds.

	aScripter click
		label: 'Display tab2 content';
		// self tab2Id;
		playPulseOnce.

	self assertScripter: aScripter startAngle: 0.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.0.

	self scripter: aScripter wait: 1 second.
	self assertScripter: aScripter startAngle: 0.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.0.

	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first03seconds_hover [
	<gtExample>
	| aScripter |
	aScripter := self first03seconds.

	aScripter mouseMoveOver
		label: 'Hover countdown';
		// self countdownId;
		playPulseOnce.

	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.0.

	self scripter: aScripter wait: 1 second.
	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.0.

	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first03seconds_hover2 [
	<gtExample>
	| aScripter |
	aScripter := self first03seconds_leave.

	aScripter mouseMoveOver
		label: 'Hover countdown second time';
		// self countdownId;
		playPulseOnce.

	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.0.

	self scripter: aScripter wait: 1 second.
	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.0.

	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first03seconds_leave [
	"mouse leaves the countdown widget"

	<gtExample>
	| aScripter |
	aScripter := self first03seconds_hover.

	aScripter mouseMoveOver
		label: 'Leave countdown';
		// self tab2Id;
		playPulseOnce.

	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 1
		running: true
		progress: 0.0.

	self scripter: aScripter wait: 1 second.
	self assertScripter: aScripter startAngle: -60.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 1
		running: true
		progress: 0.08.

	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first03seconds_leave2 [
	"mouse leaves the countdown widget second time"

	<gtExample>
	| aScripter |
	aScripter := self first03seconds_hover2.

	aScripter mouseMoveOver
		label: 'Leave countdown';
		// self tab1Id;
		playPulseOnce.

	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 1
		running: true
		progress: 0.0.

	self scripter: aScripter wait: 1 second.
	self assertScripter: aScripter startAngle: -60.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 1
		running: true
		progress: 0.08.

	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first03seconds_popover [
	"mouse open context menu"

	<gtExample>
	| aScripter |
	aScripter := self first03seconds_hover.

	aScripter menuStep
		openContextMenu;
		// self countdownId;
		playPulseOnce.

	aScripter menuStep
		assertMenuContainerExist;
		playPulseOnce.

	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.0.

	self scripter: aScripter wait: 1 second.
	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.0.

	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first03seconds_popover_clickTab1 [
	"display tab1 content"

	<gtExample>
	| aScripter |
	aScripter := self first03seconds_popover_clickTab2.

	aScripter click
		label: 'Display tab1 content';
		// self tab1Id;
		playPulseOnce.

	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 1
		running: true
		progress: 0.0.

	self scripter: aScripter wait: 1 second.
	self assertScripter: aScripter startAngle: -60.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 1
		running: true
		progress: 0.08.

	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first03seconds_popover_clickTab2 [
	"display tab2 content"

	<gtExample>
	| aScripter |
	aScripter := self first03seconds_popover_leave.

	aScripter click
		label: 'Display tab2 content';
		// self tab2Id;
		playPulseOnce.

	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.0.

	self scripter: aScripter wait: 1 second.
	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.0.

	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first03seconds_popover_hover [
	"mouse hovers the countdown widget"

	<gtExample>
	| aScripter |
	aScripter := self first03seconds_popover_leave.

	aScripter mouseMoveOver
		label: 'Hover countdown';
		// self spotId;
		playPulseOnce.

	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.0.

	self scripter: aScripter wait: 1 second.
	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.0.

	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first03seconds_popover_hover_clickContextMenuItem [
	"mouse hovers the countdown widget"

	<gtExample>
	| aScripter |
	aScripter := self first03seconds_popover_hover_hoverContextMenu.

	aScripter click
		label: 'Click menu item';
		onMenuContainer;
		// #'menu-cut-item';
		playPulseOnce.

	aScripter menuStep
		assertClosedMenuContainer;
		playNoPulse.

	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 1
		running: true
		progress: 0.0.

	self scripter: aScripter wait: 1 second.
	self assertScripter: aScripter startAngle: -60.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 1
		running: true
		progress: 0.08.

	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first03seconds_popover_hover_hoverContextMenu [
	"mouse hovers the countdown widget"

	<gtExample>
	| aScripter |
	aScripter := self first03seconds_popover_hover.

	aScripter menuStep
		hoverMenuItemWithId: #'menu-cut-item';
		onMenuContainer;
		playPulseOnce.

	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.0.

	self scripter: aScripter wait: 1 second.
	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.0.

	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first03seconds_popover_leave [
	"mouse leaves context menu and countdown widget"

	<gtExample>
	| aScripter |
	aScripter := self first03seconds_popover.

	aScripter mouseMoveOver
		label: 'Leave countdown and context menu';
		// self tab2Id;
		playPulseOnce.

	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.0.

	self scripter: aScripter wait: 1 second.
	self assertScripter: aScripter startAngle: -90.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.0.

	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first11seconds [
	<gtExample>
	| aScripter |
	aScripter := self first03seconds.

	self scripter: aScripter wait: 8 seconds.
	self assertScripter: aScripter startAngle: 240.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 1
		running: true
		progress: 0.91.

	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first11seconds_disableWishWithCallback [
	<gtExample>
	| aScripter |
	aScripter := self first11seconds.

	aScripter do
		label: 'Disable and stop animation';
		block: [ :anElement | anElement dispatchEvent: BrCountdownDisableAndStopWish withFinishedAction ];
		// self countdownId;
		playPulseOnce.

	self assertScripter: aScripter startAngle: 240.
	self assertScripter: aScripter finishCallbackCalled: 1.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: 0
		progress: 0.91.

	self scripter: aScripter wait: 1 seconds.
	self assertScripter: aScripter startAngle: 240.
	self assertScripter: aScripter finishCallbackCalled: 1.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.91.

	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first11seconds_disableWishWithoutCallback [
	<gtExample>
	| aScripter |
	aScripter := self first11seconds.

	aScripter do
		label: 'Disable and stop animation';
		block: [ :anElement | anElement dispatchEvent: BrCountdownDisableAndStopWish withoutFinishedAction ];
		// self countdownId;
		playPulseOnce.

	self assertScripter: aScripter startAngle: 240.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: 0
		progress: 0.91.

	self scripter: aScripter wait: 1 seconds.
	self assertScripter: aScripter startAngle: 240.
	self assertScripter: aScripter finishCallbackCalled: 0.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.91.

	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first12seconds [
	"Timeout without any interactions"

	<gtExample>
	| aScripter |
	aScripter := self first11seconds.

	self scripter: aScripter wait: 1 second.
	self assertScripter: aScripter startAngle: 270.
	self assertScripter: aScripter finishCallbackCalled: 1.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.0.

	^ aScripter
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> first13seconds [
	"Timeout without any interactions"

	<gtExample>
	| aScripter |
	aScripter := self first12seconds.

	self scripter: aScripter wait: 1 second.
	self assertScripter: aScripter startAngle: 270.
	self assertScripter: aScripter finishCallbackCalled: 1.
	self
		assertScripter: aScripter
		animationTasks: 0
		running: false
		progress: 0.0.

	^ aScripter
]

{ #category : #'examples - elements' }
BrCountdownGeometryAptitudeExamples >> newGeometry [
	^ BlAnnulusSectorGeometry new
		startAngle: -90;
		endAngle: 270;
		innerRadius: 0
]

{ #category : #'examples - animations' }
BrCountdownGeometryAptitudeExamples >> scripter: aScripter wait: aDuration [
	aScripter space time wait: aDuration.
	aScripter pulse
]

{ #category : #'examples - elements' }
BrCountdownGeometryAptitudeExamples >> spotId [
	^ #spot
]

{ #category : #'examples - elements' }
BrCountdownGeometryAptitudeExamples >> tab1Id [
	^ #tab1
]

{ #category : #'examples - elements' }
BrCountdownGeometryAptitudeExamples >> tab2Id [
	^ #tab2
]

{ #category : #'examples - elements' }
BrCountdownGeometryAptitudeExamples >> tabgroupElement [
	<gtExample>
	^ BrTabGroup new
		aptitude: BrGlamorousTabGroupAptitude;
		addTab: (BrTab new
				id: self tab1Id;
				aptitude: BrGlamorousTabAptitude;
				label: 'Countdown';
				stencil: [ self countdownElement margin: (BlInsets all: 10) ]);
		addTab: (BrTab new
				id: self tab2Id;
				aptitude: BrGlamorousTabAptitude;
				label: 'Tab 2';
				stencil: [ BrFrame new
						matchParent;
						margin: (BlInsets all: 10);
						background: Color veryLightGray ])
]
