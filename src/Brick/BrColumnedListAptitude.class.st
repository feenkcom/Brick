Class {
	#name : #BrColumnedListAptitude,
	#superclass : #BrAptitude,
	#traits : 'TBrListInfiniteElementScroll',
	#classTraits : 'TBrListInfiniteElementScroll classTrait',
	#instVars : [
		'listElement',
		'rowStencil'
	],
	#category : #'Brick-List - Look'
}

{ #category : #initialization }
BrColumnedListAptitude >> initialize [
	super initialize.
	
	listElement := BrInfiniteListElement new.
	listElement dataSource: BrColumnedListDataSource new.
	
	self add: (BrLayoutResizerAptitude inherit inherit: listElement).
				
	self addChangeAddChildAs: #(content scrollable) with: [ listElement ].

	self
		addChangeProperty: #(widgetContent layout)
		with: [ BlLinearLayout vertical ].
		
	self
		addChange:
			(BrLookChange new
				up: [ :e | listElement dataSource listElement: self widgetContent ];
				down: [ :e |  ];
				yourself).
]

{ #category : #initialization }
BrColumnedListAptitude >> initializeListeners [
	super initializeListeners.
	
	self when: BrListModelItemsChangedEvent do: [ :anEvent | self onModelItemsChanged: anEvent ].
	self when: BrListModelItemsAddedEvent do: [ :anEvent | self onModelItemsAdded: anEvent ].
	self when: BrListModelPromiseEnqueuedEvent do: [ :anEvent | self onModelPromiseEnqueued: anEvent ].
	self when: BrColumnsChanged do: [ :anEvent | self onColumnsChanged: anEvent columns ].
	self when: BrSelectionChanged do: [ :anEvent | self onSelectionChanged: anEvent indices ].
	self when: BrListItemTypeStencilChangedEvent do: [ :anEvent | self onItemTypeStencilChanged: anEvent itemTypeStencil ].
	
	self initializeScrollListeners
]

{ #category : #initialization }
BrColumnedListAptitude >> initializeRequests [
	super initializeRequests.
	
	self request: BrColumnsRequest new.
	self request: BrSelectionRequest new.
	self request: BrListItemTypeStencilRequest new.
]

{ #category : #accessing }
BrColumnedListAptitude >> listElement [
	^ listElement
]

{ #category : #'api - hooks' }
BrColumnedListAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.

	self listElement dataSource 
		listModel: anElement viewModel
]

{ #category : #hooks }
BrColumnedListAptitude >> onColumnsChanged: aCollectionOfBrListColumns [
	self listElement dataSource columns: aCollectionOfBrListColumns
]

{ #category : #hooks }
BrColumnedListAptitude >> onItemTypeStencilChanged: aBrListItemTypeStencilBuilder [
	self listElement dataSource itemTypeStencil: aBrListItemTypeStencilBuilder
]

{ #category : #hooks }
BrColumnedListAptitude >> onModelItemsAdded: anEvent [
	self listElement enqueueTask: (BlTaskAction new action: [ self listElement dataSource notifyItemsInserted: anEvent insertedInterval ])
]

{ #category : #hooks }
BrColumnedListAptitude >> onModelItemsChanged: anEvent [
	self listElement enqueueTask: (BlTaskAction new action: [ self listElement dataSource notifyChanged ])
]

{ #category : #hooks }
BrColumnedListAptitude >> onModelPromiseEnqueued: anEvent [
	self listElement enqueueTask: (BlPromiseTask new promise: anEvent promise)
]

{ #category : #hooks }
BrColumnedListAptitude >> onSelectionChanged: aCollectionOfIndices [
	self listElement dataSource selection: (BlCompositeSelection fromIndices: aCollectionOfIndices)
]

{ #category : #accessing }
BrColumnedListAptitude >> rowStencilBuilder: aStencil [
	"aStencil is expected to be a subclass of BrListRowStencilBuilder or a valuable"
	rowStencil := aStencil asStencilBuilder: BrListRowStencilBuilder.

	self listElement dataSource itemElementStencil: rowStencil
]
