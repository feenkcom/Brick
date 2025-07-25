Class {
	#name : #BrColumnedTreeDataSource,
	#superclass : #BrTreeDataSource,
	#instVars : [
		'columns',
		'rowStencil',
		'rowElementStencil',
		'rowDataBinder'
	],
	#category : #'Brick-Tree - Support'
}

{ #category : #accessing }
BrColumnedTreeDataSource >> columns [
	<return: #Collection of: #BrColumn>
	^ columns
]

{ #category : #accessing }
BrColumnedTreeDataSource >> columns: aCollectionOfBrListColumn [

	columns := aCollectionOfBrListColumn.
	self notifyChanged
]

{ #category : #initialization }
BrColumnedTreeDataSource >> initialize [
	super initialize.
	
	columns := #()
]

{ #category : #'instance creation' }
BrColumnedTreeDataSource >> onBindHolder: anElementHolder at: aPosition [
	| anItemNode eachColumnIndex |

	anItemNode := rootNode at: aPosition.
	
	eachColumnIndex := 0.
	anElementHolder columns
		with: anElementHolder columnElements
		do: [ :eachColumn :eachCellElement |
			eachColumnIndex := eachColumnIndex + 1.
			
			
			eachColumn dataBinder
				cellElement: eachCellElement;
				itemObject: anItemNode value;
				rowObject: anItemNode value;
				rowIndex: aPosition;
				rowHolder: anElementHolder;
				columnIndex: eachColumnIndex;
				build ].

	"Bind node data to the row element"
	rowDataBinder
		rowElement: anElementHolder itemElement;
		itemNode: anItemNode;
		itemPosition: aPosition;
		build.
	
	anElementHolder rowNode: anItemNode.	

	anElementHolder itemElement states removeState: BlElementState hovered.

	supportsSelection
		ifFalse: [ ^ self ].

	(self selection containsIndex: aPosition)
		ifTrue: [ anElementHolder itemElement states addState: BlElementSelectedState uniqueInstance]
		ifFalse: [ anElementHolder itemElement states removeState: BlElementSelectedState uniqueInstance ]
]

{ #category : #'instance creation' }
BrColumnedTreeDataSource >> onCreateHolder: anInfiniteElement type: anItemType [
	"aNodeElement is the element that should represent the data of each tree node"

	| theColumnElements aRowElement |
	theColumnElements := self columns
			withIndexCollect: [ :eachColumn :eachIndex | 
				| eachColumnElement |
				eachColumnElement := eachColumn cellStencil
						itemType: anItemType;
						column: eachColumn;
						columnIndex: eachIndex;
						asElement.

				eachColumn columnWidth applyOn: eachColumnElement.
				eachColumn announcer
					when: BrColumnWidthChanged
					do: [ :evt | eachColumn columnWidth applyOn: eachColumnElement ]
					for: self.

				eachColumnElement ].	"now wrap the column elements in a row element with adornments"
	aRowElement := rowElementStencil
			itemType: anItemType;
			columns: self columns;
			columnElements: theColumnElements;
			asElement.

	aRowElement addEventHandler: clickToSelectHandler.

	^ BrColumnedTreeItemHolder new
		itemElement: aRowElement;
		columns: self columns;
		columnElements: theColumnElements
]

{ #category : #'accessing - stencils' }
BrColumnedTreeDataSource >> rowDataBinder: aBrTreeRowDataBinder [
	"Set a data binder that should bind node data to the whole tree row element"

	rowDataBinder := aBrTreeRowDataBinder asStencilBuilder: BrTreeRowDataBinder.
	self notifyChanged
]

{ #category : #'accessing - stencils' }
BrColumnedTreeDataSource >> rowElementStencil: aBrColumnedTreeRowElementStencilBuilder [
	"Row stencil wrapps the created node element into an element that will play a role
	of the row in the tree. Typically, a row also contains the expand button."

	rowElementStencil := aBrColumnedTreeRowElementStencilBuilder asStencilBuilder: BrColumnedTreeRowElementStencilBuilder.
	self notifyChanged
]
