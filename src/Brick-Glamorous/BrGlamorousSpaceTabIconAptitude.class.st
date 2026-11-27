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
			self class
				replaceBlackPaintIn: self icon
				with: aTab theme label defaultTextForeground
				matching: [ :anElement | 
					(anElement geometry isKindOf: BlSvgPath)
						or: [ anElement isKindOf: BlTextElement ] ] ]
]
