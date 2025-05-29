Class {
	#name : #BrGlamorousLightThemeColors,
	#superclass : #BrGlamorousThemeColors,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousLightThemeColors >> initialize [
	super initialize.

	primaryTextColor := Color black.
	secondaryTextColor := Color gray.
	tertiaryTextColor := Color gray.
	disabledTextColor := Color gray.
	invertedTextColor := Color white.
	appBackgroundColor := BrGlamorousColors defaultHeaderBackgroundColor.
	backdropBackgroundColor := BrGlamorousColors backdropColor.
	sidebarBackgroundColor := BrGlamorousColors neutralBackgroundColor.
	contentBackgroundColor := Color white.
	groupBackgroundColor := nil.
	raisedBackgroundColor := nil.
	floatBackgroundColor := nil.
	sidebarTextColor := Color black.
	pharoDeclaredVariableColor := Color blue muchDarker.
	pharoUndeclaredVariableColor := Color blue muchDarker.
	pharoSelfVariableColor := Color cyan muchDarker.
	pharoSuperVariableColor := Color cyan muchDarker.
	pharoThisContextVariableColor := Color cyan muchDarker.
	pharoStringLiteralColor := Color magenta muchDarker.
	pharoSymbolLiteralColor := Color magenta muchDarker.
	pharoNilLiteralColor := nil.
	pharoNumberLiteralColor := nil.
	pharoBooleanLiteralColor := nil.
	pharoCharacterLiteralColor := nil.
	pharoPragmaColor := nil.
	pharoReturnArrowColor := nil.
	pharoCommentColor := nil.

]
