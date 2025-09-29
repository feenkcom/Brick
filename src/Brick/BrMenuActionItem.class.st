Class {
	#name : #BrMenuActionItem,
	#superclass : #BrMenuLabeledItem,
	#instVars : [
		'action',
		'hideOnClick',
		'actionsWithModifiers'
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
BrMenuActionItem >> actionWithModifiers: aBlock [
	"Set a block that is evaluated on click events.
	It has the following arguments: [ :anElement :aButtonModel :anEvent | ]"

	self actionsWithModifiers: (self actionsWithModifiers copyWith: aBlock)
]

{ #category : #accessing }
BrMenuActionItem >> actionsWithModifiers [
	"Return a collection of blocks that are evaluated on click events with modifiers.
	Every block has the following arguments: [ :anElement :aButtonModel :anEvent | ]"

	<return: #Collection of: #BlockClosure>
	^ actionsWithModifiers
]

{ #category : #accessing }
BrMenuActionItem >> actionsWithModifiers: aCollectionOfBlocks [
	"Set a collection of blocks that are evaluated on click events with modifiers.
	Every block has the following arguments: [ :anElement :aButtonModel :anEvent | ]"

	actionsWithModifiers := aCollectionOfBlocks
]

{ #category : #accessing }
BrMenuActionItem >> definition: aBlock [
	super definition: aBlock.
	self actionWithModifiers: [ :anElement :aButtonModel :anEvent |
		anEvent modifiers isSoftAltOnly ifTrue: [
			self definition ifNotNil: [ :aDefinition |
				anElement phlow spawnObject: aDefinition ] ] ]
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
	actionsWithModifiers := #().
	hideOnClick := true
]
