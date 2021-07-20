Class {
	#name : 'BrListModelItemsAddedEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'firstAddedItemIndex',
		'addedItemsCount'
	],
	#category : 'Brick-List - Events'
}

{ #category : 'accessing' }
BrListModelItemsAddedEvent >> addedItemsCount [
	^ addedItemsCount
]

{ #category : 'accessing' }
BrListModelItemsAddedEvent >> addedItemsCount: anInteger [
	addedItemsCount := anInteger
]

{ #category : 'accessing' }
BrListModelItemsAddedEvent >> firstAddedItemIndex [
	^ firstAddedItemIndex
]

{ #category : 'accessing' }
BrListModelItemsAddedEvent >> firstAddedItemIndex: anInteger [
	firstAddedItemIndex := anInteger
]
