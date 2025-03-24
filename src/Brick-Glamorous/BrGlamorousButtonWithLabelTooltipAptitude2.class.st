Class {
	#name : #BrGlamorousButtonWithLabelTooltipAptitude2,
	#superclass : #BrGlamorousWithExplicitTooltipAptitude,
	#category : #'Brick-Glamorous-Buttons'
}

{ #category : #initialization }
BrGlamorousButtonWithLabelTooltipAptitude2 >> initializeListeners [
	super initializeListeners.
	self when: BrLabelChanged do: [ :anEvent | self text: anEvent text ]
]

{ #category : #initialization }
BrGlamorousButtonWithLabelTooltipAptitude2 >> initializeRequests [
	super initializeRequests.
	self request: BrLabelRequest new
]

{ #category : #'instance creation' }
BrGlamorousButtonWithLabelTooltipAptitude2 >> newMenuModelWithLabel: aLabelString shortcut: aShortcutString [
	| aMenuModel aDecoratingModel |
	aMenuModel := super
			newMenuModelWithLabel: aLabelString
			shortcut: aShortcutString.
	aDecoratingModel := BrMenuDecoratoringModel new
			menuModel: aMenuModel;
			decorator: [ :aMenuElement | 
				aMenuElement
					when: BlClickEvent
					do: [ :anEvent | 
						self widgetDo: [ :aWidget | 
							aWidget phlow spawnObject: aWidget action ] ] ].
	^ aDecoratingModel
]
