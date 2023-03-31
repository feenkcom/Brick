Trait {
	#name : #TBrSelectable,
	#instVars : [
		'selectionModel'
	],
	#category : #'Brick-! Core - Support'
}

{ #category : #'api - selection' }
TBrSelectable >> addToSelection: anIndex dueTo: aSourceEvent [
	selectionModel addToSelection: anIndex dueTo: aSourceEvent
]

{ #category : #'api - selection' }
TBrSelectable >> deselectAll [
	"Deselect all items"

	selectionModel deselectAll
]

{ #category : #'api - selection' }
TBrSelectable >> deselectOne: anIndex [
	selectionModel deselectOne: anIndex
]

{ #category : #'api - selection' }
TBrSelectable >> isSelectedAt: anIndex [
	<return: #Boolean>

	^ selectionModel contains: anIndex
]

{ #category : #'api - selection' }
TBrSelectable >> maxSelectionIndex [
	<return: #Number>
	
	^ self explicitRequirement
]

{ #category : #'api - selection' }
TBrSelectable >> removeFromSelection: anIndex dueTo: aSourceEvent [
	selectionModel removeFromSelection: anIndex dueTo: aSourceEvent
]

{ #category : #'api - selection' }
TBrSelectable >> select: anIndex to: anotherIndex dueTo: aSourceEvent [
	selectionModel select: anIndex to: anotherIndex dueTo: aSourceEvent
]

{ #category : #'api - selection' }
TBrSelectable >> selectAll [
	"Select all items"

	selectionModel select: 1 to: self maxSelectionIndex
]

{ #category : #'api - selection' }
TBrSelectable >> selectNext [
	self selectedIndices
		ifEmpty: [ self selectOne: 1  ]
		ifNotEmpty: [ :theIndices | self selectOne: (theIndices first + 1 min: self maxSelectionIndex) ]
]

{ #category : #'api - selection' }
TBrSelectable >> selectOne: anIndex [
	selectionModel selectOne: anIndex
]

{ #category : #'api - selection' }
TBrSelectable >> selectOne: anIndex dueTo: aSourceEvent [
	selectionModel selectOne: anIndex dueTo: aSourceEvent
]

{ #category : #'api - selection' }
TBrSelectable >> selectPrevious [
	self selectedIndices
		ifEmpty: [ self selectOne: 1  ]
		ifNotEmpty: [ :theIndices | self selectOne: (theIndices first - 1 max: 1) ]
]

{ #category : #'api - selection' }
TBrSelectable >> selectedIndices [
	"Return a collection of selected indices"
	<return: #Collection of: #Number>

	^ selectionModel indices
]
