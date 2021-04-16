Class {
	#name : #BrThemeChangingBackgroundElementProperty,
	#superclass : #BlElementBackgroundProperty,
	#category : #'Brick-Theme-Examples-Brick-Theme-Examples'
}

{ #category : #accessing }
BrThemeChangingBackgroundElementProperty >> applyOnElement: anElement [
	anElement background: (background:=Color random)
]

{ #category : #accessing }
BrThemeChangingBackgroundElementProperty >> type [
	^ background hash
]
