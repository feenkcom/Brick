Class {
	#name : #BrAnchoredPositioner,
	#superclass : #Object,
	#instVars : [
		'target',
		'anchor',
		'anchorBoundsInTarget',
		'popupPreferredMaxBoundsInTarget',
		'popupPreferredPosition',
		'extent'
	],
	#category : #'Brick-Anchored - Support'
}

{ #category : #'as yet unclassified' }
BrAnchoredPositioner class >> anchor: anElement target: anotherElement [
	^ self new
		anchor: anElement;
		target: anotherElement;
		yourself
]

{ #category : #'as yet unclassified' }
BrAnchoredPositioner class >> anchorBoundsInTarget: aBounds target: anotherElement [
	^ self new
		anchorBoundsInTarget: aBounds;
		target: anotherElement;
		yourself
]

{ #category : #accessing }
BrAnchoredPositioner >> anchor [
	^ anchor
]

{ #category : #accessing }
BrAnchoredPositioner >> anchor: anObject [
	anchor := anObject
]

{ #category : #accessing }
BrAnchoredPositioner >> anchorBoundsInTarget [
	^ anchorBoundsInTarget ifNil: [ self computeAnchorBoundsInTarget ]
]

{ #category : #accessing }
BrAnchoredPositioner >> anchorBoundsInTarget: anObject [
	anchorBoundsInTarget := anObject
]

{ #category : #private }
BrAnchoredPositioner >> computeAnchorBoundsInTarget [
	^ anchor
		ifNotNil: [ anchorBoundsInTarget := anchor bounds inSpace inChild: target ]
]

{ #category : #accessing }
BrAnchoredPositioner >> computePopupPreferredMaxBoundsInTarget: anExtent [
	<return: #BrAnchoredPositionerPopupPreferredMaxBounds>

	| newBounds allPopupBounds fallback |
	newBounds := self maxBoundsBottomRightInTarget.
	newBounds extent >= anExtent
		ifTrue: [ ^ BrAnchoredPositionerPopupPreferredMaxBounds
				position: #bottom -> #right
				bounds: newBounds ].

	allPopupBounds := OrderedCollection new.
	allPopupBounds add: #bottom -> #right -> newBounds.

	newBounds := self maxBoundsBottomLeftInTarget.
	newBounds extent >= anExtent
		ifTrue: [ ^ BrAnchoredPositionerPopupPreferredMaxBounds
				position: #bottom -> #left
				bounds: newBounds ].

	allPopupBounds add: #bottom -> #left -> newBounds.

	newBounds := self maxBoundsTopRightInTarget.
	newBounds extent >= anExtent
		ifTrue: [ ^ BrAnchoredPositionerPopupPreferredMaxBounds
				position: #top -> #right
				bounds: newBounds ].

	allPopupBounds add: #top -> #right -> newBounds.

	newBounds := self maxBoundsTopLeftInTarget.
	newBounds extent >= anExtent
		ifTrue: [ ^ BrAnchoredPositionerPopupPreferredMaxBounds
				position: #top -> #left
				bounds: newBounds ].
	allPopupBounds add: #top -> #left -> newBounds.

	fallback := (allPopupBounds
			sorted: [ :a :b | a value asRectangle area >= b value asRectangle area ])
			first.

	^ BrAnchoredPositionerPopupPreferredMaxBounds
		position: fallback key
		bounds: fallback value
]

{ #category : #'as yet unclassified' }
BrAnchoredPositioner >> maxBoundsBottomLeftInTarget [
	^ BlBounds
		origin: 0.0 @ self anchorBoundsInTarget bottom
		corner: self anchorBoundsInTarget right @ target size y
]

{ #category : #'as yet unclassified' }
BrAnchoredPositioner >> maxBoundsBottomRightInTarget [
	^ BlBounds
		origin: self anchorBoundsInTarget bottomLeft
		corner: target size
]

{ #category : #accessing }
BrAnchoredPositioner >> maxBoundsPreferredInTarget: anExtent [
	"Initializes #popupPreferredMaxBoundsInTarget and #popupPreferredPosition"

	| aResult |
	popupPreferredMaxBoundsInTarget ifNotNil: [ ^ popupPreferredMaxBoundsInTarget ].

	aResult := self computePopupPreferredMaxBoundsInTarget: anExtent.
	popupPreferredMaxBoundsInTarget := aResult bounds.
	popupPreferredPosition := aResult position.
	extent := anExtent.

	^ popupPreferredMaxBoundsInTarget
]

{ #category : #'as yet unclassified' }
BrAnchoredPositioner >> maxBoundsTopLeftInTarget [
	^ BlBounds origin: 0.0 @ 0.0 corner: self anchorBoundsInTarget topRight
]

{ #category : #'as yet unclassified' }
BrAnchoredPositioner >> maxBoundsTopRightInTarget [
	^ BlBounds
		origin: self anchorBoundsInTarget left @ 0.0
		corner: target bounds width @ self anchorBoundsInTarget top
]

{ #category : #'as yet unclassified' }
BrAnchoredPositioner >> positionPreferred [
	"Answers an association of symbols, e.g. #top->#right, to denote the relative position of the popup to the anchor.
	Requires #popupPreferredMaxBoundsInTarget: to be called before to initialize it, answers nil otherwise."

	^ popupPreferredPosition
]

{ #category : #'as yet unclassified' }
BrAnchoredPositioner >> positionPreferredIsBottom [
	^ popupPreferredPosition key = #bottom
]

{ #category : #'as yet unclassified' }
BrAnchoredPositioner >> positionPreferredIsLeft [
	^ popupPreferredPosition value = #left
]

{ #category : #'as yet unclassified' }
BrAnchoredPositioner >> positionPreferredIsRight [
	^ popupPreferredPosition value = #right
]

{ #category : #'as yet unclassified' }
BrAnchoredPositioner >> positionPreferredIsTop [
	^ popupPreferredPosition key = #top
]

{ #category : #accessing }
BrAnchoredPositioner >> target [
	^ target
]

{ #category : #accessing }
BrAnchoredPositioner >> target: anObject [
	target := anObject
]
