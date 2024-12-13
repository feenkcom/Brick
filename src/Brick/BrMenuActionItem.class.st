Class {
	#name : #BrMenuActionItem,
	#superclass : #BrMenuLabeledItem,
	#instVars : [
		'action',
		'hideOnClick'
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

{ #category : #accessing }
BrMenuActionItem >> hideOnClick [
	<return: #Boolean>
	^ hideOnClick ifNil: [ true ]
]

{ #category : #accessing }
BrMenuActionItem >> hideOnClick: aBoolean [
	hideOnClick := aBoolean
]

{ #category : #initialization }
BrMenuActionItem >> initialize [
	super initialize.
	
	action := [ :anElement :aButtonModel :anEvent | ].
	hideOnClick := true
]

{ #category : #'event handling' }
BrMenuActionItem >> onClick: anEvent element: anElement model: aButtonModel [
	self action ifNil: [ ^ self ].
	self action gtValueWithArgs: { anElement. aButtonModel. anEvent }.
	self hideOnClick ifTrue: [ self hideAll ]
]
