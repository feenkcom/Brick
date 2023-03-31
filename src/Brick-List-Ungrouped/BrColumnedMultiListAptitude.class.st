Class {
	#name : #BrColumnedMultiListAptitude,
	#superclass : #BrColumnedListAptitude,
	#category : #'Brick-List-Ungrouped-Aptitudes'
}

{ #category : #accessing }
BrColumnedMultiListAptitude >> addListShortcuts: anElement [
	anElement
		addShortcut: (BlShortcutWithAction new
				name: 'Select All';
				description: 'Select all items in the list.';
				combination: BlKeyCombination primaryA;
				action: [ :anEvent | anElement selectAll ])
]

{ #category : #accessing }
BrColumnedMultiListAptitude >> initialize [
	super initialize.
	listElement
		dataSource: (BrColumnedMultiListDataSource new rowDataBinder: BrDefaultListRowDataBinder new)
]

{ #category : #accessing }
BrColumnedMultiListAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.

	self addListShortcuts: anElement
]
