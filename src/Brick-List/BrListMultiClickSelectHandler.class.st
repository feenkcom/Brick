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

	aBlClickEvent modifiers isEmpty
		ifTrue: [ self selectionStart: anItemIndex.
			^ super clickEvent: aBlClickEvent ].

	aBlClickEvent modifiers isCmd
		ifTrue: [ aBlClickEvent consumed: true.
			listWidget requestFocus.

			(listWidget isSelectedAt: anItemIndex)
				ifTrue: [ listWidget removeFromSelection: anItemIndex dueTo: aBlClickEvent ]
				ifFalse: [ listWidget addToSelection: anItemIndex dueTo: aBlClickEvent ] ].

	aBlClickEvent modifiers isShift
		ifTrue: [ aBlClickEvent consumed: true.
			listWidget requestFocus.
			listWidget deselectAll.
			listWidget
				select: (self selectionStart min: anItemIndex)
				to: (self selectionStart max: anItemIndex)
				dueTo: aBlClickEvent ]
]

{ #category : #accessing }
BrListMultiClickSelectHandler >> initialize [
	self selectionStart: 1
]

{ #category : #accessing }
BrListMultiClickSelectHandler >> selectionStart [
	^ selectionStart
]

{ #category : #accessing }
BrListMultiClickSelectHandler >> selectionStart: anObject [
	selectionStart := anObject
]
