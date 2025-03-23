Class {
	#name : #BrMenuWithScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Brick-Examples-Menu'
}

{ #category : #'examples - updates' }
BrMenuWithScripterExamples >> actionElementIsWithoutForegroundAttribute: anActionElement [
	| aSize |
	aSize := anActionElement menuModel labelModel text size.

	^ ((anActionElement query // #'menu--label')
		@ [ :eachLabel | 
			((eachLabel text from: 1 to: aSize)
				hasAttributeSuchThat: [ :anAttribute | anAttribute type = BlTextForegroundAttribute ])
				not ]) isNotEmpty
]

{ #category : #'examples - context menu' }
BrMenuWithScripterExamples >> buttonWithContextMenu [
	<gtExample>
	^ self buttonWithContextMenu: BrMenuExamples new menuItems
]

{ #category : #'examples - context menu' }
BrMenuWithScripterExamples >> buttonWithContextMenu: aMenuStencil [
	<gtExample>
	^ BrFrame new
		matchParent;
		border: (BlBorder paint: (Color black alpha: 0.5) width: 1);
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
				id: #'menu-context-menu-button';
				label: 'Context menu';
				constraintsDo: [ :c | 
					c margin: (BlInsets all: 10).
					c frame horizontal alignCenter.
					c frame vertical alignCenter ];
				addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
						menu: aMenuStencil))
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> buttonWithContextMenuAndTooltip [
	<gtExample>
	| anElement aButton |
	anElement := self buttonWithContextMenu.
	aButton := (anElement query // #'menu-context-menu-button') anyOne.
	aButton
		addAptitude: (BrGlamorousWithExplicitTooltipAptitude
				text: BrMenuExamples new tooltipLongString).

	^ anElement
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> buttonWithDropdown [
	<gtExample>
	^ self buttonWithDropdownMenu: BrMenuExamples new menuItems
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> buttonWithDropdownAndTooltip [
	<gtExample>
	| anElement aButton |
	anElement := self buttonWithDropdown.
	aButton := (anElement query // #'menu-dropdown-button') anyOne.
	aButton
		addAptitude: (BrGlamorousWithExplicitTooltipAptitude
				text: BrMenuExamples new tooltipLongString).

	^ anElement
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> buttonWithDropdownExplicitDecoratedMenu [
	<gtExample>
	^ self buttonWithDropdownMenu: BrMenuExamples new explicitDecoratedMenuWithButtons
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> buttonWithDropdownExplicitMenu [
	<gtExample>
	^ self buttonWithDropdownMenu: BrMenuExamples new explicitMenuWithWithButtons
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> buttonWithDropdownMenu: aMenuStencil [
	<gtExample>
	^ BrFrame new
		matchParent;
		border: (BlBorder paint: (Color black alpha: 0.5) width: 1);
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
				id: #'menu-dropdown-button';
				label: 'Dropdown';
				constraintsDo: [ :c | 
					c margin: (BlInsets all: 10).
					c frame horizontal alignCenter.
					c frame vertical alignCenter ];
				addAptitude: (BrGlamorousWithExplicitDropdownAptitude
						handle: [ BrButton new
								id: #'menu-dropdown-handle';
								aptitude: BrGlamorousButtonWithLabelAptitude - BrGlamorousButtonExteriorAptitude;
								label: 'Dropdown' ]
						menu: aMenuStencil))
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> buttonWithTooltip [
	<gtExample>
	^ self buttonWithTooltipMenu: BrMenuExamples new menuItems
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> buttonWithTooltipKeymap [
	<gtExample>
	^ self
		buttonWithTooltipLabel: BrMenuExamples new tooltipLongString
		shortcut: $o meta shift asString 
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> buttonWithTooltipLabel: aLabelString shortcut: aShortcutString [
	<gtExample>
	^ BrFrame new
		matchParent;
		border: (BlBorder paint: (Color black alpha: 0.5) width: 1);
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
				id: #'menu-tooltip-button';
				label: 'Tooltip';
				constraintsDo: [ :c | 
					c margin: (BlInsets all: 10).
					c frame horizontal alignCenter.
					c frame vertical alignCenter ];
				addAptitude: (BrGlamorousWithExplicitTooltipAptitude
						text: aLabelString shortcut: aShortcutString))
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> buttonWithTooltipLabelItem [
	<gtExample>
	^ self buttonWithTooltipMenu: BrMenuExamples new menuLabelItem
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> buttonWithTooltipLongString [
	<gtExample>
	^ self
		buttonWithTooltipLabel: BrMenuExamples new tooltipLongString
		shortcut: 'F5'
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> buttonWithTooltipMenu: aMenuStencil [
	<gtExample>
	^ BrFrame new
		matchParent;
		border: (BlBorder paint: (Color black alpha: 0.5) width: 1);
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
				id: #'menu-tooltip-button';
				label: 'Tooltip';
				constraintsDo: [ :c | 
					c margin: (BlInsets all: 10).
					c frame horizontal alignCenter.
					c frame vertical alignCenter ];
				addAptitude: (BrGlamorousWithExplicitTooltipAptitude
						menu: aMenuStencil))
]

{ #category : #'examples - context menu' }
BrMenuWithScripterExamples >> clickButtonWithContextMenu [
	<gtExample>
	| aScripter anAnchorElement aClickPosition |
	aScripter := self displayButtonWithContextMenu.

	aScripter menuStep
		openContextMenu;
		/ #'menu-context-menu-button';
		play.
		
	anAnchorElement := (aScripter root query // #'menu-context-menu-button') anyOne.
	self assert: anAnchorElement isNotNil.
	aClickPosition := anAnchorElement bounds inSpace center.
		
	aScripter menuStep
		assertMenuContainerExist;
		assertHandleCenterInSpacePosition: aClickPosition;
		play.

	^ aScripter
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> clickButtonWithContextMenuAndTooltip [
	<gtExample>
	| aScripter |
	aScripter := self hoverButtonWithContextMenuAndTooltip.

	aScripter menuStep
		openContextMenu;
		// #'menu-context-menu-button';
		play.

	aScripter menuStep
		assertMenuContainerExist;
		play.

	^ aScripter
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

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> clickButtonWithDropdownAndTooltip [
	<gtExample>
	| aScripter |
	aScripter := self hoverButtonWithDropdownAndTooltip.

	aScripter menuStep
		openDropdown;
		// #'menu-dropdown-button';
		play.

	aScripter menuStep
		assertMenuContainerExist;
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> clickButtonWithDropdownExplicitDecoratedMenu [
	<gtExample>
	| aScripter |
	aScripter := self displayButtonWithDropdownExplicitDecoratedMenu.

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
BrMenuWithScripterExamples >> clickButtonWithDropdownExplicitMenu [
	<gtExample>
	| aScripter |
	aScripter := self displayButtonWithDropdownExplicitMenu.

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

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> clickPasteMenuItem [
	<gtExample>
	| aScripter |
	aScripter := self clickButtonWithDropdown.

	aScripter mouseMoveOver
		label: 'Hover paste menu item';
		onSpaceRoot;
		// BrMenuSteppedElement;
		// #'menu-paste-item';
		play.

	aScripter assert
		label: 'Assert dropdown is opened';
		exists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.
		
	aScripter click
		label: 'Click paste menu item';
		onSpaceRoot;
		// BrMenuSteppedElement;
		// #'menu-paste-item';
		play.
		
	aScripter assert
		label: 'Assert dropdown is closed';
		notExists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.

	^ aScripter
]

{ #category : #'examples - show and hide wish' }
BrMenuWithScripterExamples >> clickTabGroupWithButtonDropdownMenu [
	<gtExample>
	| aScripter |
	aScripter := self displayTabGroupWithButtonDropdownMenu.

	aScripter menuStep
		openDropdownWithId: #'menu-dropdown-button';
		assertMenuContainerExist: 1;
		play.

	^ aScripter
]

{ #category : #'examples - show and hide wish' }
BrMenuWithScripterExamples >> clickTabGroupWithButtonDropdownMenu_clickItemFour [
	"In this case clicking on the menu item, the tab `Two` is selected
	and anchor dispatches dropdown-hide-wish. The menu therefore should not open again
	once the tab `One` is selected."

	<gtExample>
	| aScripter aMenuItemId anAnchorElement |
	aScripter := self clickTabGroupWithButtonDropdownMenu.

	aMenuItemId := #'menu-item-four'.
	anAnchorElement := (aScripter root query // #'menu-dropdown-button') anyOne.
	self assert: anAnchorElement isNotNil.

	aScripter menuStep
		hoverMenuItemWithId: aMenuItemId;
		assertMenuContainerExist: 1;
		clickMenuItemWithId: aMenuItemId;
		assertClosedMenuContainer;
		assertPermanentlyHiddenDropdownInElement: anAnchorElement;
		assertDropdownContainerHasEmptyElementCacheInElement: anAnchorElement;
		onMenuContainer;
		play.

	^ aScripter
]

{ #category : #'examples - show and hide wish' }
BrMenuWithScripterExamples >> clickTabGroupWithButtonDropdownMenu_clickItemFour_switchBackToTabOne [
	<gtExample>
	| aScripter |
	aScripter := self clickTabGroupWithButtonDropdownMenu_clickItemFour.

	aScripter click
		label: 'Switch back to tab one';
		// #'tab-one';
		play.

	aScripter menuStep
		assertClosedMenuContainer;
		onMenuContainer;
		play.

	^ aScripter
]

{ #category : #'examples - show and hide wish' }
BrMenuWithScripterExamples >> clickTabGroupWithButtonDropdownMenu_clickItemOne [
	"In this case clicking on the menu item, the tab `Two` is selected
	and menu item explicitly set do-not-hide-on-click property. 
	The menu therefore should open again once the tab `One` is selected."

	<gtExample>
	| aScripter aMenuItemId anAnchorElement |
	aScripter := self clickTabGroupWithButtonDropdownMenu.

	aMenuItemId := #'menu-item-one'.
	anAnchorElement := (aScripter root query // #'menu-dropdown-button') anyOne.
	self assert: anAnchorElement isNotNil.

	aScripter menuStep
		hoverMenuItemWithId: aMenuItemId;
		assertMenuContainerExist: 1;
		clickMenuItemWithId: aMenuItemId;
		assertClosedMenuContainer;
		assertTemporarilyHiddenDropdownInElement: anAnchorElement;
		assertDropdownElementCacheSize: 2 inElement: anAnchorElement;
		onMenuContainer;
		play.

	^ aScripter
]

{ #category : #'examples - show and hide wish' }
BrMenuWithScripterExamples >> clickTabGroupWithButtonDropdownMenu_clickItemOne_switchBackToTabOne [
	<gtExample>
	| aScripter |
	aScripter := self clickTabGroupWithButtonDropdownMenu_clickItemOne.

	aScripter click
		label: 'Switch back to tab one';
		// #'tab-one';
		play.

	aScripter menuStep
		assertMenuContainerExist: 1;
		onMenuContainer;
		play.

	^ aScripter
]

{ #category : #'examples - show and hide wish' }
BrMenuWithScripterExamples >> clickTabGroupWithButtonDropdownMenu_clickItemThree [
	"In this case clicking on the menu item, the tab `Two` is selected
	and menu item element fires dropdown-hide-wish. The menu therefore should not open again
	once the tab `One` is selected."

	<gtExample>
	| aScripter aMenuItemId anAnchorElement |
	aScripter := self clickTabGroupWithButtonDropdownMenu.

	aMenuItemId := #'menu-item-three'.
	anAnchorElement := (aScripter root query // #'menu-dropdown-button') anyOne.
	self assert: anAnchorElement isNotNil.

	aScripter menuStep
		hoverMenuItemWithId: aMenuItemId;
		assertMenuContainerExist: 1;
		clickMenuItemWithId: aMenuItemId;
		assertClosedMenuContainer;
		assertPermanentlyHiddenDropdownInElement: anAnchorElement;
		assertDropdownContainerHasEmptyElementCacheInElement: anAnchorElement;
		onMenuContainer;
		play.

	^ aScripter
]

{ #category : #'examples - show and hide wish' }
BrMenuWithScripterExamples >> clickTabGroupWithButtonDropdownMenu_clickItemThree_switchBackToTabOne [
	<gtExample>
	| aScripter |
	aScripter := self clickTabGroupWithButtonDropdownMenu_clickItemThree.

	aScripter click
		label: 'Switch back to tab one';
		// #'tab-one';
		play.

	aScripter menuStep
		assertClosedMenuContainer;
		onMenuContainer;
		play.

	^ aScripter
]

{ #category : #'examples - show and hide wish' }
BrMenuWithScripterExamples >> clickTabGroupWithButtonDropdownMenu_clickItemTwo [
	"In this case clicking on the menu item, the tab `Two` is selected
	and menu item calls hide-all. The menu therefore should not open again
	once the tab `One` is selected."

	<gtExample>
	| aScripter aMenuItemId anAnchorElement |
	aScripter := self clickTabGroupWithButtonDropdownMenu.

	aMenuItemId := #'menu-item-two'.
	anAnchorElement := (aScripter root query // #'menu-dropdown-button') anyOne.
	self assert: anAnchorElement isNotNil.

	aScripter menuStep
		hoverMenuItemWithId: aMenuItemId;
		assertMenuContainerExist: 1;
		clickMenuItemWithId: aMenuItemId;
		assertClosedMenuContainer;
		assertPermanentlyHiddenDropdownInElement: anAnchorElement;
		assertDropdownContainerHasEmptyElementCacheInElement: anAnchorElement;
		onMenuContainer;
		play.

	^ aScripter
]

{ #category : #'examples - show and hide wish' }
BrMenuWithScripterExamples >> clickTabGroupWithButtonDropdownMenu_clickItemTwo_switchBackToTabOne [
	<gtExample>
	| aScripter |
	aScripter := self clickTabGroupWithButtonDropdownMenu_clickItemTwo.

	aScripter click
		label: 'Switch back to tab one';
		// #'tab-one';
		play.

	aScripter menuStep
		assertClosedMenuContainer;
		onMenuContainer;
		play.

	^ aScripter
]

{ #category : #'examples - show and hide wish' }
BrMenuWithScripterExamples >> clickTabGroupWithButtonDropdownMenu_switchToTabTwo [
	"In this case clicking on the tab `Two`, the menu is closed and should not open again
	once the tab `One` is selected."

	<gtExample>
	| aScripter anAnchorElement |
	aScripter := self clickTabGroupWithButtonDropdownMenu.

	anAnchorElement := (aScripter root query // #'menu-dropdown-button') anyOne.
	self assert: anAnchorElement isNotNil.

	aScripter click
		label: 'Switch back to tab one';
		// #'tab-two';
		play.

	aScripter menuStep
		assertClosedMenuContainer;
		assertPermanentlyHiddenDropdownInElement: anAnchorElement;
		assertDropdownContainerHasEmptyElementCacheInElement: anAnchorElement;
		onMenuContainer;
		play.

	^ aScripter
]

{ #category : #'examples - show and hide wish' }
BrMenuWithScripterExamples >> clickTabGroupWithButtonDropdownMenu_switchToTabTwo_switchBackToTabOne [
	<gtExample>
	| aScripter |
	aScripter := self clickTabGroupWithButtonDropdownMenu_switchToTabTwo.

	aScripter click
		label: 'Switch back to tab one';
		// #'tab-one';
		play.

	aScripter menuStep
		assertClosedMenuContainer;
		onMenuContainer;
		play.

	^ aScripter
]

{ #category : #'examples - transformation' }
BrMenuWithScripterExamples >> clickTransformedContainerWithContextMenu [
	<gtExample>
	| aScripter anAnchorElement anAnchorCenterPosition anEventPosition |
	aScripter := self displayTransformedContainerWithContextMenu.

	aScripter menuStep prepareSteppedLayoutContextMenuAnalyzer
		// #'menu-anchor';
		play.

	aScripter menuStep
		openContextMenu;
		// #'menu-anchor';
		play.

	anAnchorElement := (aScripter root query // #'menu-anchor') anyOne.
	self assert: anAnchorElement isNotNil.
	anAnchorCenterPosition := anAnchorElement space root
			localPointToMine: anAnchorElement bounds center
			fromChild: anAnchorElement.

	anEventPosition := aScripter events
			detect: [ :each | each isKindOf: BlMouseUpEvent ]
			ifFound: [ :anEvent | anEvent position ]
			ifNone: [ nil ].
			
	self assert: anEventPosition isNotNil.
	self assert: (anAnchorCenterPosition closeTo: anEventPosition precision: 0.0001).
	
	aScripter menuStep
		assertMenuContainerExist;
		flag: 'I am not sure why the position is not more precise. Ideally, we do not need #roundDownTo:.';
		assertHandleCenterInSpacePosition: (anEventPosition roundDownTo: 1);
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

{ #category : #'examples - context menu' }
BrMenuWithScripterExamples >> displayButtonWithContextMenu [
	<gtExample>
	^ self scripterWithElement: [ self buttonWithContextMenu ]
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> displayButtonWithContextMenuAndTooltip [
	<gtExample>
	^ self scripterWithElement: [ self buttonWithContextMenuAndTooltip ]
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> displayButtonWithDropdown [
	<gtExample>
	^ self scripterWithElement: [ self buttonWithDropdown ]
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> displayButtonWithDropdownAndTooltip [
	<gtExample>
	^ self scripterWithElement: [ self buttonWithDropdownAndTooltip ]
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> displayButtonWithDropdownExplicitDecoratedMenu [
	<gtExample>
	^ self scripterWithElement: [ self buttonWithDropdownExplicitDecoratedMenu ]
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> displayButtonWithDropdownExplicitMenu [
	<gtExample>
	^ self scripterWithElement: [ self buttonWithDropdownExplicitMenu ]
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> displayButtonWithTooltip [
	<gtExample>
	^ self scripterWithElement: [ self buttonWithTooltip ]
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> displayButtonWithTooltipKeymap [
	<gtExample>
	^ self scripterWithElement: [ self buttonWithTooltipKeymap ]
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> displayButtonWithTooltipLabelItem [
	<gtExample>
	^ self scripterWithElement: [ self buttonWithTooltipLabelItem ]
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> displayButtonWithTooltipLongString [
	<gtExample>
	^ self scripterWithElement: [ self buttonWithTooltipLongString ]
]

{ #category : #'examples - show and hide wish' }
BrMenuWithScripterExamples >> displayTabGroupWithButtonDropdownMenu [
	<gtExample>
	^ self scripterWithElement: [ self tabGroupWithButtonDropdownMenu ]
]

{ #category : #'examples - transformation' }
BrMenuWithScripterExamples >> displayTransformedContainerWithContextMenu [
	<gtExample>
	^ self scripterWithElement: [ self transformedContainerWithContextMenu ]
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> dragPinnableComplexSubmenu [
	<gtExample>
	| aScripter |
	aScripter := self hoverComplexSubmenu.

	aScripter mouseMoveOver
		label: 'Hover pinnable handle';
		onSpaceRoot;
		// BrMenuSteppedElement;
		// #'menu--pinned-handle';
		play.

	aScripter assert
		label: 'Assert dropdown is opened';
		exists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.
		
	(aScripter mouseDragBy: -300@ -400)
		label: 'Drag pinnable handle';
		onSpaceRoot;
		// BrMenuSteppedElement;
		// #'menu--pinned-handle';
		play.
		
	aScripter assert
		label: 'Assert dropdown is closed';
		notExists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.
		
	aScripter assert
		label: 'Assert dragged menu element exists';
		exists;
		onSpaceRoot;
		// #'menu--pinned-handle';
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> dragPinnableExplicitDecoratedMenu [
	<gtExample>
	| aScripter |
	aScripter := self clickButtonWithDropdownExplicitDecoratedMenu.

	aScripter mouseMoveOver
		label: 'Hover pinnable handle';
		onSpaceRoot;
		// BrMenuSteppedElement;
		// #'menu--pinned-handle';
		play.

	aScripter assert
		label: 'Assert dropdown is opened';
		exists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.
		
	(aScripter mouseDragBy: -200@ 100)
		label: 'Drag pinnable handle';
		onSpaceRoot;
		// BrMenuSteppedElement;
		// #'menu--pinned-handle';
		play.
		
	aScripter assert
		label: 'Assert dropdown is closed';
		notExists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.
		
	aScripter assert
		label: 'Assert dragged menu element exists';
		exists;
		onSpaceRoot;
		// #'menu--pinned-handle';
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> dragPinnableExplicitMenu [
	<gtExample>
	| aScripter |
	aScripter := self clickButtonWithDropdownExplicitMenu.

	aScripter mouseMoveOver
		label: 'Hover pinnable handle';
		onSpaceRoot;
		// BrMenuSteppedElement;
		// #'menu--pinned-handle';
		play.

	aScripter assert
		label: 'Assert dropdown is opened';
		exists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.
		
	(aScripter mouseDragBy: -200@ 100)
		label: 'Drag pinnable handle';
		onSpaceRoot;
		// BrMenuSteppedElement;
		// #'menu--pinned-handle';
		play.
		
	aScripter assert
		label: 'Assert dropdown is closed';
		notExists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.
		
	aScripter assert
		label: 'Assert dragged menu element exists';
		exists;
		onSpaceRoot;
		// #'menu--pinned-handle';
		play.

	^ aScripter
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

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> hoverButtonWithContextMenuAndTooltip [
	<gtExample>
	| aScripter |
	aScripter := self displayButtonWithContextMenuAndTooltip.

	aScripter menuStep
		displayTooltip;
		// #'menu-context-menu-button';
		play.

	aScripter menuStep
		assertMenuContainerExist;
		play.

	^ aScripter
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> hoverButtonWithDropdownAndTooltip [
	<gtExample>
	| aScripter |
	aScripter := self displayButtonWithDropdownAndTooltip.

	aScripter menuStep
		displayTooltip;
		// #'menu-dropdown-button';
		play.

	aScripter menuStep
		assertMenuContainerExist;
		play.

	^ aScripter
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> hoverButtonWithTooltip [
	<gtExample>
	| aScripter |
	aScripter := self displayButtonWithTooltip.

	aScripter mouseMoveOver
		label: 'Hover button with tooltip';
		/ BrButton;
		play.
		
	aScripter assert
		label: 'Assert tooltip is opened';
		exists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.

	^ aScripter
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> hoverButtonWithTooltipKeymap [
	<gtExample>
	| aScripter |
	aScripter := self displayButtonWithTooltipKeymap.

	aScripter menuStep
		displayTooltip;
		/ BrButton;
		play.

	aScripter menuStep
		assertMenuContainerExist;
		play.

	^ aScripter
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> hoverButtonWithTooltipLabelItem [
	"The tooltip label is not fully visible, because the default 
	preferred child width weight is 0.3. It does not fit in this case.
	Users can use BrWithExplicitTooltipAptitude class>>#text: to use the whole window width."

	<gtExample>
	| aScripter aMenuElement aLabelElement aMenuContainer |
	aScripter := self displayButtonWithTooltipLabelItem.

	aScripter mouseMoveOver
		label: 'Hover button with tooltip';
		/ BrButton;
		play.
		
	aScripter assert
		label: 'Assert tooltip is opened';
		exists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.
		
	aMenuElement := (aScripter root query // #'menu-label-item') anyOne.
	aLabelElement := (aScripter root query // #'menu-label-item' // #label) anyOne.
	aMenuContainer := (aScripter root query // BrMenuSteppedElement) anyOne.
	self assert: aMenuElement width < aLabelElement width.
	self assert: aMenuElement width < aMenuContainer width.
	
	^ aScripter
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> hoverButtonWithTooltipLongString [
	"The tooltip label is fully visible, because the preferred child width weight is 1.0. 
	Users can use BrWithExplicitTooltipAptitude class>>#menu: to use default preferred child weight."

	<gtExample>
	| aScripter aMenuElement aLabelElement aMenuContainer |
	aScripter := self displayButtonWithTooltipLongString.

	aScripter mouseMoveOver
		label: 'Hover button with tooltip';
		/ BrButton;
		play.
		
	aScripter assert
		label: 'Assert tooltip is opened';
		exists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.
		
	aMenuElement := (aScripter root query // BrMenuLabelItemElement) anyOne.
	aLabelElement := (aScripter root query // BrMenuLabelItemElement // #label) anyOne.
	aMenuContainer := (aScripter root query // BrMenuSteppedElement) anyOne.
	self assert: aMenuElement width > aLabelElement width.
	self assert: aMenuElement width < aMenuContainer width.

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

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> hoverTooltipMenuPasteItem [
	<gtExample>
	| aScripter |
	aScripter := self hoverButtonWithTooltip.

	aScripter mouseMoveOver
		label: 'Hover button with tooltip';
		onSpaceRoot;
		// #'menu-paste-item';
		play.
		
	aScripter assert
		label: 'Assert tooltip is opened';
		exists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.

	^ aScripter
]

{ #category : #'examples - updates' }
BrMenuWithScripterExamples >> labelElement: aLabel hasForegroundColor: aColor [
	^ ((aLabel query // #'menu--label')
		@ [ :eachLabel | 
			eachLabel text
				hasAttributeSuchThat: [ :anAttribute | 
					anAttribute class = BlTextForegroundAttribute
						and: [ anAttribute paint = aColor ] ] ])
		isNotEmpty
]

{ #category : #'examples - updates' }
BrMenuWithScripterExamples >> labelElement: aLabel hasNotForegroundColor: aColor [
	^ ((aLabel query // #'menu--label')
		@ [ :eachLabel | 
			(eachLabel text
				hasAttributeSuchThat: [ :anAttribute | 
					anAttribute type = BlTextForegroundAttribute
						and: [ anAttribute paint = aColor ] ]) not ])
		isNotEmpty
]

{ #category : #'examples - updates' }
BrMenuWithScripterExamples >> labelElementIsWithoutForegroundAttribute: aLabel [
	^ ((aLabel query // #'menu--label')
		@ [ :eachLabel | 
			(eachLabel text
				hasAttributeSuchThat: [ :anAttribute | 
					anAttribute type = BlTextForegroundAttribute ]) not ])
		isNotEmpty
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> leaveButtonWithTooltip [
	<gtExample>
	| aScripter |
	aScripter := self hoverButtonWithTooltip.

	aScripter mouseMoveOver
		label: 'Move mouse outside of the button with tooltip';
		/ #'outside-click';
		play.
		
	aScripter assert
		label: 'Assert tooltip is closed';
		notExists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.

	^ aScripter
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> leaveButtonWithTooltipLabelItem [
	<gtExample>
	| aScripter |
	aScripter := self hoverButtonWithTooltipLabelItem.

	aScripter mouseMoveOver
		label: 'Move mouse outside of the button with tooltip';
		/ #'outside-click';
		play.
		
	aScripter assert
		label: 'Assert tooltip is closed';
		notExists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.

	^ aScripter
]

{ #category : #'examples - tooltip' }
BrMenuWithScripterExamples >> leaveTooltipMenuPasteItem [
	<gtExample>
	| aScripter |
	aScripter := self hoverTooltipMenuPasteItem.

	aScripter mouseMoveOver
		label: 'Move mouse outside of the button with tooltip';
		/ #'outside-click';
		play.
		
	aScripter assert
		label: 'Assert tooltip is closed';
		notExists;
		onSpaceRoot;
		// BrMenuSteppedElement;
		play.

	^ aScripter
]

{ #category : #'examples - updates' }
BrMenuWithScripterExamples >> menuWithUpdatableMenuItems [
	<gtExample>
	| anActionItem aCounter anAnnouncer aMenuItems aScripter aLabelItem |
	aCounter := 0.
	anAnnouncer := Announcer new.
	anActionItem := BrMenuActionItem new
			id: #'increase-click';
			icon: BrGlamorousVectorIcons add
				label: 'Increase'
				preview: [ aCounter printString ];
			action: [ aCounter := aCounter + 1.
				anAnnouncer announce: Announcement new ];
			hideOnClick: false;
			updateWhen: Announcement from: anAnnouncer;
			disableIf: [ :aMenuItem | aCounter >= 2 ];
			yourself.
	aLabelItem := BrMenuLabelItem new
			label: [ 'Counter value is {1}.' format: {aCounter} ];
			updateWhen: Announcement from: anAnnouncer;
			disableIf: [ :aMenuItem | aCounter even ];
			yourself.
	aMenuItems := BrMenuItems new.
	aMenuItems addItem: anActionItem.
	aMenuItems addItem: aLabelItem.

	aScripter := self
			scripterWithModel: [ aMenuItems ]
			element: [ self contextMenuElementWithMenuModel: aMenuItems ].

	self assert: anAnnouncer numberOfSubscriptions equals: 0.

	aScripter secondaryClick
		label: 'Open context menu';
		play.

	self assert: anAnnouncer numberOfSubscriptions equals: 2.

	aScripter assert
		label: 'Action item is enabled on 0';
		satisfies: [ :aLabel | aLabel isEnabled and: [ self actionElementIsWithoutForegroundAttribute: aLabel ] ];
		onSpaceRoot;
		onDropdown: true;
		// #'increase-click';
		play.

	aScripter assert
		label: 'Label item is disabled on 0';
		satisfies: [ :aLabel | 
			aLabel isDisabled
				and: [ self
						labelElement: aLabel
						hasForegroundColor: aLabel theme button disabledTextColor ] ];
		onSpaceRoot;
		onDropdown: true;
		// BrMenuLabelItemElement;
		play.

	aScripter click
		label: 'Click increase menu item';
		onSpaceRoot;
		onDropdown: true;
		// #'increase-click';
		play.

	self assert: aCounter equals: 1.
	self assert: anActionItem labelModel text equals: 'Increase'.
	self assert: anActionItem labelModel preview equals: '1'.
	self assert: aLabelItem labelModel text equals: 'Counter value is 1.'.

	aScripter assert
		label: 'Label item is enabled on 1';
		satisfies: [ :aLabel | aLabel isEnabled and: [ self labelElementIsWithoutForegroundAttribute: aLabel ] ];
		onSpaceRoot;
		onDropdown: true;
		// BrMenuLabelItemElement;
		play.
		
	aScripter assert
		label: 'Action item is enabled on 1';
		satisfies: [ :aLabel | aLabel isEnabled and: [ self actionElementIsWithoutForegroundAttribute: aLabel ] ];
		onSpaceRoot;
		onDropdown: true;
		// #'increase-click';
		play.

	aScripter click
		label: 'Click increase menu item';
		onSpaceRoot;
		onDropdown: true;
		// #'increase-click';
		play.

	self assert: aCounter equals: 2.
	self assert: anActionItem labelModel text equals: 'Increase'.
	self assert: anActionItem labelModel preview equals: '2'.
	self assert: aLabelItem labelModel text equals: 'Counter value is 2.'.
	self assert: anAnnouncer numberOfSubscriptions equals: 2.

	aScripter assert
		label: 'Label item is disabled on 2';
		satisfies: [ :aLabel | 
			aLabel isDisabled
				and: [ self
						labelElement: aLabel
						hasForegroundColor: aLabel theme button disabledTextColor ] ];
		onSpaceRoot;
		onDropdown: true;
		// BrMenuLabelItemElement;
		play.
	
	aScripter assert
		label: 'Action item is disabled on 2';
		satisfies: [ :aLabel | 
			aLabel isDisabled
				and: [ self
						labelElement: aLabel
						hasForegroundColor: aLabel theme button disabledTextColor ] ];
		onSpaceRoot;
		onDropdown: true;
		// #'increase-click';
		play.

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

	self assert: anAnnouncer numberOfSubscriptions equals: 2.

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

{ #category : #'examples - show and hide wish' }
BrMenuWithScripterExamples >> tabGroupWithButtonDropdownMenu [
	"I exemplify the cases of switching to another tab from a context menu.
	As a consequence the dropdown anchor element is removed from a space
	and therefore the dropdown temporarily hidden.
	See https://github.com/feenkcom/gtoolkit/issues/4375"

	<gtExample>
	| aTabOne aTabTwo |
	aTabOne := BrTab new
			id: #'tab-one';
			aptitude: BrGlamorousTabAptitude new;
			label: 'One';
			stencil: [ | aMenuItems aMenuItem |
				aMenuItems := BrMenuItems new.
				aMenuItem := BrMenuActionItem new
						id: #'menu-item-one';
						label: 'Switch to tab two (no-hide)';
						hideOnClick: false;
						action: [ :anElement |
							(anElement space root query // #'tab-two') anyOne select ];
						yourself.
				aMenuItems addItem: aMenuItem.
				aMenuItem := BrMenuActionItem new
						id: #'menu-item-two';
						label: 'Switch to tab two (hide)';
						hideOnClick: true;
						action: [ :anElement | 
							(anElement space root query // #'tab-two') anyOne select ];
						yourself.
				aMenuItems addItem: aMenuItem.
				aMenuItem := BrMenuActionItem new
						id: #'menu-item-three';
						label: 'Switch to tab two (fire hide wish)';
						hideOnClick: false;
						action: [ :anElement | 
							(anElement space root query // #'tab-two') anyOne select.
							anElement fireEvent: BrDropdownHideWish new ];
						yourself.
				aMenuItems addItem: aMenuItem.
				aMenuItem := BrMenuActionItem new
						id: #'menu-item-four';
						label: 'Switch to tab two (dispatch hide wish)';
						hideOnClick: false;
						action: [ :anElement | 
							| aWish |
							aWish := BrMenuAnchorElementWish new.
							anElement fireEvent: aWish.
							(anElement space root query // #'tab-two') anyOne select.
							aWish anchorElementDo: [ :anAnchorElement | 
								anAnchorElement dispatchEvent: (BrDropdownHideWish new 
									anchor: anAnchorElement) ] ];
						yourself.
				aMenuItems addItem: aMenuItem.

				BrFrame new
					matchParent;
					border: (BlBorder paint: (Color black alpha: 0.5) width: 1);
					addChild: (BlElement new
							size: 10 @ 10;
							id: #'outside-click';
							background: (Color lightGray alpha: 0.5);
							constraintsDo: [ :c | 
								c margin: (BlInsets all: 10).
								c frame horizontal alignLeft.
								c frame vertical alignTop ]);
					addChild: (BrButton new
							aptitude: BrGlamorousButtonWithLabelAptitude;
							id: #'menu-dropdown-button';
							label: 'Dropdown';
							constraintsDo: [ :c | 
								c margin: (BlInsets all: 10).
								c frame horizontal alignCenter.
								c frame vertical alignCenter ];
							addAptitude: (BrGlamorousWithExplicitDropdownAptitude
									handle: [ BrButton new
											id: #'menu-dropdown-handle';
											aptitude: BrGlamorousButtonWithLabelAptitude - BrGlamorousButtonExteriorAptitude;
											label: 'Dropdown' ]
									menu: aMenuItems)) ].
	aTabTwo := BrTab new
			id: #'tab-two';
			aptitude: BrGlamorousTabAptitude new;
			label: 'Two';
			stencil: [ BrFrame new
					matchParent;
					background: Color paleGreen ].
	^ BrTabGroup new
		matchParent;
		aptitude: BrGlamorousTabGroupAptitude new;
		addTab: aTabOne;
		addTab: aTabTwo
]

{ #category : #'examples - dropdown' }
BrMenuWithScripterExamples >> tabGroupWithButtonDropdownMenu: aMenuStencil [
	<gtExample>
	^ BrTabGroup new
		matchParent;
		aptitude: BrGlamorousTabGroupAptitude new;
		addTab: (BrTab new
				aptitude: BrGlamorousTabAptitude new;
				label: 'One';
				stencil: [ BrFrame new
						matchParent;
						border: (BlBorder paint: (Color black alpha: 0.5) width: 1);
						addChild: (BlElement new
								size: 10 @ 10;
								id: #'outside-click';
								background: (Color lightGray alpha: 0.5);
								constraintsDo: [ :c | 
									c margin: (BlInsets all: 10).
									c frame horizontal alignLeft.
									c frame vertical alignTop ]);
						addChild: (BrButton new
								aptitude: BrGlamorousButtonWithLabelAptitude;
								id: #'menu-dropdown-button';
								label: 'Dropdown';
								constraintsDo: [ :c | 
									c margin: (BlInsets all: 10).
									c frame horizontal alignCenter.
									c frame vertical alignCenter ];
								addAptitude: (BrGlamorousWithExplicitDropdownAptitude
										handle: [ BrButton new
												id: #'menu-dropdown-handle';
												aptitude: BrGlamorousButtonWithLabelAptitude - BrGlamorousButtonExteriorAptitude;
												label: 'Dropdown' ]
										menu: aMenuStencil)) ]);
		addTab: (BrTab new
				aptitude: BrGlamorousTabAptitude new;
				label: 'Two';
				stencil: [ BrFrame new
						matchParent;
						background: Color paleGreen ])
]

{ #category : #'examples - transformation' }
BrMenuWithScripterExamples >> transformedContainerWithContextMenu [
	"Original example: BrAnchoredExamples>>#contextMenu"
	<gtExample>
	
	| handleSize handle content container anchor anchorContainer |
	handleSize := 8 @ 8.
	handle := [ BlElement new
		id: #'menu-handle';
		size: handleSize;
		yourself ] asStencil.
	content := [ (BrLabel new
		id: #'menu-content';
		aptitude:
			(BrGlamorousLabelAptitude new
				glamorousRegularFontAndSize;
				yourself);
		padding: (BlInsets all: handleSize x);
		text: 'look at me!';
		yourself) asScrollableElement
		alignCenter;
		yourself ] asStencil.
	container := BlElement new
		background: Color gray muchLighter;
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		transformDo: [ :t | 
			t
				origin: BlAffineTransformationTopLeftOrigin new;
				rotateBy: 30;
				translateBy: 400 @ 100;
				scaleBy: 0.5 ];
		yourself.
	anchor := BlElement new
		id: #'menu-anchor';
		aptitude: (BrGlamorousWithExplicitContextMenuAptitude handle: handle content: content);
		background: Color red;
		size: 40 @ 80;
		addEventHandler: BlPullHandler new;
		yourself.
	anchorContainer := BlElement new
		background: Color red muchLighter;
		relocate: 200 @ 250;
		size: 400 @ 200;
		constraintsDo: [ :c | c ignoreByLayout ];
		clipChildren: false;
		addChild: anchor;
		yourself.
	^ container
		addChild: anchorContainer;
		yourself
]
