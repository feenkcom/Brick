Class {
	#name : #BrListMultiClickSelectHandler,
	#superclass : #BrListClickToSelectHandler,
	#instVars : [
		'selectionStart'
	],
	#category : #'Brick-List-Support'
}

{ #category : #accessing }
BrListMultiClickSelectHandler >> clickEvent: aBlClickEvent [
	| anItemIndex |
	anItemIndex := aBlClickEvent currentTarget constraints infinite holder
			dataSourcePosition.
	anItemIndex <= 0 ifTrue: [ ^ self ].

	aBlClickEvent modifiers isEmpty ifTrue: [ ^ super clickEvent: aBlClickEvent ].

	aBlClickEvent modifiers isCmd
		ifTrue: [ aBlClickEvent consumed: true.
			listWidget requestFocus.
			listWidget addToSelection: anItemIndex dueTo: aBlClickEvent ].

	aBlClickEvent modifiers isShift
		ifTrue: [ | selectedIndex |
			aBlClickEvent consumed: true.
			listWidget requestFocus.
			selectedIndex := listWidget selectedIndices min.
			listWidget deselectAll.
			listWidget
				select: (selectedIndex min: anItemIndex)
				to: (selectedIndex max: anItemIndex)
				dueTo: aBlClickEvent ]
]
