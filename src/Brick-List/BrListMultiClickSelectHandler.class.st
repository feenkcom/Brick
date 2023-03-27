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

	self selectionStart
		ifNotNil: [ aBlClickEvent consumed: true.
			listWidget requestFocus.
			listWidget
				select: (self selectionStart min: anItemIndex)
				to: (self selectionStart max: anItemIndex)
				dueTo: aBlClickEvent.
			self selectionStart: nil.
			^ self ].

	aBlClickEvent modifiers isEmpty ifTrue: [ ^ super clickEvent: aBlClickEvent ].


	aBlClickEvent modifiers isCtrl
		ifTrue: [ aBlClickEvent consumed: true.
			listWidget requestFocus.
			self selectionStart: anItemIndex ]
]

{ #category : #accessing }
BrListMultiClickSelectHandler >> selectionStart [
	^ selectionStart
]

{ #category : #accessing }
BrListMultiClickSelectHandler >> selectionStart: anObject [
	selectionStart := anObject
]
