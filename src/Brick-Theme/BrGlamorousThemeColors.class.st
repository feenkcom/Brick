Class {
	#name : #BrGlamorousThemeColors,
	#superclass : #Object,
	#instVars : [
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
		'floatBackgroundColor'
	],
	#category : #'Brick-Theme-Glamorous'
}

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
