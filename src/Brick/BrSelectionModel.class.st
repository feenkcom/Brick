Class {
	#name : #BrSelectionModel,
	#superclass : #BrWidgetModel,
	#instVars : [
		'selection'
	],
	#category : #'Brick-! Core - Models'
}

{ #category : #printing }
BrSelectionModel class >> modelName [
	^ 'Selection'
]

{ #category : #'api - selection' }
BrSelectionModel >> addToSelection: anIndex dueTo: aSourceEvent [
	"Add an item at a given index to the selection"
	(self contains: anIndex)
		ifTrue: [ ^ self ].

	selection select: anIndex - 1 to: anIndex.
	self notifySelected: (anIndex to: anIndex) dueTo: aSourceEvent
]

{ #category : #'api - testing' }
BrSelectionModel >> contains: anIndex [
	"Return true if item at a given index is selected, false otherwise"
	<return: #Boolean>

	^ selection containsIndex: anIndex
]

{ #category : #'api - selection' }
BrSelectionModel >> deselect: aFromIndex to: aToIndex [
	"Deselect items within a given interval"

	selection deselect: aFromIndex - 1 to: aToIndex.
	self notifyDeselected: (aFromIndex to: aToIndex)
]

{ #category : #'api - selection' }
BrSelectionModel >> deselectAll [
	"Deselect all items"

	selection reverseDo: [ :aMonotoneSelection | self deselect: aMonotoneSelection from + 1 to: aMonotoneSelection to ]
]

{ #category : #'api - selection' }
BrSelectionModel >> deselectOne: anIndex [
	"Deselect items with a given index"

	self deselect: anIndex to: anIndex
]

{ #category : #'api - testing' }
BrSelectionModel >> hasSelection [
	<return: #Boolean>
	
	^ selection isNotEmpty
]

{ #category : #'api - accessing' }
BrSelectionModel >> indices [
	<return: #Collection of: #Number>
	
	^ selection indices
]

{ #category : #initialization }
BrSelectionModel >> initialize [
	super initialize.

	selection := BlCompositeSelection new
]

{ #category : #hooks }
BrSelectionModel >> initializeListeners [
	super initializeListeners.

	self when: BrSelectionRequest reply: [ :aResponse | aResponse selection: selection ]
]

{ #category : #notifying }
BrSelectionModel >> notifyDeselected: anInterval [
	self dispatchEvent: (BrSelectionChanged new selection: selection; deselectedInterval: anInterval)
]

{ #category : #notifying }
BrSelectionModel >> notifySelected: anInterval [
	self
		notifySelected: anInterval
		dueTo: nil
]

{ #category : #notifying }
BrSelectionModel >> notifySelected: anInterval dueTo: aSourceEvent [
	self dispatchEvent: (BrSelectionChanged new selection: selection; selectedInterval: anInterval; sourceEvent: aSourceEvent)
]

{ #category : #'api - selection' }
BrSelectionModel >> removeFromSelection: anIndex dueTo: aSourceEvent [
	"Remove an item at a given index from the selection"
	(self contains: anIndex)
		ifFalse: [ ^ self ].

	selection deselect: anIndex - 1 to: anIndex.
	self notifySelected: (anIndex to: anIndex) dueTo: aSourceEvent
]

{ #category : #'api - selection' }
BrSelectionModel >> select: aFromIndex to: aToIndex [
	"Select items within a given interval"

	self
		select: aFromIndex
		to: aToIndex
		dueTo: nil
]

{ #category : #'api - selection' }
BrSelectionModel >> select: aFromIndex to: aToIndex dueTo: aSourceEvent [
	"Select items within a given interval"

	selection select: aFromIndex - 1 to: aToIndex.
	self notifySelected: (aFromIndex to: aToIndex) dueTo: aSourceEvent
]

{ #category : #'api - selection' }
BrSelectionModel >> selectOne: anIndex [
	"Select an item at a given index deselecting all previously selected items"
	
	self
		selectOne: anIndex
		dueTo: nil
]

{ #category : #'api - selection' }
BrSelectionModel >> selectOne: anIndex dueTo: aSourceEvent [
	"Select an item at a given index deselecting all previously selected items"
	| aSelectionCopy |

	self
		assert: [ anIndex > 0 ]
		description: [ 'Selection index must be greater than 0' ].

	aSelectionCopy := selection copy.
	aSelectionCopy deselect: anIndex - 1 to: anIndex.

	aSelectionCopy do: [ :aMonotoneSelection | self deselect: aMonotoneSelection from + 1 to: aMonotoneSelection to ].

	(self contains: anIndex)
		ifTrue: [ ^ self ].

	selection select: anIndex - 1 to: anIndex.
	self notifySelected: (anIndex to: anIndex) dueTo: aSourceEvent
]

{ #category : #'api - selection' }
BrSelectionModel >> selectSeveral: someIndexes [
	"Select items of the given indexes"

	self selectSeveral: someIndexes dueTo: nil
]

{ #category : #'api - selection' }
BrSelectionModel >> selectSeveral: someIndexes dueTo: aSourceEvent [
	"Select items of the given indexes"

	self deselectAll.
	someIndexes do: [ :eachIndex | selection select: eachIndex - 1 to: eachIndex ].
	self notifySelected: someIndexes dueTo: aSourceEvent
]
