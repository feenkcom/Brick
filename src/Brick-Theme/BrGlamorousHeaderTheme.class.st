Class {
	#name : #BrGlamorousHeaderTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'textMarkupColor',
		'defaultBackgroundColor',
		'disabledTextColor',
		'defaultTextColor',
		'secondaryBackgroundColor',
		'defaultBackground'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #accessing }
BrGlamorousHeaderTheme >> defaultBackground [
	^ defaultBackground ifNil: [ self defaultBackgroundColor ]
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> defaultBackgroundColor [
	^ defaultBackgroundColor
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> defaultBackgroundColor: anObject [
	defaultBackgroundColor := anObject
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> defaultTextColor [
	^ defaultTextColor
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> defaultTextColor: anObject [
	defaultTextColor := anObject
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> disabledTextColor [
	^ disabledTextColor
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> disabledTextColor: anObject [
	disabledTextColor := anObject
]

{ #category : #initialization }
BrGlamorousHeaderTheme >> initializeColors [
	super initializeColors
]

{ #category : #initialization }
BrGlamorousHeaderTheme >> initializeConstants [
	super initializeConstants
]

{ #category : #initialization }
BrGlamorousHeaderTheme >> initializeThemeable [
	super initializeThemeable.

	defaultBackground := self
			background: [ :aTheme | aTheme header defaultBackgroundColor ]
			source: [ :aTheme | aTheme header defaultBackground ]
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> secondaryBackgroundColor [
	^ secondaryBackgroundColor
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> secondaryBackgroundColor: anObject [
	secondaryBackgroundColor := anObject
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> textMarkupColor [
	^ textMarkupColor
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> textMarkupColor: aColor [
	self
		constantAt: #textMarkupColor
		put: aColor.
	self initializeThemeable
]
