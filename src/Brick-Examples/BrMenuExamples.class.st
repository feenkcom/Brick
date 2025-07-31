Class {
	#name : #BrMenuExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Menu'
}

{ #category : #asserting }
BrMenuExamples >> assertGlamorousElementForMenuModel: aMenu [
	| anElement |
	anElement := self visitMenuModel: aMenu.

	self assert: (anElement isKindOf: BlElement)
]

{ #category : #'examples - action item' }
BrMenuExamples >> basicMenuActionItem [
	<gtExample>
	<return: #BrMenuActionItem>
	| anItem |
	anItem := BrMenuActionItem new.

	self assert: anItem hideOnClick.

	^ anItem
]

{ #category : #'examples - explicit item' }
BrMenuExamples >> basicMenuExplicitItem [
	<gtExample>
	<return: #BrMenuExplicitItem>
	| anItem |
	anItem := BrMenuExplicitItem new.



	^ anItem
]

{ #category : #'examples - label item' }
BrMenuExamples >> basicMenuLabelItem [
	<gtExample>
	<return: #BrMenuLabelItem>
	| anItem |
	anItem := BrMenuLabelItem new.

	^ anItem
]

{ #category : #'examples - submenu' }
BrMenuExamples >> explicitDecoratedMenuWithButtons [
	<gtExample>
	<return: #BrMenuDecoratoringModel>
	| aMenuModel aDecoratedMenu |
	aMenuModel := self explicitMenuWithWithButtons.
	aDecoratedMenu := BrMenuDecoratoringModel new.
	aDecoratedMenu
		menuModel: aMenuModel;
		decorator: [ :theOriginalElement | theOriginalElement userData at: BrMenuDecoratoringModel put: aDecoratedMenu ].

	self assert: aDecoratedMenu menuModel equals: aMenuModel.
	self assert: aDecoratedMenu decorator isNotNil.
	self assert: aMenuModel parent equals: aDecoratedMenu.
	self assertGlamorousElementForMenuModel: aDecoratedMenu.

	^ aDecoratedMenu
]

{ #category : #'examples - submenu' }
BrMenuExamples >> explicitMenu [
	<gtExample>
	<return: #BrMenuExplicit>
	| aMenu |
	aMenu := BrMenuExplicit new.
	aMenu
		stencil: [ BlElement new
				size: 150 @ 100;
				addAptitude: (BrGlamorousPopoverPinnableAptitude new
						menuModel: aMenu;
						withResizers;
						withAllPinActions);
				addAptitude: BrPopoverCommonAptitude new;
				background: Color paleBlue ].

	self assert: aMenu stencil isNotNil.
	self assertGlamorousElementForMenuModel: aMenu.

	^ aMenu
]

{ #category : #'examples - submenu' }
BrMenuExamples >> explicitMenuInSeparateCompositionLayer [
	<gtExample>
	<return: #BrMenuExplicit>
	| aMenu |
	aMenu := BrMenuExplicit new.
	aMenu
		stencil: [ BlElement new
				beInSeparateCompositionLayer;
				size: 150 @ 100;
				addAptitude: (BrGlamorousPopoverPinnableAptitude new
						menuModel: aMenu;
						withResizers;
						withAllPinActions);
				addAptitude: BrPopoverCommonAptitude new;
				background: Color paleOrange ].

	self assert: aMenu stencil isNotNil.
	self assertGlamorousElementForMenuModel: aMenu.

	^ aMenu
]

{ #category : #'examples - submenu' }
BrMenuExamples >> explicitMenuInSingleCompositionLayer [
	<gtExample>
	<return: #BrMenuExplicit>
	| aMenu |
	aMenu := BrMenuExplicit new.
	aMenu
		stencil: [ BlElement new
				beInSingleCompositionLayer;
				size: 150 @ 100;
				addAptitude: (BrGlamorousPopoverPinnableAptitude new
						menuModel: aMenu;
						withResizers;
						withAllPinActions);
				addAptitude: BrPopoverCommonAptitude new;
				background: Color paleGreen ].

	self assert: aMenu stencil isNotNil.
	self assertGlamorousElementForMenuModel: aMenu.

	^ aMenu
]

{ #category : #'examples - submenu' }
BrMenuExamples >> explicitMenuWithWithButtons [
	<gtExample>
	<return: #BrMenuExplicit>
	| aMenu |
	aMenu := BrMenuExplicit new.
	aMenu
		stencil: [ BlElement new
				layout: BlFrameLayout new;
				size: 150 @ 100;
				addAptitude: (BrGlamorousPopoverPinnableAptitude new
						menuModel: aMenu;
						withResizers;
						withAllPinActions);
				addAptitude: BrPopoverCommonAptitude new;
				background: Color palePeach;
				addChild: (BlElement new
						size: 10 @ 10;
						id: #'menu-in-outside-click';
						background: (Color lightGray alpha: 0.5);
						constraintsDo: [ :c | 
							c margin: (BlInsets all: 10).
							c frame horizontal alignLeft.
							c frame vertical alignTop ]);
				addChild: (BlElement new
						id: #'menu-in-submenu';
						size: 70 @ 20;
						background: Color palePeach darker;
						constraintsDo: [ :c | 
							c margin: (BlInsets all: 10).
							c frame horizontal alignCenter.
							c frame vertical alignCenter ];
						aptitude: (BrGlamorousWithExplicitDropdownAptitude new
								handle: [ BlElement new
										id: #'menu-in-submenu-handle';
										size: 70 @ 20;
										background: Color palePeach darker ]
								submenu: [ BrMenuItems new
										addItem: self submenuInlineMessageItems;
										addItem: self submenuExtractTemporaryItems ])) ].

	self assert: aMenu stencil isNotNil.
	self assertGlamorousElementForMenuModel: aMenu.

	^ aMenu
]

{ #category : #'examples - action item' }
BrMenuExamples >> menuActionItemWithIconAndLabel [
	<gtExample>
	<return: #BrMenuActionItem>
	| anItem |
	anItem := self basicMenuActionItem.
	anItem icon: BrGlamorousVectorIcons clipboard label: 'Copy'.
	self assert: anItem labelModel isNotNil.
	self assert: anItem labelModel text equals: 'Copy'.
	self assert: anItem labelModel icon isNotNil.

	^ anItem
]

{ #category : #'examples - action item' }
BrMenuExamples >> menuActionItemWithLabel [
	<gtExample>
	<return: #BrMenuActionItem>
	| anItem |
	anItem := self basicMenuActionItem.
	anItem label: 'Copy'.
	self assert: anItem labelModel isNotNil.
	self assert: anItem labelModel text equals: 'Copy'.

	^ anItem
]

{ #category : #'examples - items' }
BrMenuExamples >> menuActionItemWithUpdateSubscription [
	<gtExample>
	<return: #BrMenuItems>
	| anIncreaseItem aCounter anAnnouncer anItemsModel aLabelItem aDecreaseItem |
	aCounter := 0.
	anAnnouncer := Announcer new.
	anItemsModel := BrMenuItems new.
	anIncreaseItem := self basicMenuActionItem.
	anIncreaseItem
		icon: BrGlamorousVectorIcons add
		label: 'Increase'
		preview: [ aCounter printString ].
	anIncreaseItem
		action: [ aCounter := aCounter + 1.
			anAnnouncer announce: Announcement new ].
	anIncreaseItem hideOnClick: false.
	anItemsModel addItem: anIncreaseItem.

	aDecreaseItem := self basicMenuActionItem.
	aDecreaseItem
		icon: BrGlamorousVectorIcons remove
		label: 'Decrease'
		preview: [ aCounter printString ].
	aDecreaseItem
		action: [ aCounter := aCounter - 1.
			anAnnouncer announce: Announcement new ].
	aDecreaseItem hideOnClick: false.
	anItemsModel addItem: aDecreaseItem.

	self assert: anIncreaseItem labelModel isNotNil.
	self assert: anIncreaseItem labelModel text equals: 'Increase'.
	self assert: anIncreaseItem labelModel preview equals: '0'.

	aCounter := aCounter + 1.
	self assert: anIncreaseItem labelModel text equals: 'Increase'.
	self assert: anIncreaseItem labelModel preview equals: '1'.

	anIncreaseItem updateWhen: Announcement from: anAnnouncer.
	aDecreaseItem updateWhen: Announcement from: anAnnouncer.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.

	aLabelItem := self basicMenuLabelItem.
	aLabelItem label: [ 'Counter value is {1}.' format: {aCounter} ].
	aLabelItem updateWhen: Announcement from: anAnnouncer.
	aLabelItem disableIf: [ aCounter odd ].
	anItemsModel addItem: aLabelItem.

	anIncreaseItem disableIf: [ aCounter >= 10 ].
	aDecreaseItem disableIf: [ aCounter <= 0 ].

	self assert: aLabelItem labelModel text equals: 'Counter value is 1.'.
	self assert: anAnnouncer numberOfSubscriptions equals: 0.

	^ anItemsModel
]

{ #category : #'examples - explicit item' }
BrMenuExamples >> menuExplicitItemWithEditor [
	<gtExample>
	<return: #BrMenuExplicitItem>
	| anItem anElement |
	anItem := self basicMenuExplicitItem.

	anItem
		stencil: [ :aMenuItem | 
			BrEditor new
				aptitude: BrGlamorousRegularEditorAptitude;
				background: BrGlamorousColors defaultButtonBackgroundColor;
				geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
				text: ('' asRopedText
						attribute: (BrGhostTextAttribute
								for: ('explicit item with text editor' asRopedText glamorousRegularFontAndSize
										foreground: Color lightGray)));
				hMatchParent;
				vFitContent ].

	anElement := BrGlamorousMenuElementBuilder new visitModel: anItem.
	self assert: (anElement isKindOf: BrEditor).

	^ anItem
]

{ #category : #'examples - label' }
BrMenuExamples >> menuIconTextAndShortcutLabel [
	<gtExample>
	<return: #BrMenuIconTextLabelModel>
	| aLabel |
	aLabel := BrMenuIconTextLabelModel new.
	aLabel text: 'Copy'.
	aLabel shortcut: 'CMD+C'.
	aLabel icon: BrGlamorousVectorIcons clipboard.

	self assert: aLabel text equals: 'Copy'.
	self assert: aLabel shortcut equals: 'CMD+C'.
	self assert: aLabel icon isNotNil.
	self assert: aLabel icon asElement isNotNil.

	^ aLabel
]

{ #category : #'examples - label' }
BrMenuExamples >> menuIconTextLabel [
	<gtExample>
	<return: #BrMenuTextLabelModel>
	| aLabel anElement |
	aLabel := BrMenuIconTextLabelModel new.
	aLabel
		text: 'Copy';
		preview: 'class name';
		shortcut: 'CMD+C';
		icon: BrGlamorousVectorIcons clipboard.

	anElement := BrMenuIconTextLabelElement new.
	anElement labelModel: aLabel.

	^ anElement
]

{ #category : #'examples - label' }
BrMenuExamples >> menuIconTextLabelWithIconError [
	<gtExample>
	<return: #BrMenuTextLabelModel>
	| aLabel anElement |
	aLabel := BrMenuIconTextLabelModel new.
	aLabel
		text: 'Copy';
		preview: 'class name';
		shortcut: 'CMD+C';
		icon: [ 1/0. BrGlamorousVectorIcons clipboard ].

	anElement := BrMenuIconTextLabelElement new.
	anElement labelModel: aLabel.

	self assert: anElement childrenCount equals: 4.
	anElement children
		detect: [ :each | each id = #'menu--icon-exception' asBlocElementId ].

	^ anElement
]

{ #category : #'examples - items' }
BrMenuExamples >> menuItems [
	<gtExample>
	<return: #BrMenuItems>
	| aMenuItems anInlineSubmenu anElement |
	aMenuItems := BrMenuItems new.
	anInlineSubmenu := self submenuInlineMessageItems.
	aMenuItems addItem: anInlineSubmenu.
	aMenuItems addItem: self submenuExtractTemporaryItems.
	aMenuItems
		addItemId: #'menu-cut-item'
		label: 'Cut'
		action: [ NonInteractiveTranscript stdout show: 'Cut ' ].
	aMenuItems
		addItemLabel: 'Copy'
		shortcut: 'CMD+C'
		action: [ NonInteractiveTranscript stdout show: 'Copy ' ].
	aMenuItems
		addItemId: #'menu-paste-item'
		label: 'Paste'
		shortcut: 'CMD+V'
		action: [ NonInteractiveTranscript stdout show: 'Paste ' ].
	aMenuItems
		addItem: (BrMenuSubmenuItem new
				label: 'Create view';
				submenu: self explicitMenu).
	aMenuItems
		addItem: (BrMenuSubmenuItem new
				label: 'Create view' preview: 'single layer';
				submenu: self explicitMenuInSingleCompositionLayer).
	aMenuItems
		addItem: (BrMenuSubmenuItem new
				label: 'Create view' preview: 'comp. layer';
				submenu: self explicitMenuInSeparateCompositionLayer).
	aMenuItems
		addItem: (BrMenuSubmenuItem new
				id: #'menu-complex-submenu';
				label: 'Complex submenu';
				submenu: self explicitMenuWithWithButtons).
	aMenuItems addItem: self menuExplicitItemWithEditor.
	aMenuItems
		addItem: (BrMenuActionItem new
				icon: [ 1 / 0.
						nil ]
					label: [ 1 / 0.
						'Label error' ]
					preview: [ 1 / 0 ]
					shortcut: [ 1 / 0 ];
				action: [ :aButton | aButton phlow spawnObject: aButton ]).

	anElement := BrGlamorousMenuElementBuilder new visitModel: aMenuItems.
	self assert: (anElement isKindOf: BlElement).

	^ aMenuItems
]

{ #category : #'examples - items' }
BrMenuExamples >> menuItems_selectAnotherInlineMenu [
	<gtExample>
	<return: #BrMenuItems>
	| aMenuItems anInlineRootItem anItemOne anItemTwo |
	aMenuItems := self menuItems.
	anInlineRootItem := aMenuItems items first.
	anItemOne := anInlineRootItem items second.
	anItemTwo := anInlineRootItem items third.
	
	anInlineRootItem select.
	anItemOne select.
	
	self assert: anInlineRootItem isSelected.
	self assert: anItemOne isSelected.
	self assert: anItemTwo isSelected not.

	anItemTwo select.
	self assert: anInlineRootItem isSelected.
	self assert: anItemOne isSelected not.
	self assert: anItemTwo isSelected.

	^ aMenuItems
]

{ #category : #'examples - items' }
BrMenuExamples >> menuItems_selectExtractMenu [
	<gtExample>
	<return: #BrMenuItems>
	| aMenuItems anInlineRootItem anItemOne anItemTwo anExtractRootItem |
	aMenuItems := self menuItems_selectAnotherInlineMenu.
	anInlineRootItem := aMenuItems items first.
	anItemOne := anInlineRootItem items second.
	anItemTwo := anInlineRootItem items third.
	anExtractRootItem := aMenuItems items second.

	self assert: anInlineRootItem isSelected.
	self assert: anItemOne isSelected not.
	self assert: anItemTwo isSelected.
	self assert: anExtractRootItem isSelected not.

	anExtractRootItem select.
	self assert: anInlineRootItem isSelected not.
	self assert: anItemOne isSelected not.
	self assert: anItemTwo isSelected not.
	self assert: anExtractRootItem isSelected.

	^ aMenuItems
]

{ #category : #'examples - label item' }
BrMenuExamples >> menuLabelItem [
	<gtExample>
	<return: #BrMenuLabelItem>
	| aMenuItem |
	aMenuItem := self basicMenuLabelItem.

	aMenuItem id: #'menu-label-item'.
	aMenuItem label: self tooltipLongString shortcut: 'F5'.

	^ aMenuItem
]

{ #category : #'examples - label' }
BrMenuExamples >> menuTextAndShortcutLabel [
	<gtExample>
	<return: #BrMenuTextLabelModel>
	| aLabel |
	aLabel := BrMenuTextLabelModel new.
	aLabel text: 'Copy'.
	aLabel shortcut: 'CMD+C'.

	self assert: aLabel text equals: 'Copy'.
	self assert: aLabel shortcut equals: 'CMD+C'.

	^ aLabel
]

{ #category : #'examples - label' }
BrMenuExamples >> menuTextLabel [
	<gtExample>
	<return: #BrMenuTextLabelModel>
	| aLabel |
	aLabel := BrMenuTextLabelModel new.
	aLabel text: 'Copy'.

	self assert: aLabel text equals: 'Copy'.

	^ aLabel
]

{ #category : #'examples - label' }
BrMenuExamples >> menuTextLabelWithPreviewError [
	<gtExample>
	<return: #BrMenuTextLabelElement>
	| aLabel anElement |
	aLabel := BrMenuTextLabelModel new.
	aLabel
		text: 'Copy';
		preview: [ 1 / 0.
			'class name' ].

	anElement := BrMenuTextLabelElement new.
	anElement labelModel: aLabel.

	self assert: anElement childrenCount equals: 3.
	anElement children
		detect: [ :each | each id = #'menu--label-exception' asBlocElementId ].

	^ anElement
]

{ #category : #'examples - label' }
BrMenuExamples >> menuTextLabelWithShortcutError [
	<gtExample>
	<return: #BrMenuTextLabelElement>
	| aLabel anElement |
	aLabel := BrMenuTextLabelModel new.
	aLabel
		text: 'Copy';
		preview: 'class name';
		shortcut: [ 1 / 0.
			'CMD+C' ].

	anElement := BrMenuTextLabelElement new.
	anElement labelModel: aLabel.

	self assert: anElement childrenCount equals: 3.
	anElement children
		detect: [ :each | each id = #'menu--shortcut-exception' asBlocElementId ].

	^ anElement
]

{ #category : #'examples - label' }
BrMenuExamples >> menuTextLabelWithTextError [
	<gtExample>
	<return: #BrMenuTextLabelElement>
	| aLabel anElement |
	aLabel := BrMenuTextLabelModel new.
	aLabel
		text: [ 1 / 0.
			'Copy' ].

	anElement := BrMenuTextLabelElement new.
	anElement labelModel: aLabel.

	self assert: anElement childrenCount equals: 3.
	anElement children
		detect: [ :each | each id = #'menu--label-exception' asBlocElementId ].

	^ anElement
]

{ #category : #'examples - submenu' }
BrMenuExamples >> refactoringGroup [
	<gtExample>
	<return: #BrMenuItemGroupConfiguration>
	| aGroup |
	aGroup := BrMenuItemGroupConfiguration new
			name: 'Refactoring';
			priority: 30.

	self assert: aGroup name equals: 'Refactoring'.
	self assert: aGroup priority equals: 30.

	^ aGroup
]

{ #category : #'examples - submenu' }
BrMenuExamples >> submenuExtractTemporaryItems [
	<gtExample>
	<return: #BrMenuSubmenuItem>
	| anItem |
	anItem := BrMenuSubmenuItem new.
	anItem id: #'menu-extract-temporary-item'.
	anItem label: 'Extract temporary'.
	anItem group: self refactoringGroup.
	anItem
		submenuItem: (BrMenuActionItem new label: 'Extract temporary' preview: BrMenuSubmenuItem name).
	anItem
		submenuItem: (BrMenuActionItem new
				label: 'Extract temporary'
				preview: BrMenuSubmenuItem name , ' new').

	self assert: anItem labelModel isNotNil.
	self assert: anItem labelModel text equals: 'Extract temporary'.
	self assert: anItem submenu isNotNil.
	self assert: anItem submenu itemsCount equals: 2.

	self assert: anItem submenu items first parent equals: anItem submenu.

	^ anItem
]

{ #category : #'examples - submenu' }
BrMenuExamples >> submenuInlineMessageItems [
	<gtExample>
	<return: #BrMenuSubmenuItem>
	| anItem |
	anItem := BrMenuSubmenuItem new.
	anItem id: #'menu-inline-message-item'.
	anItem icon: BrGlamorousVectorIcons down label: 'Inline message'.
	anItem group: self refactoringGroup.
	anItem
		submenuItem: (BrMenuActionItem new
				icon: BrGlamorousVectorIcons down
				label: 'Inline message'
				preview: 'anItem label').
	anItem
		submenuItem: (BrMenuActionItem new
				icon: BrGlamorousVectorIcons down
				label: 'Inline message'
				preview: 'anItem label text').
	anItem
		submenuItem: (BrMenuActionItem new
				icon: BrGlamorousVectorIcons down
				label: 'Inline message'
				preview: 'self assert: anItem labelModel text equals: ''Copy''').

	self assert: anItem labelModel isNotNil.
	self assert: anItem labelModel text equals: 'Inline message'.
	self assert: anItem submenu isNotNil.
	self assert: anItem submenu itemsCount equals: 3.

	self assert: anItem submenu items first parent equals: anItem submenu.

	^ anItem
]

{ #category : #'examples - items' }
BrMenuExamples >> tooltipLongString [
	^ 'I am a label item explaining something in great detail'
]

{ #category : #visiting }
BrMenuExamples >> visitMenuModel: aMenu [
	^ aMenu acceptVisitor: BrGlamorousMenuElementBuilder new
]
