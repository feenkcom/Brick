Class {
	#name : #BrGlamorousEditorLightTheme,
	#superclass : #BrGlamorousEditorTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousEditorLightTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #completionPreviewBackground
		put: BrGlamorousColors editorBorderColor.
	self constantAt: #borderColor put: BrGlamorousColors editorBorderColor.

	self constantAt: #pharoDeclaredVariableForeground put: Color blue muchDarker.
	self constantAt: #pharoUndeclaredVariableForeground put: Color blue muchDarker.
	self constantAt: #pharoSelfVariableForeground put: Color cyan muchDarker.
	self constantAt: #pharoSuperVariableForeground put: Color cyan muchDarker.
	self constantAt: #pharoThisContextVariableForeground put: Color cyan muchDarker.
	self constantAt: #pharoPragmaForeground put: Color green muchDarker.
	self constantAt: #pharoReturnArrowForeground put: Color cyan muchDarker.
	self constantAt: #pharoStringLiteralForeground put: Color magenta muchDarker.
	self constantAt: #pharoSymbolLiteralForeground put: Color magenta muchDarker.
	self constantAt: #pharoNumberLiteralForeground put: Color red muchDarker.
	self constantAt: #pharoNilLiteralForeground put: Color red muchDarker.
	self constantAt: #pharoBooleanLiteralForeground put: Color red muchDarker.
	self constantAt: #pharoCharacterLiteralForeground put: Color red muchDarker.
	self constantAt: #pharoCommentForeground put: Color gray darker.
	self constantAt: #pharoErrorTokenForeground put: Color red.
	self constantAt: #enabledBreakpointForeground put: Color black.
	self constantAt: #enabledBreakpointBackground put: Color lightBrown.
	self
		constantAt: #disabledBreakpointBackground
		put: BrGlamorousColors disabledButtonBorderColor.
	self constantAt: #disabledBreakpointForeground put: Color black.
	self
		constantAt: #focusedBorderColor
		put: BrGlamorousColors focusedEditorBorderColor
]
