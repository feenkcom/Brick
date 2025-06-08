Class {
	#name : #BrGlamorousEditorDarkTheme,
	#superclass : #BrGlamorousEditorTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousEditorDarkTheme >> initializeColors [
	super initializeColors
]

{ #category : #initialization }
BrGlamorousEditorDarkTheme >> initializeConstants [
	super initializeConstants.

	self
		constantAt: #pharoDeclaredVariableForeground
		put: (Color fromHexString: '#5C7BD9').
	self
		constantAt: #pharoUndeclaredVariableForeground
		put: (Color fromHexString: '#5C7BD9').
	self
		constantAt: #pharoSelfVariableForeground
		put: (Color fromHexString: '#5EEAD4').
	self
		constantAt: #pharoSuperVariableForeground
		put: (Color fromHexString: '#5EEAD4').
	self
		constantAt: #pharoThisContextVariableForeground
		put: (Color fromHexString: '#5EEAD4')
]

{ #category : #initialization }
BrGlamorousEditorDarkTheme >> initializeThemeable [
	super initializeThemeable
]
