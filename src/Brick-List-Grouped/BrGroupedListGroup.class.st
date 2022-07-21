Class {
	#name : #BrGroupedListGroup,
	#superclass : #Object,
	#instVars : [
		'group',
		'groups',
		'amountOfItems',
		'headerIndex'
	],
	#category : #'Brick-List-Grouped-Models'
}

{ #category : #'private - cache' }
BrGroupedListGroup >> amountOfItems [
	^ amountOfItems
]

{ #category : #'private - cache' }
BrGroupedListGroup >> amountOfItemsIncludingHeader [
	"Return an amount of items in the group including header if needed.
	Some groups may want to hide a header if there are no items"
	<return: #Number>
	| anAmountOfItems |
	
	anAmountOfItems := amountOfItems.
	^ (anAmountOfItems isZero and: [ group shouldShowWithoutItems not ])
		ifTrue: [ 0 ]
		ifFalse: [ anAmountOfItems + 1 ]
]

{ #category : #accessing }
BrGroupedListGroup >> domainObject [
	^ group domainObject
]

{ #category : #'private - cache' }
BrGroupedListGroup >> endIndex [
	^ self headerIndex + self amountOfItems
]

{ #category : #accessing }
BrGroupedListGroup >> group [

	^ group
]

{ #category : #accessing }
BrGroupedListGroup >> group: aBrGroup groups: aBrGroupedListGroups [
	groups := aBrGroupedListGroups.
	
	group := aBrGroup.
	group itemsProvider
		when: BrItemsProviderNewItemsLoadedEvent
		send: #onItemsLoaded:
		to: self.
	amountOfItems := group itemsProvider itemCount
]

{ #category : #'private - cache' }
BrGroupedListGroup >> hasEntities [
	^ self shouldShowHeader
]

{ #category : #'private - cache' }
BrGroupedListGroup >> headerIndex [
	^ headerIndex
]

{ #category : #'private - cache' }
BrGroupedListGroup >> headerIndex: aNumber [
	headerIndex := aNumber
]

{ #category : #initialization }
BrGroupedListGroup >> initialize [
	super initialize.

	"inst.vars related to caches and performance optimizations"
	amountOfItems := 0.
	headerIndex := 1
]

{ #category : #accessing }
BrGroupedListGroup >> itemAt: anIndex [
	self
		assert: [ anIndex > 0 ]
		description: [ 'Index must be positive' ].
		
	^ group itemsProvider itemAt: anIndex
]

{ #category : #'private - event handling' }
BrGroupedListGroup >> onItemsLoaded: anAnnouncement [
	groups notifyGroupsChanged
]

{ #category : #'private - cache' }
BrGroupedListGroup >> processLoadedData [
	amountOfItems := group itemsProvider itemCount
]

{ #category : #'private - cache' }
BrGroupedListGroup >> shouldShowHeader [
	^ group shouldShowWithoutItems or: [ amountOfItems > 0 ]
]
