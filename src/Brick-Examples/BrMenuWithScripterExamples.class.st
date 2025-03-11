Class {
	#name : #BrMenuWithScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Brick-Examples-Menu'
}

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> buttonWithDropdown [
	<gtExample>
	^ BrFrame new
		matchParent;
		addChild: (BlElement new
			size: 10@10;
			id: #'outside-click';
			background: (Color lightGray alpha: 0.5);
			constraintsDo: [ :c | 
					c margin: (BlInsets all: 10).
					c frame horizontal alignLeft.
					c frame vertical alignTop ]);
		addChild: (BrButton new
				aptitude: BrGlamorousButtonWithLabelAptitude;
				label: 'Dropdown';
				constraintsDo: [ :c | 
					c margin: (BlInsets all: 10).
					c frame horizontal alignCenter.
					c frame vertical alignCenter ];
				addAptitude: (BrGlamorousWithExplicitDropdownAptitude new
						handle: [ BrButton new
								id: #'menu-dropdown-handle';
								aptitude: BrGlamorousButtonWithLabelAptitude - BrGlamorousButtonExteriorAptitude;
								label: 'Dropdown' ]
						submenu: BrMenuExamples new menuItems))
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> clickButtonWithDropdown [
	<gtExample>
	| aScripter |
	aScripter := self displayButtonWithDropdown.

	aScripter click
		label: 'Open dropdown';
		/ BrButton;
		play.
		
	aScripter assert
		label: 'Assert dropdown is opened';
		exists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> clickDropdownHandle [
	<gtExample>
	| aScripter |
	aScripter := self clickButtonWithDropdown.

	aScripter click
		label: 'Click dropdown handle';
		onSpaceRoot;
		// BrMenuSteppedElement;
		onChildAt: 1;
		play.

	aScripter assert
		label: 'Assert dropdown is closed';
		notExists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.

	aScripter assert
		label: 'Assert empty dropdown aptitude caches';
		do: [ :aButton | 
			aButton aptitude
				findActor: BrGlamorousWithExplicitDropdownAptitude
				ifFound: [ :anAptitude | 
					self
						assert: anAptitude menuContainer elementCache isEmpty
						description: [ 'Menu container cache must be empty: {1}'
								format: {anAptitude menuContainer elementCache} ] ]
				ifNone: [ AssertionFailure signal: 'Dropdown aptitude must exist' ] ];
		/ BrButton;
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> clickDropdownInDropdownHandle [
	<gtExample>
	| aScripter |
	aScripter := self clickElementWithDropdownInDropdown.

	aScripter click
		label: 'Click dropdown handle';
		onSpaceRoot;
		// #'menu-in-submenu-handle';
		play.

	aScripter assert
		label: 'Assert dropdown handle does not exist';
		notExists;
		onSpaceRoot;
		// #'menu-in-submenu-handle';
		play.

	aScripter assert
		label: 'Assert one dropdown is opened';
		value: [ :aRootElement | (aRootElement query // BrMenuSteppedElement) result size ]
			equals: 1;
		onSpaceRoot;
		play.

	aScripter assert
		label: 'Assert complex submenu is opened';
		exists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		// #'menu-in-submenu';
		play.

	aScripter assert
		label: 'Assert dropdown has no other submenus';
		value: [ :aButton | 
				aButton aptitude
					findActor: BrGlamorousWithExplicitDropdownAptitude
					ifFound: [ :anAptitude | anAptitude submenus size ]
					ifNone: [ -1 ] ]
			equals: 0;
		/ BrButton;
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> clickElementWithDropdownInDropdown [
	<gtExample>
	| aScripter |
	aScripter := self hoverComplexSubmenu.

	aScripter click
		label: 'Display dropdown-in-dropdown';
		onSpaceRoot;
		// BrMenuSteppedElement;
		// #'menu-in-submenu';
		play.

	aScripter assert
		label: 'Assert two dropdowns are opened';
		value: [ :aRootElement | (aRootElement query // BrMenuSteppedElement) result size ]
			equals: 2;
		onSpaceRoot;
		play.
		
	aScripter assert
		label: 'Assert dropdown has one submenu';
		value: [ :aButton | 
				aButton aptitude
					findActor: BrGlamorousWithExplicitDropdownAptitude
					ifFound: [ :anAptitude | anAptitude submenus size ]
					ifNone: [ -1 ] ]
			equals: 1;
		/ BrButton;
		play.

	^ aScripter
]

{ #category : #'examples - scripter' }
BrMenuWithScripterExamples >> contextMenuElementWithMenuModel: aMenuModel [
	^ BrFrame new
		exact: 50 @ 50;
		geometry: BlCircleGeometry new;
		background: BrGlamorousColors errorBackgroundColor;
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude menu: aMenuModel)
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> dispatchDropdownShowWishToButtonWithDropdown [
	<gtExample>
	| aScripter |
	aScripter := self displayButtonWithDropdown.

	aScripter do
		label: 'Dispatch dropdown show wish';
		block: [ :aButton | aButton dispatchEvent: (BrDropdownShowWish new anchor: aButton) ];
		/ BrButton;
		play.
		
	aScripter assert
		label: 'Assert dropdown is opened';
		exists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.
		
	aScripter assert
		label: 'Assert dropdown is opened';
		value: [ :aMenuContainer | aMenuContainer childrenCount ] equals: 2;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> displayButtonWithDropdown [
	<gtExample>
	^ self scripterWithElement: [ self buttonWithDropdown ]
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> fireDropdownHideWishFromDropdownInDropdownSubmenuElement [
	<gtExample>
	| aScripter |
	aScripter := self clickElementWithDropdownInDropdown.

	aScripter do
		label: 'Fire dropdown hide wish event';
		block: [ :anElement | anElement fireEvent: BrDropdownHideWish new ];
		onSpaceRoot;
		// #'menu-in-submenu-handle';
		play.

	aScripter assert
		label: 'Assert one dropdown is opened';
		value: [ :aRootElement | (aRootElement query // BrMenuSteppedElement) result size ]
			equals: 1;
		onSpaceRoot;
		play.
		
	aScripter assert
		label: 'Assert dropdown has cached menu elements';
		value: [ :aButton | 
				aButton aptitude
					findActor: BrGlamorousWithExplicitDropdownAptitude
					ifFound: [ :anAptitude | anAptitude menuContainer elementCache size ]
					ifNone: [ -1 ] ]
			equals: 3;
		/ BrButton;
		play.
		
	aScripter assert
		label: 'Assert menu-in-submenu dropdown has zero (cached) submenus';
		value: [ :aButton | 
				aButton aptitude
					findActor: BrGlamorousWithExplicitDropdownAptitude
					ifFound: [ :anAptitude | anAptitude submenus size ]
					ifNone: [ -1 ] ]
			equals: 0;
		onSpaceRoot;
		// #'menu-in-submenu';
		play.
		
	aScripter assert
		label: 'Assert menu-in-submenu dropdown has zero cached menu elements';
		value: [ :aButton | 
				aButton aptitude
					findActor: BrGlamorousWithExplicitDropdownAptitude
					ifFound: [ :anAptitude | anAptitude menuContainer elementCache size ]
					ifNone: [ -1 ] ]
			equals: 0;
		onSpaceRoot;
		// #'menu-in-submenu';
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> fireDropdownHideWishFromSubmenuElement [
	<gtExample>
	| aScripter |
	aScripter := self hoverComplexSubmenu.

	aScripter do
		label: 'Fire dropdown hide wish event';
		block: [ :anElement | anElement fireEvent: BrDropdownHideWish new ];
		onSpaceRoot;
		// BrMenuSteppedElement;
		// #'menu-in-outside-click';
		play.

	aScripter assert
		label: 'Assert all dropdowns are closed';
		value: [ :aRootElement | (aRootElement query // BrMenuSteppedElement) result size ]
			equals: 0;
		onSpaceRoot;
		play.
		
	aScripter assert
		label: 'Assert dropdown has zero cached menu elements';
		value: [ :aButton | 
				aButton aptitude
					findActor: BrGlamorousWithExplicitDropdownAptitude
					ifFound: [ :anAptitude | anAptitude menuContainer elementCache size ]
					ifNone: [ -1 ] ]
			equals: 0;
		/ BrButton;
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> hoverComplexSubmenu [
	<gtExample>
	| aScripter |
	aScripter := self clickButtonWithDropdown.

	aScripter mouseMoveOver
		label: 'Display submenu';
		onSpaceRoot;
		// BrMenuSteppedElement;
		// #'menu-complex-submenu';
		play.

	aScripter assert
		label: 'Assert dropdown is opened';
		exists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> hoverPasteItemKeepingTheSecondDropdownOpened [
	<gtExample>
	| aScripter |
	aScripter := self clickElementWithDropdownInDropdown.

	aScripter mouseMoveOver
		label: 'Move mouse to Paste menu item';
		onSpaceRoot;
		// #'menu-paste-item';
		play.

	aScripter assert
		label: 'Assert dropdown handle does not exist';
		notExists;
		onSpaceRoot;
		// #'menu-in-submenu-handle';
		play.

	aScripter assert
		label: 'Assert one dropdown is opened';
		value: [ :aRootElement | (aRootElement query // BrMenuSteppedElement) result size ]
			equals: 1;
		onSpaceRoot;
		play.

	aScripter assert
		label: 'Assert dropdown has one (cached) submenu';
		value: [ :aButton | 
				aButton aptitude
					findActor: BrGlamorousWithExplicitDropdownAptitude
					ifFound: [ :anAptitude | anAptitude submenus size ]
					ifNone: [ -1 ] ]
			equals: 1;
		/ BrButton;
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> hoverPasteItemKeepingTheSecondDropdownOpened_clickOutside [
	<gtExample>
	| aScripter |
	aScripter := self hoverPasteItemKeepingTheSecondDropdownOpened.

	aScripter click
		label: 'Move mouse to Paste menu item';
		// #'outside-click';
		play.

	aScripter assert
		label: 'Assert dropdown handle does not exist';
		notExists;
		onSpaceRoot;
		// #'menu-dropdown-handle';
		play.

	aScripter assert
		label: 'Assert all dropdowns are closed';
		value: [ :aRootElement | (aRootElement query // BrMenuSteppedElement) result size ]
			equals: 0;
		onSpaceRoot;
		play.
		
	aScripter assert
		label: 'Assert dropdown has zero cached menu elements';
		value: [ :aButton | 
				aButton aptitude
					findActor: BrGlamorousWithExplicitDropdownAptitude
					ifFound: [ :anAptitude | anAptitude menuContainer elementCache size ]
					ifNone: [ -1 ] ]
			equals: 0;
		/ BrButton;
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> hoverPasteItemKeepingTheSecondDropdownOpened_hoverBackComplexSubmenu [
	<gtExample>
	| aScripter |
	aScripter := self hoverPasteItemKeepingTheSecondDropdownOpened.

	aScripter mouseMoveOver
		label: 'Move mouse to Paste menu item';
		onSpaceRoot;
		// #'menu-complex-submenu';
		play.

	aScripter assert
		label: 'Assert dropdown handle exists';
		exists;
		onSpaceRoot;
		// #'menu-in-submenu-handle';
		play.

	aScripter assert
		label: 'Assert two dropdowns are opened';
		value: [ :aRootElement | (aRootElement query // BrMenuSteppedElement) result size ]
			equals: 2;
		onSpaceRoot;
		play.

	aScripter assert
		label: 'Assert dropdown has one (cached) submenu';
		value: [ :aButton | 
				aButton aptitude
					findActor: BrGlamorousWithExplicitDropdownAptitude
					ifFound: [ :anAptitude | anAptitude submenus size ]
					ifNone: [ -1 ] ]
			equals: 1;
		/ BrButton;
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> hoverPasteItemKeepingTheSecondDropdownOpened_hoverBackComplexSubmenu_clickOutside [
	<gtExample>
	| aScripter |
	aScripter := self hoverPasteItemKeepingTheSecondDropdownOpened_hoverBackComplexSubmenu.

	aScripter click
		label: 'Click outside of all menu elements';
		// #'outside-click';
		play.

	aScripter assert
		label: 'Assert dropdown handle does not exist';
		notExists;
		onSpaceRoot;
		// #'menu-in-submenu-handle';
		play.

	aScripter assert
		label: 'Assert all dropdowns are closed';
		value: [ :aRootElement | (aRootElement query // BrMenuSteppedElement) result size ]
			equals: 0;
		onSpaceRoot;
		play.

	aScripter assert
		label: 'Assert dropdown has zero (cached) submenus';
		value: [ :aButton | 
				aButton aptitude
					findActor: BrGlamorousWithExplicitDropdownAptitude
					ifFound: [ :anAptitude | anAptitude submenus size ]
					ifNone: [ -1 ] ]
			equals: 0;
		/ BrButton;
		play.
		
	aScripter assert
		label: 'Assert dropdown has zero cached menu elements';
		value: [ :aButton | 
				aButton aptitude
					findActor: BrGlamorousWithExplicitDropdownAptitude
					ifFound: [ :anAptitude | anAptitude menuContainer elementCache size ]
					ifNone: [ -1 ] ]
			equals: 0;
		/ BrButton;
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> hoverPasteItemKeepingTheSecondDropdownOpened_hoverBackComplexSubmenu_clickOutsideInnerMenu [
	<gtExample>
	| aScripter |
	aScripter := self hoverPasteItemKeepingTheSecondDropdownOpened_hoverBackComplexSubmenu.

	aScripter click
		label: 'Click outside of inner menu elements';
		onSpaceRoot;
		// #'menu-in-outside-click';
		play.

	aScripter assert
		label: 'Assert dropdown handle does not exist';
		notExists;
		onSpaceRoot;
		// #'menu-in-submenu-handle';
		play.

	aScripter assert
		label: 'Assert one dropdown is closed';
		value: [ :aRootElement | (aRootElement query // BrMenuSteppedElement) result size ]
			equals: 1;
		onSpaceRoot;
		play.

	aScripter assert
		label: 'Assert dropdown has zero (cached) submenus';
		value: [ :aButton | 
				aButton aptitude
					findActor: BrGlamorousWithExplicitDropdownAptitude
					ifFound: [ :anAptitude | anAptitude submenus size ]
					ifNone: [ -1 ] ]
			equals: 0;
		/ BrButton;
		play.
		
	aScripter assert
		label: 'Assert dropdown has some cached menu elements';
		value: [ :aButton | 
				aButton aptitude
					findActor: BrGlamorousWithExplicitDropdownAptitude
					ifFound: [ :anAptitude | anAptitude menuContainer elementCache size ]
					ifNone: [ -1 ] ]
			equals: 3;
		/ BrButton;
		play.
		
	aScripter assert
		label: 'Assert menu-in-submenu dropdown has zero (cached) submenus';
		value: [ :aButton | 
				aButton aptitude
					findActor: BrGlamorousWithExplicitDropdownAptitude
					ifFound: [ :anAptitude | anAptitude submenus size ]
					ifNone: [ -1 ] ]
			equals: 0;
		onSpaceRoot;
		// #'menu-in-submenu';
		play.
		
	aScripter assert
		label: 'Assert menu-in-submenu dropdown has zero cached menu elements';
		value: [ :aButton | 
				aButton aptitude
					findActor: BrGlamorousWithExplicitDropdownAptitude
					ifFound: [ :anAptitude | anAptitude menuContainer elementCache size ]
					ifNone: [ -1 ] ]
			equals: 0;
		onSpaceRoot;
		// #'menu-in-submenu';
		play.

	^ aScripter
]

{ #category : #'examples - updates' }
BrMenuWithScripterExamples >> menuWithUpdatableMenuItems [
	<gtExample>
	| anItem aCounter anAnnouncer aMenuItems aScripter |
	aCounter := 0.
	anAnnouncer := Announcer new.
	anItem := BrMenuActionItem new
			id: #'increase-click';
			icon: BrGlamorousVectorIcons add
				label: 'Increase'
				preview: [ aCounter printString ];
			action: [ aCounter := aCounter + 1.
				anAnnouncer announce: Announcement new ];
			hideOnClick: false;
			updateWhen: Announcement from: anAnnouncer;
			yourself.
	aMenuItems := BrMenuItems new.
	aMenuItems addItem: anItem.

	aScripter := self
			scripterWithModel: [ aMenuItems ]
			element: [ self contextMenuElementWithMenuModel: aMenuItems ].

	self assert: anAnnouncer numberOfSubscriptions equals: 0.

	aScripter secondaryClick
		label: 'Open context menu';
		play.

	self assert: anAnnouncer numberOfSubscriptions equals: 1.

	aScripter click
		label: 'Click increase menu item';
		onSpaceRoot;
		onDropdown: true;
		// #'increase-click';
		play.

	self assert: aCounter equals: 1.
	self assert: anItem labelModel text equals: 'Increase'.
	self assert: anItem labelModel preview equals: '1'.

	aScripter click
		label: 'Click increase menu item';
		onSpaceRoot;
		onDropdown: true;
		// #'increase-click';
		play.

	self assert: aCounter equals: 2.
	self assert: anItem labelModel text equals: 'Increase'.
	self assert: anItem labelModel preview equals: '2'.
	self assert: anAnnouncer numberOfSubscriptions equals: 1.

	aScripter userData at: #counter put: aCounter.
	aScripter userData at: #coutnerAnnouncer put: anAnnouncer.

	^ aScripter
]

{ #category : #'examples - updates' }
BrMenuWithScripterExamples >> menuWithUpdatableMenuItems_closeMenu [
	<gtExample>
	| aCounter anAnnouncer aScripter |
	aScripter := self menuWithUpdatableMenuItems.
	aCounter := aScripter userData at: #counter.
	anAnnouncer := aScripter userData at: #coutnerAnnouncer.

	self assert: anAnnouncer numberOfSubscriptions equals: 1.

	aScripter shortcut
		label: 'Close the context menu';
		combination: BlKeyCombination escape;
		play.

	self assert: anAnnouncer numberOfSubscriptions equals: 0.

	^ aScripter
]

{ #category : #'examples - updates' }
BrMenuWithScripterExamples >> menuWithUpdatableMenuItems_demo [
	<gtExample>
	| aScripter |
	aScripter := self menuWithUpdatableMenuItems.

	^ aScripter elementWithoutParent
]
