Class {
	#name : #BrGlamorousEditorDarkTheme,
	#superclass : #BrGlamorousEditorTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousEditorDarkTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #completionPreviewBackground put: BrAntColors gray8.
	self constantAt: #borderColor put: BrAntColors gray8.
	self constantAt: #focusedBorderColor put: BrAntColors blue3.
	
	self constantAt: #pharoDeclaredVariableForeground put: BrAntColors geekblue3.
	self constantAt: #pharoUndeclaredVariableForeground put: BrAntColors geekblue3.
	self constantAt: #pharoSelfVariableForeground put: BrAntColors purple2.
	self constantAt: #pharoSuperVariableForeground put: BrAntColors purple2.
	self constantAt: #pharoThisContextVariableForeground put: BrAntColors purple2.
	self constantAt: #pharoPragmaForeground put: BrAntColors green3.
	self constantAt: #pharoReturnArrowForeground put: BrAntColors cyan3.
	self constantAt: #pharoStringLiteralForeground put: BrAntColors magenta3.
	self constantAt: #pharoSymbolLiteralForeground put: BrAntColors magenta3.
	self constantAt: #pharoNumberLiteralForeground put: BrAntColors red2.
	self constantAt: #pharoNilLiteralForeground put: BrAntColors red2.
	self constantAt: #pharoBooleanLiteralForeground put: BrAntColors red2.
	self constantAt: #pharoCharacterLiteralForeground put: BrAntColors red2.
	self constantAt: #pharoCommentForeground put: BrAntColors gray6.
	self constantAt: #pharoErrorTokenForeground put: BrAntColors red3.

	self constantAt: #enabledBreakpointForeground put: BrAntColors gray12.
	self constantAt: #enabledBreakpointBackground put: BrAntColors orange3.
	self constantAt: #disabledBreakpointBackground put: BrAntColors gray3.
	self constantAt: #disabledBreakpointForeground put: BrAntColors gray9.
]
