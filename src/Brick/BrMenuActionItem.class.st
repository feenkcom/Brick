Class {
	#name : #BrMenuActionItem,
	#superclass : #BrMenuLabeledItem,
	#instVars : [
		'action'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #accessing }
BrMenuActionItem >> action [
	^ action
]

{ #category : #accessing }
BrMenuActionItem >> action: aBlock [
	"Set a block that is evaluated on click events.
	It has the following arguments: [ :anElement :aButtonModel :anEvent | ]"

	action := aBlock
]

{ #category : #'api - converting' }
BrMenuActionItem >> elementType [
	^ BrMenuActionItemElement
]
