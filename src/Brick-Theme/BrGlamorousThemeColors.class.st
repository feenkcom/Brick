Class {
	#name : #BrGlamorousThemeColors,
	#superclass : #Object,
	#instVars : [
		'theme',
		'primaryTextColor',
		'secondaryTextColor',
		'tertiaryTextColor',
		'disabledTextColor',
		'invertedTextColor',
		'appBackgroundColor',
		'backdropBackgroundColor',
		'sidebarBackgroundColor',
		'contentBackgroundColor',
		'groupBackgroundColor',
		'raisedBackgroundColor',
		'floatBackgroundColor',
		'sidebarTextColor',
		'pharoDeclaredVariableColor',
		'pharoUndeclaredVariableColor',
		'pharoSelfVariableColor',
		'pharoSuperVariableColor',
		'pharoThisContextVariableColor',
		'pharoStringLiteralColor',
		'pharoSymbolLiteralColor',
		'pharoNilLiteralColor',
		'pharoNumberLiteralColor',
		'pharoBooleanLiteralColor',
		'pharoCharacterLiteralColor',
		'pharoPragmaColor',
		'pharoReturnArrowColor',
		'pharoCommentColor'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'instance creation' }
BrGlamorousThemeColors class >> theme: aBlTheme [
	^ self new theme: aBlTheme
]

{ #category : #accessing }
BrGlamorousThemeColors >> appBackgroundColor [
	"App shell, full-page background"
	<return: #Color>
	
	^ appBackgroundColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> appBackgroundColor: anObject [
	appBackgroundColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> backdropBackgroundColor [
	<return: #Color>
	^ backdropBackgroundColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> backdropBackgroundColor: anObject [
	backdropBackgroundColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> contentBackgroundColor [
	"Standard surfaces and main scrollable content background."
	<return: #Color>

	^ contentBackgroundColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> contentBackgroundColor: anObject [
	contentBackgroundColor := anObject
]

{ #category : #'accessing - text' }
BrGlamorousThemeColors >> disabledTextColor [
	"Disabled text.
	For disabled UI elements"
	<return: #Color>
	
	^ disabledTextColor
]

{ #category : #'accessing - text' }
BrGlamorousThemeColors >> disabledTextColor: anObject [
	disabledTextColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> floatBackgroundColor [
	^ floatBackgroundColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> floatBackgroundColor: anObject [
	floatBackgroundColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> groupBackgroundColor [
	^ groupBackgroundColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> groupBackgroundColor: anObject [
	groupBackgroundColor := anObject
]

{ #category : #'accessing - text' }
BrGlamorousThemeColors >> invertedTextColor [
	"Inverted text.
	For use on light surfaces (e.g. buttons or chips with white background)"
	<return: #Color>
	
	^ invertedTextColor
]

{ #category : #'accessing - text' }
BrGlamorousThemeColors >> invertedTextColor: anObject [
	invertedTextColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoBooleanLiteralColor [
	^ pharoBooleanLiteralColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoBooleanLiteralColor: anObject [
	pharoBooleanLiteralColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoCharacterLiteralColor [
	^ pharoCharacterLiteralColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoCharacterLiteralColor: anObject [
	pharoCharacterLiteralColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoCommentColor [
	^ pharoCommentColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoCommentColor: anObject [
	pharoCommentColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoDeclaredVariableColor [
	^ pharoDeclaredVariableColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoDeclaredVariableColor: anObject [
	pharoDeclaredVariableColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoNilLiteralColor [
	^ pharoNilLiteralColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoNilLiteralColor: anObject [
	pharoNilLiteralColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoNumberLiteralColor [
	^ pharoNumberLiteralColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoNumberLiteralColor: anObject [
	pharoNumberLiteralColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoPragmaColor [
	^ pharoPragmaColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoPragmaColor: anObject [
	pharoPragmaColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoReturnArrowColor [
	^ pharoReturnArrowColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoReturnArrowColor: anObject [
	pharoReturnArrowColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoSelfVariableColor [
	^ pharoSelfVariableColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoSelfVariableColor: anObject [
	pharoSelfVariableColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoStringLiteralColor [
	^ pharoStringLiteralColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoStringLiteralColor: anObject [
	pharoStringLiteralColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoSuperVariableColor [
	^ pharoSuperVariableColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoSuperVariableColor: anObject [
	pharoSuperVariableColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoSymbolLiteralColor [
	^ pharoSymbolLiteralColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoSymbolLiteralColor: anObject [
	pharoSymbolLiteralColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoThisContextVariableColor [
	^ pharoThisContextVariableColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoThisContextVariableColor: anObject [
	pharoThisContextVariableColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoUndeclaredVariableColor [
	^ pharoUndeclaredVariableColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> pharoUndeclaredVariableColor: anObject [
	pharoUndeclaredVariableColor := anObject
]

{ #category : #'accessing - text' }
BrGlamorousThemeColors >> primaryTextColor [
	"Primary text.
	High contrast for body text and headlines"
	<return: #Color>
	
	^ primaryTextColor
]

{ #category : #'accessing - text' }
BrGlamorousThemeColors >> primaryTextColor: anObject [
	primaryTextColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> raisedBackgroundColor [
	^ raisedBackgroundColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> raisedBackgroundColor: anObject [
	raisedBackgroundColor := anObject
]

{ #category : #'accessing - text' }
BrGlamorousThemeColors >> secondaryTextColor [
	"Secondary text.
	Subheadings, supporting text"
	<return: #Color>
	
	^ secondaryTextColor
]

{ #category : #'accessing - text' }
BrGlamorousThemeColors >> secondaryTextColor: anObject [
	secondaryTextColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> sidebarBackgroundColor [
	^ sidebarBackgroundColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> sidebarBackgroundColor: anObject [
	sidebarBackgroundColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> sidebarTextColor [
	^ sidebarTextColor
]

{ #category : #accessing }
BrGlamorousThemeColors >> sidebarTextColor: anObject [
	sidebarTextColor := anObject
]

{ #category : #'accessing - text' }
BrGlamorousThemeColors >> tertiaryTextColor [
	"Tertiary text.
	Captions, placeholders"
	<return: #Color>
	
	^ tertiaryTextColor
]

{ #category : #'accessing - text' }
BrGlamorousThemeColors >> tertiaryTextColor: anObject [
	tertiaryTextColor := anObject
]

{ #category : #accessing }
BrGlamorousThemeColors >> theme [
	^ theme
]

{ #category : #accessing }
BrGlamorousThemeColors >> theme: anObject [
	theme := anObject
]
