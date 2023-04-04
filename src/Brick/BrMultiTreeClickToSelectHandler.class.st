Class {
	#name : #BrMultiTreeClickToSelectHandler,
	#superclass : #BrTreeClickToSelectHandler,
	#instVars : [
		'selectionStart'
	],
	#category : #'Brick-Tree - Support'
}

{ #category : #accessing }
BrMultiTreeClickToSelectHandler >> clickEvent: aBlClickEvent [
	| anItemIndex |
	anItemIndex := aBlClickEvent currentTarget constraints infinite holder
			dataSourcePosition.
	anItemIndex <= 0 ifTrue: [ ^ self ].

	aBlClickEvent modifiers isEmpty
		ifTrue: [ self selectionStart: anItemIndex.
			^ super clickEvent: aBlClickEvent ].

	aBlClickEvent modifiers isPrimaryModifier
		ifTrue: [ aBlClickEvent consumed: true.
			treeWidget requestFocus.

			(treeWidget isSelectedAt: anItemIndex)
				ifTrue: [ treeWidget removeFromSelection: anItemIndex dueTo: aBlClickEvent ]
				ifFalse: [ treeWidget addToSelection: anItemIndex dueTo: aBlClickEvent ] ].

	aBlClickEvent modifiers isShift
		ifTrue: [ aBlClickEvent consumed: true.
			treeWidget requestFocus.
			treeWidget deselectAll.
			treeWidget
				select: (self selectionStart min: anItemIndex)
				to: (self selectionStart max: anItemIndex)
				dueTo: aBlClickEvent ]
]

{ #category : #accessing }
BrMultiTreeClickToSelectHandler >> selectionStart [
	^ selectionStart
]

{ #category : #accessing }
BrMultiTreeClickToSelectHandler >> selectionStart: anObject [
	selectionStart := anObject
]
