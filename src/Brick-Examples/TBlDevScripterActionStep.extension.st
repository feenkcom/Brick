Extension { #name : #TBlDevScripterActionStep }

{ #category : #'*Brick-Examples' }
TBlDevScripterActionStep >> clickDrag [
	"Simulates a click / double click drag event on a target element"
	<scripterActionStep>

	^ self addStep: (BlDevScripterClickDragStep new referenceSender)
]

{ #category : #'*Brick-Examples' }
TBlDevScripterActionStep >> clickDragStep: aBlock [
	| step |
	step := self clickDrag.
	step referenceSender.
	aBlock value: step.
	step play
]
