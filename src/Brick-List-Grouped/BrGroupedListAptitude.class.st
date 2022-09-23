Class {
	#name : #BrGroupedListAptitude,
	#superclass : #BrAptitude,
	#traits : 'TBrListInfiniteElementScroll',
	#classTraits : 'TBrListInfiniteElementScroll classTrait',
	#instVars : [
		'listElement'
	],
	#category : #'Brick-List-Grouped-Aptitudes'
}

{ #category : #'api - orientation' }
BrGroupedListAptitude >> beHorizontal [
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
BrGroupedListAptitude >> beVertical [
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
BrGroupedListAptitude >> initialize [
	super initialize.

	self initializeListElement.
	
	self add: (BrLayoutResizerAptitude new
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
		horizontal: [ :aStyle | aStyle do: [ :aWidget | self beHorizontal ] after: [  ] ];
		vertical: [ :aStyle | aStyle do: [ :aWidget | self beVertical ] after: [  ] ])
]

{ #category : #initialization }
BrGroupedListAptitude >> initializeListElement [
	listElement := BrInfiniteListElement new.
	listElement dataSource: BrGroupedListDataSource new.
]

{ #category : #initialization }
BrGroupedListAptitude >> initializeListeners [
	super initializeListeners.

	self when: BrItemsProviderItemsChangedEvent do: [ :anEvent | self onModelItemsChanged: anEvent ].
	self when: BrItemsProviderPromiseEnqueuedEvent do: [ :anEvent | self onModelPromiseEnqueued: anEvent ].
	self when: BrSelectionChanged do: [ :anEvent | self onSelectionChanged: anEvent indices ].
	self when: BrListItemTypeStencilChangedEvent do: [ :anEvent | self onItemTypeStencilChanged: anEvent itemTypeStencil ].
	self when: BrListItemIdStencilChangedEvent do: [ :anEvent | self onItemIdStencilChanged: anEvent itemIdStencil ].

	self when: BrGroupedListHeaderElementStencilChangedEvent do: [ :anEvent | self onHeaderElementStencilChanged: anEvent headerElementStencil ].
	self when: BrGroupedListHeaderDataBinderChangedEvent do: [ :anEvent | self onHeaderDataBinderChanged: anEvent headerDataBinder ].
	
	self initializeScrollListeners
]

{ #category : #initialization }
BrGroupedListAptitude >> initializeRequests [
	super initializeRequests.
	self requestListConfiguration
]

{ #category : #'private - accessing' }
BrGroupedListAptitude >> listElement [
	^ listElement
]

{ #category : #'api - hooks' }
BrGroupedListAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.

	self listElement dataSource 
		listModel: anElement viewModel
]

{ #category : #'private - event handling' }
BrGroupedListAptitude >> onHeaderDataBinderChanged: aBrListItemDataBinder [
	self listElement dataSource headerDataBinder: aBrListItemDataBinder
]

{ #category : #'private - event handling' }
BrGroupedListAptitude >> onHeaderElementStencilChanged: aBrListItemElementStencilBuilder [
	self listElement dataSource headerElementStencil: aBrListItemElementStencilBuilder
]

{ #category : #'private - event handling' }
BrGroupedListAptitude >> onItemIdStencilChanged: aBrListItemIdStencilBuilder [
	self listElement dataSource itemIdStencil: aBrListItemIdStencilBuilder
]

{ #category : #'private - event handling' }
BrGroupedListAptitude >> onItemTypeStencilChanged: aBrListItemTypeStencilBuilder [
	self listElement dataSource itemTypeStencil: aBrListItemTypeStencilBuilder
]

{ #category : #initialization }
BrGroupedListAptitude >> onItemsProviderDone: anEvent [ 
	
]

{ #category : #'private - event handling' }
BrGroupedListAptitude >> onModelItemsAdded: anEvent [
	self listElement enqueueTask: (BlTaskAction new action: [ self listElement dataSource notifyItemsInserted: anEvent insertedInterval ])
]

{ #category : #'private - event handling' }
BrGroupedListAptitude >> onModelItemsChanged: anEvent [
	anEvent isSynchronous
		ifTrue: [ self listElement dataSource notifyChanged ]
		ifFalse: [ self listElement enqueueTask: (BlTaskAction new action: [ self listElement dataSource notifyChanged ]) ]
]

{ #category : #'private - event handling' }
BrGroupedListAptitude >> onModelPromiseEnqueued: anEvent [
	self listElement enqueueTask: (BlPromiseTask new promise: anEvent promise)
]

{ #category : #'private - event handling' }
BrGroupedListAptitude >> onSelectionChanged: aCollectionOfIndices [
	self listElement dataSource selection: (BlCompositeSelection fromIndices: aCollectionOfIndices)
]

{ #category : #'private - updating' }
BrGroupedListAptitude >> replaceListElement: anOldListElement by: aNewListElement [
	self widgetDo: [ :aWidget |
		| aParent |
		aParent := anOldListElement parent.
		aParent replaceChild: anOldListElement with: aNewListElement as: #scrollable.
		self updateListElementParent. ]
]

{ #category : #initialization }
BrGroupedListAptitude >> requestListConfiguration [
	self request: BrSelectionRequest new.
	self request: BrListItemTypeStencilRequest new.
	self request: BrListItemIdStencilRequest new.
	self request: BrGroupedListHeaderElementStencilRequest new.
	self request: BrGroupedListHeaderDataBinderRequest new.
]

{ #category : #'private - updating' }
BrGroupedListAptitude >> updateListElementParent [
	self listElement dataSource listElement: self widgetContent
]
