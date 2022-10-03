Class {
	#name : #BrGroupedListDataSource,
	#superclass : #BrListDataSource,
	#instVars : [
		'groups',
		'headerElementStencil',
		'itemDataBinder',
		'headerDataBinder'
	],
	#category : #'Brick-List-Grouped-Support'
}

{ #category : #accessing }
BrGroupedListDataSource >> entityObjectAt: anIndex [
	^ (self listModel entityAt: anIndex) object
]

{ #category : #'accessing - stencils' }
BrGroupedListDataSource >> headerDataBinder: aBrListItemDataBinderBuilder [
	headerDataBinder := aBrListItemDataBinderBuilder.
	self notifyChanged
]

{ #category : #'accessing - stencils' }
BrGroupedListDataSource >> headerElementStencil: aBrListItemElementStencilBuilder [
	headerElementStencil := aBrListItemElementStencilBuilder.
	self notifyChanged
]

{ #category : #initialization }
BrGroupedListDataSource >> initialize [
	super initialize.
	
	headerElementStencil := BrListItemElementStencilBuilder new.
	headerDataBinder := BrListItemDataBinder new.
]

{ #category : #accessing }
BrGroupedListDataSource >> itemCount [
	^ self listModel 
		ifNil: [ 0 ]
		ifNotNil: [ :aListModel | aListModel entityCount ]
]

{ #category : #'accessing - stencils' }
BrGroupedListDataSource >> itemDataBinder: aBrListItemDataBinderBuilder [
	itemDataBinder := aBrListItemDataBinderBuilder.
	self notifyChanged
]

{ #category : #accessing }
BrGroupedListDataSource >> itemTypeAt: anItemPosition [
	"Return the element type of the item at aPosition for the purposes of element recycling.
	The default implementation of this method returns ===BlInfiniteItemType invalid===,
	making the assumption of a single element type for the data source."
	<return: #BlInfiniteItemType>
	| anEntity |

	anEntity := self listModel entityAt: anItemPosition.
	^ anEntity
		ifHeader: [ BrGroupedListHeaderItemType default ]
		ifItem: [
			| anItemType |
	
			anItemType := anEntity group itemTypeStencil
				itemPosition: anItemPosition;
				itemObject: anEntity itemObject;
				build.
			BrGroupedListItemType new
				group: anEntity group;
				itemType: anItemType ]
]

{ #category : #'instance creation' }
BrGroupedListDataSource >> onBindHeader: aBrGroup holder: anElementHolder at: aPosition [
	| anItemElementWithBindedData |

	anItemElementWithBindedData := headerDataBinder
		itemElement: anElementHolder itemElement;
		itemObject: aBrGroup;
		rowObject: aBrGroup;
		itemPosition: aPosition;
		asElement.

	anElementHolder
		itemElement: anItemElementWithBindedData;
		rowValue: aBrGroup
]

{ #category : #'instance creation' }
BrGroupedListDataSource >> onBindHolder: anElementHolder at: aPosition [
	| anEntityObject |

	anEntityObject := self listModel entityAt: aPosition.
	anEntityObject
		ifHeader: [ self onBindHeader: anEntityObject group holder: anElementHolder at: aPosition ]
		ifItem: [ self onBindItem: anEntityObject holder: anElementHolder at: aPosition ]
]

{ #category : #'instance creation' }
BrGroupedListDataSource >> onBindItem: anItemEntity holder: anElementHolder at: aPosition [
	| anItemObject anItemElementWithBindedData |

	anItemObject := anItemEntity itemObject.

	anItemEntity group itemDataBinder
		itemElement: anElementHolder itemElement;
		itemObject: anItemObject;
		rowObject: anItemObject;
		itemPosition: aPosition;
		build.

	anElementHolder
		itemElement: anElementHolder itemElement;
		rowValue: anItemObject.

	anElementHolder itemElement states removeState: BlElementState hovered.

	(self selection containsIndex: aPosition)
		ifTrue: [ anElementHolder itemElement states addState: BlElementSelectedState uniqueInstance ]
		ifFalse: [ anElementHolder itemElement states removeState: BlElementSelectedState uniqueInstance ]
]

{ #category : #'instance creation' }
BrGroupedListDataSource >> onCreateHolder: anInfiniteElement type: anItemType [
	^ anItemType = BrGroupedListHeaderItemType default
		ifTrue: [
			| aHeaderElement |
			
			aHeaderElement := headerElementStencil
				itemType: anItemType;
				asElement.
				
			BrGroupedListEntityElementHolder new
				itemElement: aHeaderElement ]
		ifFalse: [
			| anItemElement |

			anItemElement := anItemType group itemStencil
				itemType: anItemType itemType;
				asElement.

			anItemElement addEventHandler: clickToSelectHandler.
			BrGroupedListEntityElementHolder new
				itemElement: anItemElement ]
]
