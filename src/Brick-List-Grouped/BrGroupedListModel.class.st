Class {
	#name : #BrGroupedListModel,
	#superclass : #BrAbstractListModel,
	#instVars : [
		'groups',
		'headerElementStencil',
		'headerDataBinder'
	],
	#category : #'Brick-List-Grouped-Models'
}

{ #category : #'api - accessing' }
BrGroupedListModel >> entityAt: anIndex [
	^ groups entityAt: anIndex
]

{ #category : #'api - accessing' }
BrGroupedListModel >> entityCount [
	^ groups amountOfEntities
]

{ #category : #'api - accessing' }
BrGroupedListModel >> groupsProvider: aBrAbstractListItemsProvider [

	"stop the preloading of the previous groups"
	self flag: #TODO.
	
	groups ifNotNil: [ :thePreviousGroups | thePreviousGroups detachFromGroupedList ].
	groups := BrGroupedListGroups new
		groupsProvider: aBrAbstractListItemsProvider asBrItemsProvider
		listModel: self
]

{ #category : #'api - accessing' }
BrGroupedListModel >> headerDataBinder [
	"Return a stencil that is used to bind data to a given group's header element"
	<return: #BrListItemDataBinder>

	^ headerDataBinder
]

{ #category : #'api - accessing' }
BrGroupedListModel >> headerDataBinder: aStencil [
	"Set a stencil that will be used to bind data to a given group's header element"

	headerDataBinder := aStencil asStencilBuilder: BrListItemDataBinder.
	self dispatchEvent: (BrGroupedListHeaderDataBinderChangedEvent new headerDataBinder: headerDataBinder)
]

{ #category : #'api - accessing' }
BrGroupedListModel >> headerElementStencil [
	"Return a stencil that is used to create a group's header element of a given type"
	<return: #BrListItemElementStencilBuilder>
	
	^ headerElementStencil
]

{ #category : #'api - accessing' }
BrGroupedListModel >> headerElementStencil: aStencil [
	"Set a stencil that will be used to create a group's header element of a given type"

	headerElementStencil := aStencil asStencilBuilder: BrListItemElementStencilBuilder.
	self dispatchEvent: (BrGroupedListHeaderElementStencilChangedEvent new headerElementStencil: headerElementStencil)
]

{ #category : #initialization }
BrGroupedListModel >> initializeListeners [
	super initializeListeners.

	self when: BrGroupedListHeaderElementStencilRequest reply: [ :aResponse | aResponse headerElementStencil: self headerElementStencil ].
	self when: BrGroupedListHeaderDataBinderRequest reply: [ :aResponse | aResponse headerDataBinder: self headerDataBinder ].
]

{ #category : #'private - event handling' }
BrGroupedListModel >> notifyGroupsChanged [
	"Notify listeners that the structure of the groups have changed and we should recalculate loaded interval and refresh the cache.
	Announcement listeners should not make any assumption about the thread from which an announcement is emitted"

	self dispatchEvent: BrGroupedListGroupsChanged new
]

{ #category : #'private - cache' }
BrGroupedListModel >> processLoadedData [
	"Should be executed at most once per frame from the UI thread once one of the groups pre-loaded more items"
	| didDataChange |
	
	didDataChange := groups processLoadedData.
	didDataChange
		ifFalse: [ ^ didDataChange ].

	self dispatchEvent: (BrItemsProviderItemsChangedEvent new
		viewModel: self;
		isSynchronous: true).
		
	^ didDataChange
]
