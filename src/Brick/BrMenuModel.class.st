Class {
	#name : #BrMenuModel,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'parent'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #testing }
BrMenuModel class >> isAbstract [
	^ self name = #BrMenuModel
]

{ #category : #'api - announcer' }
BrMenuModel >> announcer [
	^ announcer
]

{ #category : #'api - converting' }
BrMenuModel >> asElement [
	<return: #BlElement>
	^ self subclassResponsibility
]

{ #category : #'gt - extensions' }
BrMenuModel >> gtItemsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Menu items';
		items: [ self items ifNil: [ #() ] ];
		children: #gtItemChildren;
		expandAll;
		column: 'Label' text: [ :anItem | anItem gtItemLabel ];
		column: 'Selection'
			text: [ :anItem | GtPhlowOverviewItem new 
				boolean: anItem isSelected; 
				description ]
			weight: 0.2;
		column: 'Depth'
			text: [ :anItem | 
				| aDepth |
				aDepth := 1.
				anItem parentsDo: [ aDepth := aDepth + 1 ].
				aDepth ]
			weight: 0.2;
		column: 'Type' text: #menuType weight: 0.5
]
