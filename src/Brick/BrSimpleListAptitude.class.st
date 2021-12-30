Class {
	#name : #BrSimpleListAptitude,
	#superclass : #BrAptitude,
	#traits : 'TBrListInfiniteElementScroll',
	#classTraits : 'TBrListInfiniteElementScroll classTrait',
	#instVars : [
		'listElement'
	],
	#category : #'Brick-List - Look'
}

{ #category : #'api - orientation' }
BrSimpleListAptitude >> beHorizontal [
	| anOldListElement |
	self listElement class = BrHorizontalInfiniteListElement ifTrue: [ ^ self ].
	anOldListElement := self listElement.
	listElement := BrHorizontalInfiniteListElement new.
	listElement dataSource 
		listModel: anOldListElement dataSource listModel.
	self replaceListElement: anOldListElement by: self listElement.
	self requestListConfiguration.
]

{ #category : #'api - orientation' }
BrSimpleListAptitude >> beVertical [
	| anOldListElement |
	self listElement class = BrInfiniteListElement ifTrue: [ ^ self ].
	anOldListElement := self listElement.
	listElement := BrInfiniteListElement new.
	listElement dataSource 
		listModel: anOldListElement dataSource listModel.
	self replaceListElement: anOldListElement by: self listElement.
	self requestListConfiguration.
]

{ #category : #initialization }
BrSimpleListAptitude >> initialize [
	super initialize.

	self initializeListElement.
	
	self add: (BrLayoutResizerAptitude new
		inherit;
		inherit: [ self listElement ]).
	
	self addChangeAddChildAs: #(content scrollable) with: [ self listElement ].

	self
		addChangeProperty: #(widgetContent layout)
		with: [ BlLinearLayout vertical ].
	self
		addChange:
			(BrLookChange new
				up: [ :e | self updateListElementParent ];
				down: [ :e |  ];
				yourself).
	
	self add: (BrListOrientationAptitude new
		horizontal: [ :aStyle | aStyle do: [ :aWidget | self beHorizontal ] ];
		vertical: [ :aStyle | aStyle do: [ :aWidget | self beVertical ] ])
]

{ #category : #initialization }
BrSimpleListAptitude >> initializeListElement [
	listElement := BrInfiniteListElement new.
]

{ #category : #initialization }
BrSimpleListAptitude >> initializeListeners [
	super initializeListeners.

	self when: BrListModelItemsChangedEvent do: [ :anEvent | self onModelItemsChanged: anEvent ].
	self when: BrListModelItemsAddedEvent do: [ :anEvent | self onModelItemsAdded: anEvent ].
	self when: BrListModelPromiseEnqueuedEvent do: [ :anEvent | self onModelPromiseEnqueued: anEvent ].
	self when: BrSelectionChanged do: [ :anEvent | self onSelectionChanged: anEvent indices ].
	self when: BrListItemTypeStencilChangedEvent do: [ :anEvent | self onItemTypeStencilChanged: anEvent itemTypeStencil ].
	self when: BrListItemIdStencilChangedEvent do: [ :anEvent | self onItemIdStencilChanged: anEvent itemIdStencil ].
	self when: BrListItemElementStencilChangedEvent do: [ :anEvent | self onItemElementStencilChanged: anEvent itemElementStencil ].
	self when: BrListItemDataBinderChangedEvent do: [ :anEvent | self onItemDataBinderChanged: anEvent itemDataBinder ].
	self when: BrListItemDataUnbinderChangedEvent do: [ :anEvent | self onItemDataUnbinderChanged: anEvent itemDataUnbinder ].
	
	self initializeScrollListeners
]

{ #category : #initialization }
BrSimpleListAptitude >> initializeRequests [
	super initializeRequests.
	self requestListConfiguration
]

{ #category : #'private - accessing' }
BrSimpleListAptitude >> listElement [
	^ listElement
]

{ #category : #'api - hooks' }
BrSimpleListAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.

	self listElement dataSource 
		listModel: anElement viewModel
]

{ #category : #hooks }
BrSimpleListAptitude >> onItemDataBinderChanged: aBrListItemDataBinder [
	self listElement dataSource itemDataBinder: aBrListItemDataBinder
]

{ #category : #hooks }
BrSimpleListAptitude >> onItemDataUnbinderChanged: aBrListItemDataUnbinder [
	self listElement dataSource itemDataUnbinder: aBrListItemDataUnbinder
]

{ #category : #hooks }
BrSimpleListAptitude >> onItemElementStencilChanged: aBrListItemElementStencilBuilder [
	self listElement dataSource itemElementStencil: aBrListItemElementStencilBuilder
]

{ #category : #hooks }
BrSimpleListAptitude >> onItemIdStencilChanged: aBrListItemIdStencilBuilder [
	self listElement dataSource itemIdStencil: aBrListItemIdStencilBuilder
]

{ #category : #hooks }
BrSimpleListAptitude >> onItemTypeStencilChanged: aBrListItemTypeStencilBuilder [
	self listElement dataSource itemTypeStencil: aBrListItemTypeStencilBuilder
]

{ #category : #hooks }
BrSimpleListAptitude >> onModelItemsAdded: anEvent [
	self listElement enqueueTask: (BlTaskAction new action: [ self listElement dataSource notifyItemsInserted: anEvent insertedInterval ])
]

{ #category : #hooks }
BrSimpleListAptitude >> onModelItemsChanged: anEvent [
	anEvent isSynchronous
		ifTrue: [ self listElement dataSource notifyChanged ]
		ifFalse: [ self listElement enqueueTask: (BlTaskAction new action: [ self listElement dataSource notifyChanged ]) ]
]

{ #category : #hooks }
BrSimpleListAptitude >> onModelPromiseEnqueued: anEvent [
	self listElement enqueueTask: (BlPromiseTask new promise: anEvent promise)
]

{ #category : #hooks }
BrSimpleListAptitude >> onSelectionChanged: aCollectionOfIndices [
	self listElement dataSource selection: (BlCompositeSelection fromIndices: aCollectionOfIndices)
]

{ #category : #'private - updating' }
BrSimpleListAptitude >> replaceListElement: anOldListElement by: aNewListElement [
	self widgetDo: [ :aWidget |
		| aParent |
		aParent := anOldListElement parent.
		aParent replaceChild: anOldListElement with: aNewListElement as: #scrollable.
		self updateListElementParent. ]
]

{ #category : #initialization }
BrSimpleListAptitude >> requestListConfiguration [
	self request: BrSelectionRequest new.
	self request: BrListItemTypeStencilRequest new.
	self request: BrListItemIdStencilRequest new.
	self request: BrListItemElementStencilRequest new.
	self request: BrListItemDataBinderRequest new.
	self request: BrListItemDataUnbinderRequest new
]

{ #category : #'private - updating' }
BrSimpleListAptitude >> updateListElementParent [
	self listElement dataSource listElement: self widgetContent
]
