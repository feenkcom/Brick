Class {
	#name : #BrMenuExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Menu'
}

{ #category : #'examples - action item' }
BrMenuExamples >> basicMenuActionItem [
	<gtExample>
	
	| anItem |
	anItem := BrMenuActionItem new.
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
	| aMenuItems |
	aMenuItems := BrMenuItems new.
	aMenuItems addItem: self submenuInlineMessageItems.
	aMenuItems addItem: self submenuExtractTemporaryItems.
	aMenuItems addItemLabel: 'Cut' action: [ ].
	aMenuItems addItemLabel: 'Copy' shortcut: 'CMD+C' action: [ ].
	aMenuItems addItemLabel: 'Paste' shortcut: 'CMD+V' action: [ ].

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
	
	self assert: anItem submenu items first parent equals: anItem.

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
	
	self assert: anItem submenu items first parent equals: anItem.

	^ anItem
]
