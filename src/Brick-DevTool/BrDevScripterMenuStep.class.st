Class {
	#name : #BrDevScripterMenuStep,
	#superclass : #BlDevScripterToolActionStep,
	#category : #'Brick-DevTool-Scripter'
}

{ #category : #'steps - interactions' }
BrDevScripterMenuStep >> actOnMenuItemKeyPress [
	^ self keyPress
		label: 'Press return to act on menu item';
		key: BlKeyboardKey return;
		referenceSender
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertClosedMenuContainer [
	^ (self assertMenuContainerExist: 0) referenceSender
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertDeselectedMenuItem: anElementId [
	^ self assert
		label: ('Assert deselected menu item with ID: {1}' format: {anElementId});
		satisfies: [ :anElement | anElement states isSelected not ];
		referenceSender;
		onParentStepTarget: self;
		// anElementId
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertDropdownContainerHasEmptyElementCache [
	^ (self
		assertMenuContainerHasEmptyElementCacheFor: BrWithExplicitDropdownAptitude)
		referenceSender
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertDropdownContainerHasEmptyElementCacheInElement: anElement [
	^ self assertDropdownContainerHasEmptyElementCache
		onElement: anElement;
		referenceSender
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertDropdownElementCacheSize: aCacheSize [
	^ (self
		assertMenuContainerElementCacheSize: aCacheSize
		for: BrWithExplicitDropdownAptitude) referenceSender
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertDropdownElementCacheSize: aCacheSize inElement: anElement [
	^ (self assertDropdownElementCacheSize: aCacheSize)
		onElement: anElement;
		referenceSender
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertHandleCenterInSpacePosition: aSpacePosition [
	| aLabel aHandlePosition |
	aLabel := 'Assert handle center position in space is {1}'
			format: {aSpacePosition}.

	^ self assert
		label: aLabel;
		satisfies: [ :aSpaceRoot |
			| aHandleElement |
			aHandleElement :=(aSpaceRoot query // BrMenuSteppedElement) anyOne childAt: 1.
			aHandlePosition := aHandleElement boundsInSpace center.
			aHandlePosition closeTo: aSpacePosition precision: 0.0001 ]
			description: [ :aMenuContainer | 
				'Handle center position is {1}. Expected position is {2}' 
					format: { aHandlePosition. aSpacePosition } ];
		referenceSender;
		onSpaceRoot
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertMenuContainerChildrenCount: anExpectedCount [
	^ self assert
		label: ('Assert popover container has {1} children' format: {anExpectedCount});
		value: [ :aMenuContainer | aMenuContainer childrenCount ]
			equals: anExpectedCount;
		referenceSender;
		onParentStepTarget: self;
		onThisOrBreadthFirstChildOfKind: BrMenuSteppedElement
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertMenuContainerElementCacheSize: aCacheSize for: aMenuAptitudeClass [
	^ self assert
		referenceSender;
		label: ('Assert menu container element cache has {1} elements' format: { aCacheSize });
		satisfies: [ :anAnchorElement | 
				self
					ifAnchorElement: anAnchorElement
					hasMenuAptitudeOfClass: aMenuAptitudeClass
					do: [ :aMenuAptitude | aMenuAptitude menuContainer elementCache size = aCacheSize ]
					ifAbsent: [ NotFound signalFor: aMenuAptitudeClass in: anAnchorElement ] ]
			description: [ :anAnchorElement | '{1}''s menu container has cached menu elements' ]
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertMenuContainerExist [
	^ (self assertMenuContainerExist: 1) referenceSender
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertMenuContainerExist: anExpectedCount [
	| anExistingCount aLabel |
	aLabel := anExpectedCount isZero
			ifFalse: [ 'Assert existing {1} menu {2}'
					format: {anExpectedCount.
							'container' asPluralBasedOn: anExpectedCount} ]
			ifTrue: [ 'Assert all menus are closed or hidden' ].

	^ self assert
		label: aLabel;
		satisfies: [ :aRootElement | 
				anExistingCount := (aRootElement query // BrMenuSteppedElement) all size.
				anExistingCount = anExpectedCount ]
			description: [ :aRootElement | 
				'Expected {1} menu container, actual number is: {2}'
					format: {anExpectedCount.
							anExistingCount} ];
		referenceSender;
		onSpaceRoot
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertMenuContainerHandleGlobalCenterPosition: aPoint [
	^ self assert
		label: ('Assert handle global center position: {1}' format: {aPoint});
		value: [ :aMenuContainer | 
				self
					assert: (aMenuContainer isKindOf: BrMenuSteppedElement)
					description: [ 'Menu container must be kind of {1}, but is {2}'
							format: {BrMenuSteppedElement.
									aMenuContainer class} ].
				self
					assert: aMenuContainer hasChildren
					description: [ 'Menu container must have children' ].
				(aMenuContainer childAt: 1) bounds inSpace center ]
			equals: aPoint;
		referenceSender;
		onParentStepTarget: self
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertMenuContainerHandleGlobalTopLeftPosition: aPoint [
	^ self assert
		label: ('Assert handle global top left position: {1}' format: {aPoint});
		value: [ :aMenuContainer | 
				self assert: aMenuContainer hasChildren.
				(aMenuContainer childAt: 1) bounds inSpace topLeft ]
			equals: aPoint;
		referenceSender;
		onParentStepTarget: self
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertMenuContainerHasEmptyElementCacheFor: aMenuAptitudeClass [
	^ self assert
		referenceSender;
		label: 'Assert menu container is empty element cache';
		satisfies: [ :anAnchorElement | 
				self
					ifAnchorElement: anAnchorElement
					hasMenuAptitudeOfClass: aMenuAptitudeClass
					do: [ :aMenuAptitude | aMenuAptitude menuContainer hasEmptyElementCache ]
					ifAbsent: [ NotFound signalFor: aMenuAptitudeClass in: anAnchorElement ] ]
			description: [ :anAnchorElement | '{1}''s menu container has cached menu elements' ]
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertMenuContainerHasFocus [
	^ self assert
		label: 'Assert menu container has focus';
		satisfies: [ :aSteppedElement | aSteppedElement hasFocus ]
			description: [ :aSteppedElement | 'Menu container must have focus: {1}' format: {aSteppedElement} ];
		referenceSender;
		onParentStepTarget: self;
		onThisOrBreadthFirstChildOfKind: BrMenuSteppedElement
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertMenuContainerLayoutAnchorBounds: aRectangle [
	^ self assert
		label: ('Assert menu container layout anchor bounds: {1}' format: {aRectangle});
		value: [ :aMenuContainer | 
				self
					assert: (aMenuContainer isKindOf: BrMenuSteppedElement)
					description: [ 'Menu container must be kind of {1}, but is {2}'
							format: {BrMenuSteppedElement.
									aMenuContainer class} ].
				aMenuContainer layout anchorBounds ]
			equals: aRectangle;
		referenceSender;
		onParentStepTarget: self
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertMenuItemWithLabelExists: aLabel [
	^ self assert
		label: ('Assert menu item with label {1} exists' format: {aLabel});
		exists;
		referenceSender;
		onParentStepTarget: self;
		// #'menu--list';
		// #'menu--label';
		@ [ :each | each text asString = aLabel ]
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertPermanentlyHiddenDropdown [
	"It means that the menu will not be displayed unless explicitly requested.
	For example, temporarily hidden menus are opened again, once its anchor element 
	is again added to the space graph."

	^ (self assertPermanentlyHiddenMenuContainerFor: BrWithExplicitDropdownAptitude)
		referenceSender
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertPermanentlyHiddenDropdownInElement: anElement [
	"It means that the menu will not be displayed unless explicitly requested.
	For example, temporarily hidden menus are opened again, once its anchor element 
	is again added to the space graph."

	^ self assertPermanentlyHiddenDropdown
		onElement: anElement;
		referenceSender
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertPermanentlyHiddenMenuContainerFor: aMenuAptitudeClass [
	"It means that the menu will not be displayed unless explicitly requested.
	For example, temporarily hidden menus are opened again, once its anchor element 
	is again added to the space graph."

	^ self assert
		referenceSender;
		label: 'Assert menu container is permanently hidden';
		satisfies: [ :anAnchorElement | 
				self
					ifAnchorElement: anAnchorElement
					hasMenuAptitudeOfClass: aMenuAptitudeClass
					do: [ :aMenuAptitude | aMenuAptitude isTemporarilyHidden not ]
					ifAbsent: [ NotFound signalFor: aMenuAptitudeClass in: anAnchorElement ] ]
			description: [ :anAnchorElement | '{1} is not permanently hidden' ];
		onParentStepTarget: self
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertPositionToTheRightOfElementWithId: anElementId [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: ('Assert popover element position is to the right: {1}' format: {anElementId});
		satisfies: [ :anElement :aUserData | 
			| anIndex aSibling |
			self
				assert: anElement hasParent
				description: [ 'Element must have a parent' ].
			anIndex := anElement parent childIndexOf: anElement.
			self
				assert: anIndex > 1
				description: [ 'Element must have previous siblings (having child index > 1)' ].
			aSibling := anElement parent childAt: anIndex - 1.
			aSibling bounds inSpace right <= anElement bounds inSpace left ];
		// anElementId
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertSamePositionOfElementWithId: anElementId [
	^ self assert
		referenceSender;
		onParentStepTarget: self;
		label: ('Assert popover element position: {1}' format: { anElementId });
		value: [ :anElement :aUserData | anElement position ]
			equals: [ :anElement :aUserData | aUserData at: { #elementPosition. anElementId } ];
		// anElementId
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertSelectedMenuItem: anElementId [
	^ self assert
		label: ('Assert selected menu item with ID: {1}' format: {anElementId});
		satisfies: [ :anElement | anElement states isSelected ];
		referenceSender;
		onParentStepTarget: self;
		// anElementId
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertTemporarilyHiddenDropdown [
	"It means that once its anchor widget is back in its scene graph, 
	the menu will be visible again."

	^ (self assertTemporarilyHiddenMenuContainerFor: BrWithExplicitDropdownAptitude)
		referenceSender
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertTemporarilyHiddenDropdownInElement: anAnchorElement [
	"It means that once its anchor widget is back in its scene graph, 
	the menu will be visible again."

	^ self assertTemporarilyHiddenDropdown
		onElement: anAnchorElement;
		referenceSender
]

{ #category : #'steps - checks' }
BrDevScripterMenuStep >> assertTemporarilyHiddenMenuContainerFor: aMenuAptitudeClass [
	"It means that once its anchor widget is back in its scene graph, 
	the menu will be visible again."

	^ self assert
		referenceSender;
		label: 'Assert menu container is temporarily hidden';
		satisfies: [ :anAnchorElement | 
				self
					ifAnchorElement: anAnchorElement
					hasMenuAptitudeOfClass: aMenuAptitudeClass
					do: [ :aMenuAptitude | aMenuAptitude isTemporarilyHidden ]
					ifAbsent: [ NotFound signalFor: aMenuAptitudeClass in: anAnchorElement ] ]
			description: [ :anAnchorElement | '{1} is not temporarily hidden, but closed permanently' ];
		onParentStepTarget: self
]

{ #category : #'steps - interactions' }
BrDevScripterMenuStep >> clickHandle [
	^ self click
		label: 'Click handle';
		referenceSender;
		onChildAt: 1
]

{ #category : #'steps - interactions' }
BrDevScripterMenuStep >> clickHandleWithId: anElementId [
	^ self click
		label: ('Click handle with ID: {1}' format: {anElementId});
		referenceSender;
		// anElementId
]

{ #category : #'steps - interactions' }
BrDevScripterMenuStep >> clickMenuItemWithId: anElementId [
	^ self click
		label: ('Click menu item with ID: {1}' format: {anElementId});
		referenceSender;
		// anElementId
]

{ #category : #'steps - interactions' }
BrDevScripterMenuStep >> clickPinnedElementCloseButton [
	^ self click
		label: 'Click pinned element close button';
		// BrPopoverPinnedCloseButtonId
]

{ #category : #'steps - interactions' }
BrDevScripterMenuStep >> displayTooltip [
	^ self mouseMoveOver
		label: 'Display tooltip';
		onParentStepTarget: self;
		referenceSender
]

{ #category : #'steps - interactions' }
BrDevScripterMenuStep >> hoverMenuItem [
	^ self mouseMoveOver
		label: 'Hover menu item';
		referenceSender;
		onParentStepTarget: self
]

{ #category : #'steps - interactions' }
BrDevScripterMenuStep >> hoverMenuItemWithId: anElementId [
	^ self hoverMenuItem
		label: ('Hover menu item with ID: {1}' format: {anElementId});
		referenceSender;
		// anElementId
]

{ #category : #'steps - interactions' }
BrDevScripterMenuStep >> hoverMenuItemWithLabel: aLabel [
	^ self hoverMenuItem
		label: ('Hover menu item with label: {1}' format: {aLabel});
		referenceSender;
		// #'menu--list';
		// #'menu--label';
		@ [ :each | each text asString = aLabel ]
]

{ #category : #'private - support' }
BrDevScripterMenuStep >> ifAnchorElement: anAnchorElement hasMenuAptitudeOfClass: aMenuAptitudeClass do: aDoBlock ifAbsent: anAbsentBlock [
	anAnchorElement
		aptitudeDo: [ :anAptitude | 
			anAptitude
				withAllActorsBreadthFirstDo: [ :eachAptitude | 
					(eachAptitude isKindOf: aMenuAptitudeClass)
						ifTrue: [ ^ aDoBlock cull: eachAptitude ] ] ].

	^ anAbsentBlock value
]

{ #category : #'steps - other' }
BrDevScripterMenuStep >> keepPermanentlyDropdownInScene [
	^ (self keepPermanentlyMenuInScene: BrGlamorousWithExplicitDropdownAptitude) 
		referenceSender
]

{ #category : #'steps - other' }
BrDevScripterMenuStep >> keepPermanentlyMenuInScene: aMenuAptitudeClass [
	"I am used for demo purposes."

	^ self do
		referenceSender;
		onParentStepTarget: self;
		label: 'Keep menu permanently in its scene';
		block: [ :anElement | 
			anElement aptitude
				findActor: aMenuAptitudeClass
				ifFound: [ :aDropdownAptitude | 
					aDropdownAptitude
						removeSceneEventHandlers;
						removeClickOutsideEventHandler;
						removePressEscEventHandler ]
				ifNone: [ NotFound
						signalFor: aMenuAptitudeClass
						in: anElement ] ]
]

{ #category : #'steps - interactions' }
BrDevScripterMenuStep >> nextMenuItemKeyPress [
	^ self keyPress
		label: 'Press arrow down';
		key: BlKeyboardKey arrowDown;
		referenceSender
]

{ #category : #'steps - interactions' }
BrDevScripterMenuStep >> nextSubmenuKeyPress [
	^ self keyPress
		label: 'Press arrow right';
		key: BlKeyboardKey arrowRight;
		referenceSender
]

{ #category : #'steps - interactions' }
BrDevScripterMenuStep >> openContextMenu [
	^ self secondaryClick
		label: 'Open context menu';
		onParentStepTarget: self;
		referenceSender
]

{ #category : #'steps - interactions' }
BrDevScripterMenuStep >> openContextMenuAtLocalPosition: aPosition [
	^ self secondaryClick
		label: 'Open context menu';
		localPosition: aPosition;
		onParentStepTarget: self;
		referenceSender
]

{ #category : #'steps - interactions' }
BrDevScripterMenuStep >> openDropdown [
	^ self click
		label: 'Open dropdown';
		referenceSender
]

{ #category : #'steps - interactions' }
BrDevScripterMenuStep >> openDropdownWithId: anElementId [
	^ self openDropdown
		label: ('Open dropdown with ID: {1}' format: {anElementId});
		referenceSender;
		// anElementId
]

{ #category : #'steps - other' }
BrDevScripterMenuStep >> prepareSteppedLayoutAnalyzerFor: aMenuAptitudeClass [
	^ self do
		referenceSender;
		label: 'Prepare stepped layout analyser';
		block: [ :aButton :aUserData | 
			self
				ifAnchorElement: aButton
				hasMenuAptitudeOfClass: aMenuAptitudeClass
				do: [ :aMenuAptitude | 
					| anAnalyzer |
					anAnalyzer := BlSteppedLayoutLastStateAnalyzer new.
					anAnalyzer menuContainer: aMenuAptitude menuContainer.
					aMenuAptitude menuContainer layout analyzer: anAnalyzer.
					aUserData at: BlSteppedLayoutLastStateAnalyzer put: anAnalyzer ]
				ifAbsent: [ NotFound signalFor: aMenuAptitudeClass in: aButton ] ]
]

{ #category : #'steps - other' }
BrDevScripterMenuStep >> prepareSteppedLayoutContextMenuAnalyzer [
	^ (self prepareSteppedLayoutAnalyzerFor: BrGlamorousWithExplicitContextMenuAptitude)
		referenceSender
]

{ #category : #'steps - other' }
BrDevScripterMenuStep >> prepareSteppedLayoutDropdownAnalyzer [
	^ (self prepareSteppedLayoutAnalyzerFor: BrWithExplicitDropdownAptitude)
		referenceSender
]

{ #category : #'steps - other' }
BrDevScripterMenuStep >> prepareSteppedLayoutTooltipAnalyzer [
	^ (self prepareSteppedLayoutAnalyzerFor: BrGlamorousWithExplicitTooltipAptitude)
		referenceSender
]

{ #category : #'steps - interactions' }
BrDevScripterMenuStep >> previousMenuItemKeyPress [
	^ self keyPress
		label: 'Press arrow up';
		key: BlKeyboardKey arrowUp;
		referenceSender
]

{ #category : #'steps - other' }
BrDevScripterMenuStep >> storePositionOfElementWithId: anElementId [
	^ self do 
		referenceSender;
		onParentStepTarget: self;
		label: ('Store popover element position: {1}' format: { anElementId });
		block: [ :anElement :aUserData | aUserData at: { #elementPosition. anElementId } put: anElement position ];
		// anElementId
]
