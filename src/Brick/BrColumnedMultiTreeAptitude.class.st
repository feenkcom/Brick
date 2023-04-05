Class {
	#name : #BrColumnedMultiTreeAptitude,
	#superclass : #BrColumnedTreeAptitude,
	#category : #'Brick-Tree - Aptitude'
}

{ #category : #accessing }
BrColumnedMultiTreeAptitude >> addTreeShortcuts: anElement [
	anElement
		addShortcut: (BlShortcutWithAction new
				name: 'Select All';
				description: 'Select all items in the list.';
				combination: BlKeyCombination primaryA;
				action: [ :anEvent | anElement selectAll ])
]

{ #category : #accessing }
BrColumnedMultiTreeAptitude >> initialize [
	super initialize.
	treeElement
		dataSource: (BrColumnedMultiTreeDataSource new
				rowElementStencil: BrColumnedTreeRowElementStencilBuilder new;
				rowDataBinder: BrDefaultTreeRowDataBinder new)
]

{ #category : #accessing }
BrColumnedMultiTreeAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.

	self addTreeShortcuts: anElement
]
