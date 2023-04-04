Class {
	#name : #BrMultiTreeAptitude,
	#superclass : #BrSimpleTreeAptitude,
	#category : #'Brick-Tree - Aptitude'
}

{ #category : #accessing }
BrMultiTreeAptitude >> addTreeShortcuts: anElement [
	anElement
		addShortcut: (BlShortcutWithAction new
				name: 'Select All';
				description: 'Select all items in the list.';
				combination: BlKeyCombination primaryA;
				action: [ :anEvent | anElement selectAll ])
]

{ #category : #accessing }
BrMultiTreeAptitude >> initialize [
	super initialize.
	treeElement
		dataSource: (BrMultiTreeDataSource new
				rowElementStencil: BrColumnedTreeRowElementStencilBuilder new;
				rowDataBinder: BrDefaultTreeRowDataBinder new)
]

{ #category : #accessing }
BrMultiTreeAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.

	self addTreeShortcuts: anElement
]
