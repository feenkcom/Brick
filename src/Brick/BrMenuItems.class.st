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
BrMenuItems >> addItem: aMenuItem [.
	aMenuItem parent: self parent.
	self items add: aMenuItem
]

{ #category : #'gt - extensions' }
BrMenuItems >> gtItemsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Menu items';
		items: [ self items ifNil: [ #() ] ];
		children: #gtItemChildren;
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
