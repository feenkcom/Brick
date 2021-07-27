Class {
	#name : 'BrColumnedTreeAptitude',
	#superclass : 'BrTreeAptitude',
	#category : 'Brick-Tree - Aptitude'
}

{ #category : 'initialization' }
BrColumnedTreeAptitude >> initialize [
	super initialize.

	treeElement dataSource: BrColumnedTreeDataSource new.
	treeElement dataSource
		rowElementStencil: BrColumnedTreeRowElementStencilBuilder new;
		rowDataBinder: BrDefaultTreeRowDataBinder new
]

{ #category : 'initialization' }
BrColumnedTreeAptitude >> initializeListeners [
	super initializeListeners.

	self when: BrColumnsChanged do: [ :anEvent | self onColumnsChanged: anEvent columns ].
	self
		when: BrTreeRowElementStencilChangedEvent
		do: [ :anEvent | self onRowElementStencilChanged: anEvent rowElementStencil ].
		
	self
		when: BrTreeRowDataBinderChangedEvent
		do: [ :anEvent | self onRowDataBinderChanged: anEvent rowDataBinder ].
]

{ #category : 'initialization' }
BrColumnedTreeAptitude >> initializeRequests [
	super initializeRequests.

	self request: BrColumnsRequest new.
	self request: BrTreeRowElementStencilRequest new.
	self request: BrTreeRowDataBinderRequest new.
]

{ #category : 'hooks' }
BrColumnedTreeAptitude >> onColumnsChanged: aCollectionOfBrListColumns [
	treeElement dataSource columns: aCollectionOfBrListColumns
]

{ #category : 'hooks' }
BrColumnedTreeAptitude >> onRowDataBinderChanged: aBrTreeRowDataBinder [
	treeElement dataSource rowDataBinder: aBrTreeRowDataBinder
]

{ #category : 'hooks' }
BrColumnedTreeAptitude >> onRowElementStencilChanged: aBrTreeRowElementStencilBuilder [
	treeElement dataSource rowElementStencil: aBrTreeRowElementStencilBuilder
]

{ #category : 'as yet unclassified' }
BrColumnedTreeAptitude >> withoutSelection [
	treeElement dataSource supportsSelection: false
]
