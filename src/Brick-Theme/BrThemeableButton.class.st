Class {
	#name : #BrThemeableButton,
	#superclass : #BrButton,
	#traits : 'TBrThemeable',
	#classTraits : 'TBrThemeable classTrait',
	#category : #'Brick-Theme-Brick-Theme'
}

{ #category : #accessing }
BrThemeableButton >> dispatchThemeChanged [
	super dispatchThemeChanged.
	themeLook ifNotNil: [ self removeAptitude: themeLook ].
	self aptitude: (themeLook := self theme newLookFor: self)
]

{ #category : #accessing }
BrThemeableButton >> onAddedToSceneGraph [
	self aptitude
		ifNil: [ self aptitude: (themeLook := self theme newLookFor: self) ].
	super onAddedToSceneGraph
]
