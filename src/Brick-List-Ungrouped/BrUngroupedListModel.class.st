Class {
	#name : #BrUngroupedListModel,
	#superclass : #BrAbstractListModel,
	#instVars : [
		'itemsProvider'
	],
	#category : #'Brick-List-Ungrouped-Models'
}

{ #category : #'api - accessing' }
BrUngroupedListModel >> entityCount [
	^ self itemCount
]

{ #category : #initialization }
BrUngroupedListModel >> initialize [
	super initialize.

	itemsProvider := BrEmptyItemsProvider new
]

{ #category : #'api - accessing' }
BrUngroupedListModel >> itemAt: anIndex [
	^ self itemsProvider itemAt: anIndex
]

{ #category : #'api - accessing' }
BrUngroupedListModel >> itemCount [
	<return: #Number>

	^ self itemsProvider itemCount
]

{ #category : #'api - accessing' }
BrUngroupedListModel >> items [
	<return: #Collection of: #Object>
	
	^ itemsProvider currentItems
]

{ #category : #'api - accessing' }
BrUngroupedListModel >> items: aCollectionOfObjects [
	self itemsProvider: (BrSequenceableCollectionItemsProvider new collection: aCollectionOfObjects)
]

{ #category : #'api - accessing' }
BrUngroupedListModel >> itemsProvider [
	<return: #BrItemsProvider>
	
	^ itemsProvider
]

{ #category : #'api - accessing' }
BrUngroupedListModel >> itemsProvider: anItemsProvider [
	itemsProvider := anItemsProvider.
	itemsProvider attachToListModel: self
]
