Class {
	#name : #BrListDataSource,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'listModel',
		'selection',
		'itemIdStencil',
		'itemTypeStencil',
		'clickToSelectHandler',
		'listWidget'
	],
	#category : #'Brick-List-Support'
}

{ #category : #private }
BrListDataSource >> assignRowIndex: aPosition to: anElementHolder [
	anElementHolder itemElement
		userData at: #listRowIndex put: aPosition
]

{ #category : #accessing }
BrListDataSource >> entityObjectAt: anIndex [
	^ self subclassResponsibility
]

{ #category : #private }
BrListDataSource >> getRowIndex: anElementHolder [
	^ anElementHolder itemElement userData
		at: #listRowIndex
		ifAbsent: [ 0 ]
]

{ #category : #initialization }
BrListDataSource >> initialize [
	super initialize.
	
	selection := BlCompositeSelection new.
	clickToSelectHandler := BrListClickToSelectHandler new
]

{ #category : #'accessing - stencils' }
BrListDataSource >> itemIdStencil: aBrListItemIdStencilBuilder [
	itemIdStencil := aBrListItemIdStencilBuilder.
	hasStableIds := aBrListItemIdStencilBuilder notNil.
	self notifyChanged
]

{ #category : #'accessing - stencils' }
BrListDataSource >> itemTypeStencil: aBrListItemTypeStencilBuilder [
	itemTypeStencil := aBrListItemTypeStencilBuilder.
	self notifyChanged
]

{ #category : #accessing }
BrListDataSource >> listElement [
	^ listWidget
]

{ #category : #accessing }
BrListDataSource >> listElement: aBrList [
	listWidget := aBrList.
	clickToSelectHandler listWidget: aBrList
]

{ #category : #accessing }
BrListDataSource >> listModel [
	^ listModel
]

{ #category : #accessing }
BrListDataSource >> listModel: aListModel [
	listModel := aListModel.
	self notifyChanged
]

{ #category : #hooks }
BrListDataSource >> onElementAttached: anElementHolder [
	| anItemElement anItemPosition anItemValue |
	
	anItemElement := anElementHolder itemElement.
	anItemPosition := anElementHolder position.
	anItemValue := self entityObjectAt: anItemPosition.

	self listElement dispatchEvent: (BrListItemElementAttached new
		itemElement: anItemElement;
		rowIndex: anItemPosition;
		rowValue: anItemValue)
]

{ #category : #hooks }
BrListDataSource >> onElementDetached: anElementHolder [
	| anItemPosition anItemValue |

	anItemPosition := anElementHolder position.
	anItemValue := anElementHolder rowValue.

	self listElement dispatchEvent: (BrListItemElementDetached new
		rowIndex: anItemPosition;
		rowValue: anItemValue)
]

{ #category : #accessing }
BrListDataSource >> selection [
	<return: #BlSelection>
	
	^ selection
]

{ #category : #accessing }
BrListDataSource >> selection: aBlSelection [
	selection do: [ :eachMonotoneSelection | self notifyItemsChanged: eachMonotoneSelection indices ].
	selection := aBlSelection.
	selection do: [ :eachMonotoneSelection | self notifyItemsChanged: eachMonotoneSelection indices ]
]
