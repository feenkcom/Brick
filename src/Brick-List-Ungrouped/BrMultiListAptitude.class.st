Class {
	#name : #BrMultiListAptitude,
	#superclass : #BrSimpleListAptitude,
	#category : #'Brick-List-Ungrouped-Aptitudes'
}

{ #category : #accessing }
BrMultiListAptitude >> addListShortcuts: anElement [
	anElement
		addShortcut: (BlShortcutWithAction new
				name: 'Select All';
				description: 'Select all items in the list.';
				combination: BlKeyCombination primaryA;
				action: [ :anEvent | anElement selectAll ])
]

{ #category : #accessing }
BrMultiListAptitude >> initializeListElement [
	super initializeListElement.
	listElement dataSource: BrMultiListDataSource new
]

{ #category : #accessing }
BrMultiListAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.

	self addListShortcuts: anElement
]
