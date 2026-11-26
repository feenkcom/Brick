Class {
	#name : #BrGlamorousEditorDarkTheme,
	#superclass : #BrGlamorousEditorTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousEditorDarkTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #sourceReferenceHighlight put: BrAntColors orange2.
	
	self constantAt: #occurrenceHighlight put: BrAntColors gray8.
	self constantAt: #completionPreviewBackground put: BrAntColors gray8.
	self constantAt: #borderColor put: BrAntColors gray8.
	self constantAt: #focusedBorderColor put: BrAntColors blue3.

	self constantAt: #pharoDeclaredVariableForeground put: BrAntColors geekblue2.
	self constantAt: #pharoUndeclaredVariableForeground put: BrAntColors geekblue3.
	self constantAt: #pharoSelfVariableForeground put: BrAntColors purple2.
	self constantAt: #pharoSuperVariableForeground put: BrAntColors purple2.
	self constantAt: #pharoThisContextVariableForeground put: BrAntColors purple2.
	self constantAt: #pharoPragmaForeground put: BrAntColors lime3.
	self constantAt: #pharoReturnArrowForeground put: BrAntColors cyan3.
	self constantAt: #pharoStringLiteralForeground put: BrAntColors magenta2.
	self constantAt: #pharoSymbolLiteralForeground put: BrAntColors magenta2.
	self constantAt: #pharoNumberLiteralForeground put: BrAntColors red2.
	self constantAt: #pharoNilLiteralForeground put: BrAntColors red2.
	self constantAt: #pharoBooleanLiteralForeground put: BrAntColors red2.
	self constantAt: #pharoCharacterLiteralForeground put: BrAntColors magenta3.
	self constantAt: #pharoCommentForeground put: BrAntColors gray6.
	self constantAt: #pharoErrorTokenForeground put: BrAntColors red3.

	self constantAt: #enabledBreakpointForeground put: BrAntColors gray2.
	self constantAt: #enabledBreakpointBackground put: BrAntColors red6.
	self constantAt: #disabledBreakpointBackground put: BrAntColors gray7.
	self constantAt: #disabledBreakpointForeground put: BrAntColors gray5
]
