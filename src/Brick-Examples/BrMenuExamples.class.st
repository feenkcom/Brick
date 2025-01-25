Class {
	#name : #BrMenuExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Menu'
}

{ #category : #asserting }
BrMenuExamples >> assertGlamorousElementForMenuModel: aMenu [
	| anElement |
	anElement := aMenu acceptVisitor: BrGlamorousMenuElementBuilder new.

	self assert: (anElement isKindOf: BlElement)
]

{ #category : #'examples - action item' }
BrMenuExamples >> basicMenuActionItem [
	<gtExample>
	
	| anItem |
	anItem := BrMenuActionItem new.
]

{ #category : #'examples - submenu' }
BrMenuExamples >> explicitMenu [
	<gtExample>
	| aMenu |
	aMenu := BrMenuExplicit new.
	aMenu
		stencil: [ BlElement new
				size: 150 @ 100;
				addAptitude: (BrMenuPinnableAptitude new
						menuModel: aMenu;
						withResizers;
						withAllPinActions);
				addAptitude: BrMenuCommonAptitude new;
				background: Color paleBlue ].

	self assert: aMenu stencil isNotNil.
	self assertGlamorousElementForMenuModel: aMenu.

	^ aMenu
]

{ #category : #'examples - submenu' }
BrMenuExamples >> explicitMenuInSeparateCompositionLayer [
	<gtExample>
	| aMenu |
	aMenu := BrMenuExplicit new.
	aMenu stencil: [ BlElement new
		beInSeparateCompositionLayer;
		size: 150@100;
		addAptitude: (BrMenuPinnableAptitude new 
			menuModel: aMenu;
			withResizers;
			withAllPinActions);
		addAptitude: BrMenuCommonAptitude new;
		background: Color paleOrange ].
	
	self assert: aMenu stencil isNotNil.
	self assertGlamorousElementForMenuModel: aMenu.
	
	^ aMenu
]

{ #category : #'examples - submenu' }
BrMenuExamples >> explicitMenuInSingleCompositionLayer [
	<gtExample>
	| aMenu |
	aMenu := BrMenuExplicit new.
	aMenu stencil: [ BlElement new
		beInSingleCompositionLayer;
		size: 150@100;
		addAptitude: (BrMenuPinnableAptitude new 
			menuModel: aMenu;
			withResizers;
			withAllPinActions);
		addAptitude: BrMenuCommonAptitude new;
		background: Color paleGreen ].
	
	self assert: aMenu stencil isNotNil.
	self assertGlamorousElementForMenuModel: aMenu.
	
	^ aMenu
]

{ #category : #'examples - submenu' }
BrMenuExamples >> explicitMenuWithWithButtons [
	<gtExample>
	| aMenu |
	aMenu := BrMenuExplicit new.
	aMenu
		stencil: [ BlElement new
				layout: BlLinearLayout vertical alignCenter;
				size: 150 @ 100;
				addAptitude: (BrMenuPinnableAptitude new
						menuModel: aMenu;
						withResizers;
						withAllPinActions);
				addAptitude: BrMenuCommonAptitude new;
				background: Color palePeach;
				addChild: (BlElement new
						id: #'menu-in-submenu';
						size: 70 @ 20;
						background: Color palePeach darker;
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
BrMenuExamples >> menuActionItemWithLabel [
	<gtExample>
	
	| anItem |
	anItem := BrMenuActionItem new.
	anItem label: 'Copy'.
	self assert: anItem labelModel isNotNil.
	self assert: anItem labelModel text equals: 'Copy'.
	
	^ anItem
]

{ #category : #'example - items' }
BrMenuExamples >> menuItems [
	<gtExample>
	| aMenuItems anInlineSubmenu |
	aMenuItems := BrMenuItems new.
	anInlineSubmenu := self submenuInlineMessageItems.
	anInlineSubmenu select.
	anInlineSubmenu items second select.
	aMenuItems addItem: anInlineSubmenu.
	aMenuItems addItem: self submenuExtractTemporaryItems.
	aMenuItems
		addItemLabel: 'Cut'
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
	aMenuItems addItem: (BrMenuSubmenuItem new
		label: 'Create view';
		submenu: self explicitMenu).
	aMenuItems addItem: (BrMenuSubmenuItem new
		label: 'Create view (single layer)';
		submenu: self explicitMenuInSingleCompositionLayer).
	aMenuItems addItem: (BrMenuSubmenuItem new
		label: 'Create view (comp. layer)';
		submenu: self explicitMenuInSeparateCompositionLayer).
	aMenuItems addItem: (BrMenuSubmenuItem new
			id: #'menu-complex-submenu';
			label: 'Complex submenu';
			submenu: self explicitMenuWithWithButtons).

	^ aMenuItems
]

{ #category : #'example - items' }
BrMenuExamples >> menuItems_selectAnotherInlineMenu [
	<gtExample>
	| aMenuItems anInlineRootItem anItemOne anItemTwo |
	aMenuItems := self menuItems.
	anInlineRootItem := aMenuItems items first.
	anItemOne := anInlineRootItem items second.
	anItemTwo := anInlineRootItem items third.
	
	self assert: anInlineRootItem isSelected.
	self assert: anItemOne isSelected.
	self assert: anItemTwo isSelected not.
	
	anItemTwo select.
	self assert: anInlineRootItem isSelected.
	self assert: anItemOne isSelected not.
	self assert: anItemTwo isSelected.

	^ aMenuItems
]

{ #category : #'example - items' }
BrMenuExamples >> menuItems_selectExtractMenu [
	<gtExample>
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

{ #category : #'examples - label' }
BrMenuExamples >> menuTextAndShortcutLabel [
	<gtExample>
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
	| aLabel |
	aLabel := BrMenuTextLabelModel new.
	aLabel text: 'Copy'.

	self assert: aLabel text equals: 'Copy'.

	^ aLabel
]

{ #category : #'examples - submenu' }
BrMenuExamples >> refactoringGroup [
	<gtExample>
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
	| anItem |
	anItem := BrMenuSubmenuItem new.
	anItem label: 'Extract temporary'.
	anItem group: self refactoringGroup.
	anItem submenuItem: (BrMenuActionItem new
		label: 'Extract temporary' preview: BrMenuSubmenuItem name).
	anItem submenuItem: (BrMenuActionItem new
		label: 'Extract temporary' preview: BrMenuSubmenuItem name, ' new').
	
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
	| anItem |
	anItem := BrMenuSubmenuItem new.
	anItem label: 'Inline message'.
	anItem group: self refactoringGroup.
	anItem submenuItem: (BrMenuActionItem new
		label: 'Inline message' preview: 'anItem label').
	anItem submenuItem: (BrMenuActionItem new
		label: 'Inline message' preview: 'anItem label text').
	anItem submenuItem: (BrMenuActionItem new
		label: 'Inline message' preview: 'self assert: anItem labelModel text equals: ''Copy''').
	
	self assert: anItem labelModel isNotNil.
	self assert: anItem labelModel text equals: 'Inline message'.
	self assert: anItem submenu isNotNil.
	self assert: anItem submenu itemsCount equals: 3.
	
	self assert: anItem submenu items first parent equals: anItem submenu.

	^ anItem
]
