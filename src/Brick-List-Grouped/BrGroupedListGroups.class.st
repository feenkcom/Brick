Class {
	#name : #BrGroupedListGroups,
	#superclass : #Object,
	#instVars : [
		'groupsProvider',
		'listModel',
		'loadedGroups',
		'amountOfEntities'
	],
	#category : #'Brick-List-Grouped-Models'
}

{ #category : #'api - accessing' }
BrGroupedListGroups >> amountOfEntities [
	"Return a total amount of loaded entities in all groups. An entity can be an items or a groups header,
	it means that usually there are more entities than just items in the list"
	<return: #Number>
	
	"this will trigger the loading of items, find a cleaner way!"
	self flag: #TODO.
	groupsProvider itemCount.
	
	^ amountOfEntities
]

{ #category : #initialization }
BrGroupedListGroups >> detachFromGroupedList [
	groupsProvider finish.
	loadedGroups do: [ :eachGroup | eachGroup group itemsProvider finish ].
	groupsProvider unsubscribe: self.
]

{ #category : #'api - accessing' }
BrGroupedListGroups >> entityAt: anIndex [
	<return: #BrGroupedListEntity>
	| aGroup |
	
	"this will trigger the loading of items, find a cleaner way!"
	self flag: #TODO.
	groupsProvider itemCount.
	
	aGroup := self findGroupAt: anIndex.
	^ aGroup headerIndex = anIndex
		ifTrue: [
			BrGroupedListHeader new
				group: aGroup group;
				groupObject: aGroup domainObject ]
		ifFalse: [
			BrGroupedListItem new
				group: aGroup group;
				itemObject: (aGroup itemAt: anIndex - aGroup headerIndex) ]
]

{ #category : #'private - cache' }
BrGroupedListGroups >> fetchLoadedGroups [
	"Fetch newly loaded groups if any and return true if we detected new groups"
	<return: #Boolean>
	| amountOfLoadedGroups hasNewGroups |

	"if there are new loaded groups we should wrap them in the list specific group wrapper that
	takes care of managing indices for quick access"
	amountOfLoadedGroups := groupsProvider itemCount.

	(hasNewGroups := amountOfLoadedGroups > loadedGroups size)
		ifTrue: [
			loadedGroups size + 1 to: amountOfLoadedGroups do: [ :eachGroupIndex |
				| eachGroup eachLoadedGroup |
				eachGroup := groupsProvider itemAt: eachGroupIndex.
				eachLoadedGroup := BrGroupedListGroup new
					group: eachGroup
					groups: self.
				loadedGroups add: eachLoadedGroup ] ].
	
	^ hasNewGroups
]

{ #category : #'private - cache' }
BrGroupedListGroups >> findGroupAt: anIndex [
	<return: #'BrGroupedListGroups'>

	loadedGroups do: [ :eachLoadedGroup |
		eachLoadedGroup hasEntities ifTrue: [
			(anIndex between: eachLoadedGroup headerIndex and: eachLoadedGroup endIndex)
				ifTrue: [ ^ eachLoadedGroup ] ] ].

	self error: ('Could not find a group that contains an item with index {1}' format: { anIndex })
]

{ #category : #initialization }
BrGroupedListGroups >> groupsProvider: aBrItemsProvider listModel: aBrGroupedListModel [
	self
		assert: [ groupsProvider isKindOf: BrEmptyItemsProvider ]
		description: [ 'Groups provider can be set only once' ].

	listModel := aBrGroupedListModel.
	groupsProvider := aBrItemsProvider asBrItemsProvider.
	groupsProvider
		when: BrItemsProviderNewItemsLoadedEvent
		send: #onGroupsLoaded:
		to: self.
	groupsProvider attachToListModel: aBrGroupedListModel.
	
	loadedGroups := OrderedCollection new.
	self processLoadedData
]

{ #category : #'gt-extension' }
BrGroupedListGroups >> gtGroupsFor: aView [
	<gtView>
	
	^ aView list
		title: 'Groups';
		priority: 1;
		items: [ self loadedGroups ];
		itemText: [ :each | each domainObject gtDisplayText ]
]

{ #category : #initialization }
BrGroupedListGroups >> initialize [
	super initialize.
	
	groupsProvider := BrEmptyItemsProvider new.
	loadedGroups := OrderedCollection new.
	amountOfEntities := 0
]

{ #category : #'private - cache' }
BrGroupedListGroups >> loadedGroups [
	<return: #Collection of: #BrGroupedListGroup>

	^ loadedGroups
]

{ #category : #'private - event handling' }
BrGroupedListGroups >> notifyGroupsChanged [
	listModel notifyGroupsChanged
]

{ #category : #'private - event handling' }
BrGroupedListGroups >> onGroupsLoaded: anAnnouncement [
	self notifyGroupsChanged
]

{ #category : #'private - cache' }
BrGroupedListGroups >> processLoadedData [
	"Should be executed at most once per frame from the UI thread once one of the groups pre-loaded more items.
	Return true if the structure have changed."
	<return: #Boolean>
	| currentIndex didAnythingChange |
	
	didAnythingChange := self fetchLoadedGroups.

	currentIndex := 0.
	loadedGroups do: [ :eachLoadedGroup |
		| anAmountOfItems aNewHeaderIndex |

		didAnythingChange := eachLoadedGroup processLoadedData | didAnythingChange.
		anAmountOfItems := eachLoadedGroup amountOfItemsIncludingHeader.	
	
		aNewHeaderIndex := currentIndex + eachLoadedGroup shouldShowHeader asBit.
		didAnythingChange := (eachLoadedGroup headerIndex ~= aNewHeaderIndex) | didAnythingChange.
		eachLoadedGroup headerIndex: aNewHeaderIndex.
	
		currentIndex := currentIndex + anAmountOfItems ].

	didAnythingChange := (amountOfEntities ~= currentIndex) | didAnythingChange.
	"total amount of items"
	amountOfEntities := currentIndex.
	
	^ didAnythingChange
]
