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
		put: (Color fromHexString: '#5EEAD4').
	self constantAt: #pharoPragmaForeground put: Color green muchDarker.
	self constantAt: #pharoReturnArrowForeground put: Color cyan muchDarker.
	self constantAt: #pharoStringLiteralForeground put: Color magenta muchDarker.
	self constantAt: #pharoSymbolLiteralForeground put: Color magenta muchDarker.
	self constantAt: #pharoNumberLiteralForeground put: Color red muchDarker.
	self constantAt: #pharoNilLiteralForeground put: Color red muchDarker.
	self constantAt: #pharoBooleanLiteralForeground put: Color red muchDarker.
	self constantAt: #pharoCharacterLiteralForeground put: Color red muchDarker.
	self constantAt: #pharoCommentForeground put: Color gray darker.
	self constantAt: #pharoErrorTokenForeground put: Color red
]

{ #category : #initialization }
BrGlamorousEditorDarkTheme >> initializeThemeable [
	super initializeThemeable
]
