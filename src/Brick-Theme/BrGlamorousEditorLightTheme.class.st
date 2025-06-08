Class {
	#name : #BrGlamorousEditorLightTheme,
	#superclass : #BrGlamorousEditorTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousEditorLightTheme >> initializeColors [
	super initializeColors
]

{ #category : #initialization }
BrGlamorousEditorLightTheme >> initializeConstants [
	super initializeConstants.

	self constantAt: #pharoDeclaredVariableForeground put: Color blue muchDarker.
	self constantAt: #pharoUndeclaredVariableForeground put: Color blue muchDarker.
	self constantAt: #pharoSelfVariableForeground put: Color cyan muchDarker.
	self constantAt: #pharoSuperVariableForeground put: Color cyan muchDarker.
	self constantAt: #pharoThisContextVariableForeground put: Color cyan muchDarker
]

{ #category : #initialization }
BrGlamorousEditorLightTheme >> initializeThemeable [
	super initializeThemeable
]
