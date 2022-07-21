Class {
	#name : #BrUngroupedListDataSource,
	#superclass : #BrListDataSource,
	#instVars : [
		'itemElementStencil'
	],
	#category : #'Brick-List-Ungrouped-Support'
}

{ #category : #accessing }
BrUngroupedListDataSource >> entityObjectAt: anIndex [
	^ self listModel itemAt: anIndex
]

{ #category : #accessing }
BrUngroupedListDataSource >> itemCount [
	^ self listModel 
		ifNil: [ 0 ]
		ifNotNil: [ :aListModel | aListModel itemCount ]
]

{ #category : #'accessing - stencils' }
BrUngroupedListDataSource >> itemElementStencil: aBrListItemElementStencilBuilder [
	itemElementStencil := aBrListItemElementStencilBuilder.
	self notifyChanged
]

{ #category : #accessing }
BrUngroupedListDataSource >> itemIdAt: anItemPosition [
	| anItemObject anItemId |

	itemIdStencil
		ifNil: [ ^ NoId ].

	anItemObject := self listModel itemAt: anItemPosition.

	anItemId := itemIdStencil
		itemPosition: anItemPosition;
		itemObject: anItemObject;
		build.

	^ anItemId
]

{ #category : #accessing }
BrUngroupedListDataSource >> itemTypeAt: anItemPosition [
	| anItemObject anItemType |

	anItemObject := self listModel itemAt: anItemPosition.

	anItemType := itemTypeStencil
		itemPosition: anItemPosition;
		itemObject: anItemObject;
		build.

	^ anItemType
]
