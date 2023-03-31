Class {
	#name : #BrList,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TBrSelectable + TBrScrollable',
	#classTraits : 'TBrLayoutResizable classTrait + TBrSelectable classTrait + TBrScrollable classTrait',
	#instVars : [
		'selectionCallback'
	],
	#category : #'Brick-List-Elements'
}

{ #category : #accessing }
BrList class >> isAbstract [

	^ self == BrList
]

{ #category : #initialization }
BrList >> defaultListModel [
	self subclassResponsibility 
]

{ #category : #accessing }
BrList >> defaultSelectionCallback [
	^ [ :indices | 
	indices size = 1
		ifTrue: [ self viewModel itemAt: indices first ]
		ifFalse: [ indices collect: [ :anIndex | self viewModel itemAt: anIndex ] ] ]
]

{ #category : #initialization }
BrList >> initialize [
	super initialize.
	
	self matchParent.
	self beFocusable.
	self beInSeparateCompositionLayer.
	
	self selectionCallback: self defaultSelectionCallback.
	
	self viewModel: (self defaultListModel
		add: (selectionModel := BrSelectionModel new)).

	self initializeEventHandlers
]

{ #category : #initialization }
BrList >> initializeEventHandlers [
	"shortcuts only work when list has focus.
	click handler must not be added as a filter"
	self
		when: BlClickEvent do: [ :anEvent | anEvent currentTarget requestFocus ];
		when: BrListItemElementAttached do: [ :anEvent |
			(self isSelectedAt: anEvent rowIndex)
				ifTrue: [ self dispatchEvent: (BrListSelectedItemAttached new
					itemElement: anEvent itemElement;
					rowIndex: anEvent rowIndex;
					rowValue: anEvent rowValue) ] ];
		when: BrListItemElementDetached do: [ :anEvent |
			(self isSelectedAt: anEvent rowIndex)
				ifTrue: [ self dispatchEvent: (BrListSelectedItemDetached new
					rowIndex: anEvent rowIndex;
					rowValue: anEvent rowValue) ] ];
		addShortcut: (BlShortcutWithAction new
			combination: (BlKeyCombination builder arrowDown build);
			action: [ self selectNext ] );
		addShortcut: (BlShortcutWithAction new
			combination: (BlKeyCombination builder arrowUp build);
			action: [ self selectPrevious ] )
]

{ #category : #'api - selection' }
BrList >> maxSelectionIndex [
	<return: #Number>
	
	^ self viewModel entityCount
]

{ #category : #'api - selection' }
BrList >> selectedItemDo: aBlock [
	"Evaluate aBlock with the currently selected item and index"
	
	self selectedIndices
		ifNotEmpty: [ :theIndices |
			(theIndices first between: 1 and: self maxSelectionIndex)
				ifTrue: [ aBlock 
					cull: (self viewModel itemAt: theIndices first) 
					cull: theIndices first ] ]
]

{ #category : #accessing }
BrList >> selectionCallback [
	^ selectionCallback
]

{ #category : #accessing }
BrList >> selectionCallback: anObject [
	selectionCallback := anObject
]
