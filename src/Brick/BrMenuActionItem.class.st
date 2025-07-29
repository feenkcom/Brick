Class {
	#name : #BrMenuActionItem,
	#superclass : #BrMenuLabeledItem,
	#instVars : [
		'action',
		'hideOnClick',
		'actionWithModifiers'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #visiting }
BrMenuActionItem >> acceptVisitor: aVisitor [
	^ aVisitor visitMenuActionItem: self
]

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

{ #category : #accessing }
BrMenuActionItem >> actionWithModifiers [
	^ actionWithModifiers
]

{ #category : #accessing }
BrMenuActionItem >> actionWithModifiers: aBlock [
	"Set a block that is evaluated on click events.
	It has the following arguments: [ :anElement :aButtonModel :anEvent | ]"

	actionWithModifiers := aBlock
]

{ #category : #accessing }
BrMenuActionItem >> definition: aBlock [
	super definition: aBlock.
	self actionWithModifiers: [ :anElement :aButtonModel :anEvent |
		self definition ifNotNil: [ :aDefinition |
			anElement phlow spawnObject: aDefinition ] ]
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
	actionWithModifiers := [ :anElement :aButtonModel :anEvent | ].
	hideOnClick := true
]
