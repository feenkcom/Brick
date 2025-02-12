Class {
	#name : #BrTreeDataSource,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'rootNode',
		'treeElement',
		'supportsSelection',
		'selection',
		'nodeTypeStencil',
		'clickToSelectHandler',
		'nodeIdStencil'
	],
	#category : #'Brick-Tree - Support'
}

{ #category : #private }
BrTreeDataSource >> getRowIndex: anElementHolder [
	^ anElementHolder dataSourcePosition
]

{ #category : #initialization }
BrTreeDataSource >> initialize [
	super initialize.
	
	supportsSelection := true.
	selection := BlCompositeSelection new.
	clickToSelectHandler := BrTreeClickToSelectHandler new
]

{ #category : #accessing }
BrTreeDataSource >> itemCount [
	"Return the total number of items in the data set"
	<return: #Number>

	^ rootNode size
]

{ #category : #accessing }
BrTreeDataSource >> itemIdAt: anItemPosition [
	| anItemNode anItemId |

	nodeIdStencil
		ifNil: [ ^ NoId ].

	anItemNode := rootNode at: anItemPosition.

	anItemId := nodeIdStencil
		itemPosition: anItemPosition;
		itemNode: anItemNode;
		build.

	^ anItemId
]

{ #category : #accessing }
BrTreeDataSource >> itemTypeAt: anItemPosition [
	| anItemNode anItemType |
	
	anItemNode := rootNode at: anItemPosition.

	anItemType := nodeTypeStencil
		itemPosition: anItemPosition;
		itemNode: anItemNode;
		build.

	nodeTypeStencil reset.

	^ anItemType
]

{ #category : #'accessing - stencils' }
BrTreeDataSource >> nodeIdStencil: aBrTreeNodeIdStencilBuilder [
	nodeIdStencil := aBrTreeNodeIdStencilBuilder asStencilBuilder: BrTreeNodeIdStencilBuilder.
	hasStableIds := aBrTreeNodeIdStencilBuilder notNil.
	self notifyChanged
]

{ #category : #'accessing - stencils' }
BrTreeDataSource >> nodeTypeStencil: aBrTreeNodeTypeStencilBuilder [
	nodeTypeStencil := aBrTreeNodeTypeStencilBuilder asStencilBuilder: BrTreeNodeTypeStencilBuilder.
	self notifyChanged
]

{ #category : #hooks }
BrTreeDataSource >> onChanged: anAnnouncement [
	anAnnouncement payload
		ifNil: [ self notifyItemsChanged: (anAnnouncement index to: anAnnouncement index)  ]
		ifNotNil: [ :aPayload | self notifyItemsChanged: (anAnnouncement index to: anAnnouncement index) payload: aPayload ]
]

{ #category : #hooks }
BrTreeDataSource >> onCollapsed: anAnnouncement [
	self notifyItemsRemoved: (anAnnouncement from to: anAnnouncement to)
]

{ #category : #hooks }
BrTreeDataSource >> onExpanded: anAnnouncement [
	self notifyItemsInserted: (anAnnouncement from to: anAnnouncement to)
]

{ #category : #hooks }
BrTreeDataSource >> onInserted: anAnnouncement [
	self notifyItemsInserted: (anAnnouncement from to: anAnnouncement to)
]

{ #category : #hooks }
BrTreeDataSource >> onRemoved: anAnnouncement [
	self notifyItemsRemoved: (anAnnouncement from to: anAnnouncement to)
]

{ #category : #accessing }
BrTreeDataSource >> rootNode: aTreeNode [

	rootNode ifNotNil: [ :aPreviousRoot | aPreviousRoot announcer unsubscribe: self ].
	rootNode := aTreeNode.
	rootNode announcer when: BrTreeNodeChanged send: #onChanged: to: self.
	rootNode announcer when: BrTreeNodeExpanded send: #onExpanded: to: self.
	rootNode announcer when: BrTreeNodeCollapsed send: #onCollapsed: to: self.
	rootNode announcer when: BrTreeNodeInserted send: #onInserted: to: self.
	rootNode announcer when: BrTreeNodeRemoved send: #onRemoved: to: self.
	
	self notifyChanged
]

{ #category : #accessing }
BrTreeDataSource >> selection [
	<return: #BlSelection>
	
	^ selection
]

{ #category : #accessing }
BrTreeDataSource >> selection: aBlSelection [
	supportsSelection
		ifFalse: [ ^ self ].

	selection do: [ :eachMonotoneSelection | self notifyItemsChanged: eachMonotoneSelection indices ].
	selection := aBlSelection.
	selection do: [ :eachMonotoneSelection | self notifyItemsChanged: eachMonotoneSelection indices ]
]

{ #category : #accessing }
BrTreeDataSource >> supportsSelection: aBoolean [
	supportsSelection := aBoolean
]

{ #category : #accessing }
BrTreeDataSource >> treeElement [
	^ treeElement
]

{ #category : #accessing }
BrTreeDataSource >> treeElement: anObject [
	treeElement := anObject.
	clickToSelectHandler treeWidget: treeElement
]
