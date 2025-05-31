Class {
	#name : #BrGlamorousTheme,
	#superclass : #BlTheme,
	#instVars : [
		'link',
		'status',
		'default',
		'editor',
		'button',
		'item',
		'header',
		'label',
		'colors'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #accessing }
BrGlamorousTheme >> button [
	^ button
]

{ #category : #accessing }
BrGlamorousTheme >> button: anObject [
	button := anObject
]

{ #category : #accessing }
BrGlamorousTheme >> colors [
	"Returns an object with color contanstants.
	
	Must not be used by user code, as those Colors will not adapt to the theme change."
	| sender |
	
	sender := thisContext sender compiledCode methodClass.
	self
		assert: [ sender inheritsFrom: BlSubTheme  ]
		description: [ 'Must only be used within a Theme.' ].

	^ colors
]

{ #category : #accessing }
BrGlamorousTheme >> colors: anObject [
	colors := anObject.
	self themeModified
]

{ #category : #accessing }
BrGlamorousTheme >> default [
	^ default
]

{ #category : #accessing }
BrGlamorousTheme >> default: anObject [
	default := anObject
]

{ #category : #accessing }
BrGlamorousTheme >> editor [
	^ editor
]

{ #category : #accessing }
BrGlamorousTheme >> editor: anObject [
	editor := anObject
]

{ #category : #accessing }
BrGlamorousTheme >> header [
	^ header
]

{ #category : #accessing }
BrGlamorousTheme >> header: anObject [
	header := anObject
]

{ #category : #accessing }
BrGlamorousTheme >> item [
	^ item
]

{ #category : #accessing }
BrGlamorousTheme >> item: anObject [
	item := anObject
]

{ #category : #accessing }
BrGlamorousTheme >> label [
	^ label ifNil: [ label := BrGlamorousLabelLightTheme new]
]

{ #category : #accessing }
BrGlamorousTheme >> label: anObject [
	label := anObject
]

{ #category : #accessing }
BrGlamorousTheme >> link [
	^ link
]

{ #category : #accessing }
BrGlamorousTheme >> link: anObject [
	link := anObject
]

{ #category : #'as yet unclassified' }
BrGlamorousTheme >> onThemeModified [
	super onThemeModified.
	
	default initializeThemeable.
	editor initializeThemeable.
	button initializeThemeable.
	label initializeThemeable.
	header initializeThemeable
]

{ #category : #'as yet unclassified' }
BrGlamorousTheme >> privateColors [
	^ colors
]

{ #category : #accessing }
BrGlamorousTheme >> status [
	^ status
]

{ #category : #accessing }
BrGlamorousTheme >> status: anObject [
	status := anObject
]
