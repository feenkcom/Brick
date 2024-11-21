Class {
	#name : #BrMenuItems,
	#superclass : #Object,
	#instVars : [
		'items',
		'parent'
	],
	#category : #'Brick-Menu'
}

{ #category : #'add / remove' }
BrMenuItems >> addItem: aMenuItem [
	aMenuItem parent: self parent.
	self items add: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemLabel: aText action: anAction [
	| aMenuItem |
	aMenuItem := BrMenuActionItem new.
	aMenuItem label: aText.
	aMenuItem action: anAction.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemLabel: aLabelString shortcut: aShortcutString action: anAction [
	| aMenuItem |
	aMenuItem := BrMenuActionItem new.
	aMenuItem label: aLabelString shortcut: aShortcutString.
	aMenuItem action: anAction.
	self addItem: aMenuItem
]

{ #category : #'api - grouping' }
BrMenuItems >> groups [
	<return: #Array of: #BrMenuItemGroup>
	| aDictionary |
	aDictionary := Dictionary new.
	self items
		do: [ :eachItem | 
			aDictionary
				at: eachItem group id
				ifPresent: [ :aGroup | aGroup addItem: eachItem ]
				ifAbsentPut: [ BrMenuItemGroup new addItem: eachItem ] ].

	^ aDictionary values sort: [ :a :b | a priority < b priority ]
]

{ #category : #'gt - extensions' }
BrMenuItems >> gtGroupsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Grouped menu items';
		priority: 10;
		items: [ self groups ifNil: [ #() ] ];
		children: #gtItemChildren;
		expandAll;
		column: 'Label' text: [ :anItem | anItem gtItemLabel ];
		column: 'Selection'
			text: #gtItemSelection
			weight: 0.2;
		column: 'Depth'
			text: #gtItemDepth
			weight: 0.2;
		column: 'Type' text: #class weight: 0.5
]

{ #category : #'gt - extensions' }
BrMenuItems >> gtItemsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Menu items';
		items: [ self items ifNil: [ #() ] ];
		children: #gtItemChildren;
		expandAll;
		column: 'Label' text: [ :anItem | anItem gtItemLabel ];
		column: 'Selection'
			text: [ :anItem | anItem isSelected ]
			weight: 0.2;
		column: 'Depth'
			text: [ :anItem | 
				| aDepth |
				aDepth := 0.
				anItem parentsDo: [ aDepth := aDepth + 1 ].
				aDepth ]
			weight: 0.2;
		column: 'Type' text: #class weight: 0.5
]

{ #category : #initialization }
BrMenuItems >> initialize [
	super initialize.
	items := OrderedCollection new
]

{ #category : #accessing }
BrMenuItems >> items [
	^ items
]

{ #category : #accessing }
BrMenuItems >> items: aCollection [
	aCollection parent: self parent.
	items := aCollection
]

{ #category : #accessing }
BrMenuItems >> itemsCount [
	^ self items size
]

{ #category : #accessing }
BrMenuItems >> parent [
	^ parent
]

{ #category : #accessing }
BrMenuItems >> parent: anObject [
	parent := anObject
]

{ #category : #printing }
BrMenuItems >> printOn: aStream [
	super printOn: aStream.

	aStream
		space;
		nextPut: $[;
		print: self itemsCount;
		space;
		nextPutAll: ('item' asPluralBasedOn: self itemsCount);
		nextPut: $]
]
