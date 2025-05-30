Class {
	#name : #BrGroupedListMultiClickSelectHandler,
	#superclass : #BrListClickToSelectHandler,
	#instVars : [
		'selectionStart'
	],
	#category : #'Brick-List-Grouped-Support'
}

{ #category : #'api - event managing' }
BrGroupedListMultiClickSelectHandler >> clickEvent: aBlClickEvent [
	| anItemIndex |
	anItemIndex := aBlClickEvent currentTarget constraints infinite holder
			dataSourcePosition.
	anItemIndex <= 0 ifTrue: [ ^ self ].

	aBlClickEvent modifiers isEmpty
		ifTrue: [ self selectionStart: anItemIndex.
			^ super clickEvent: aBlClickEvent ].

	aBlClickEvent modifiers isPrimaryModifier
		ifTrue: [ aBlClickEvent consumed: true.
			listWidget requestFocus.

			(listWidget isSelectedAt: anItemIndex)
				ifTrue: [ listWidget removeFromSelection: anItemIndex dueTo: aBlClickEvent ]
				ifFalse: [ listWidget addToSelection: anItemIndex dueTo: aBlClickEvent ] ].

	aBlClickEvent modifiers isShift
		ifTrue: [ aBlClickEvent consumed: true.
			listWidget requestFocus.
			listWidget
				selectSeveral: ((self selectionStart min: anItemIndex)
						to: (self selectionStart max: anItemIndex))
				dueTo: aBlClickEvent ]
]

{ #category : #initialization }
BrGroupedListMultiClickSelectHandler >> initialize [
	self selectionStart: 1
]

{ #category : #accessing }
BrGroupedListMultiClickSelectHandler >> selectionStart [
	^ selectionStart
]

{ #category : #accessing }
BrGroupedListMultiClickSelectHandler >> selectionStart: anInteger [
	selectionStart := anInteger
]
