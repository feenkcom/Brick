Class {
	#name : #BrGlamorousSpaceTabIconAptitude,
	#superclass : #BrIconAptitude,
	#category : #'Brick-Glamorous-Tabs - Space'
}

{ #category : #updating }
BrGlamorousSpaceTabIconAptitude >> updateIcon [
	self icon margin: self icon margin + (BlInsets top: 2 right: 4).
	super updateIcon.
	self
		widgetDo: [ :aTab | 
			| aForeground |
			aForeground := aTab theme label defaultTextForeground.
			self icon
				withAllChildrenBreadthFirstDo: [ :anElement | 
					(anElement geometry isKindOf: BlSvgPath)
						ifTrue: [ self class replaceBlackPaintOn: anElement with: aForeground ] ] ]
]
