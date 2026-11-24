Class {
	#name : #BrGlamorousEditorDarkTheme,
	#superclass : #BrGlamorousEditorTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousEditorDarkTheme >> initializeConstants [
	super initializeConstants.

	self constantAt: #pharoDeclaredVariableForeground put: BrAntColors geekblue3.
	self constantAt: #pharoUndeclaredVariableForeground put: BrAntColors geekblue3.
	self
		constantAt: #pharoSelfVariableForeground
		put: (Color fromHexString: '#5EEAD4').
	self
		constantAt: #pharoSuperVariableForeground
		put: (Color fromHexString: '#5EEAD4').
	self
		constantAt: #pharoThisContextVariableForeground
		put: (Color fromHexString: '#5EEAD4').
	self constantAt: #pharoPragmaForeground put: BrAntColors green3.
	self constantAt: #pharoReturnArrowForeground put: BrAntColors cyan3.
	self constantAt: #pharoStringLiteralForeground put: BrAntColors magenta3.
	self constantAt: #pharoSymbolLiteralForeground put: BrAntColors magenta3.
	self constantAt: #pharoNumberLiteralForeground put: BrAntColors red2.
	self constantAt: #pharoNilLiteralForeground put: BrAntColors red2.
	self constantAt: #pharoBooleanLiteralForeground put: BrAntColors red2.
	self constantAt: #pharoCharacterLiteralForeground put: BrAntColors red2.
	self constantAt: #pharoCommentForeground put: BrAntColors gray6.
	self constantAt: #pharoErrorTokenForeground put: BrAntColors red3
]
