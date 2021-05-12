Class {
	#name : #BrGlamorousHeaderTheme,
	#superclass : #BrTheme,
	#instVars : [
		'textMarkupColor',
		'defaultBackgroundColor',
		'disabledTextColor',
		'defaultTextColor',
		'secondaryBackgroundColor'
	],
	#category : #'Brick-Theme-Glamorous'
}

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
BrGlamorousHeaderTheme >> initialize [
	super initialize.
	textMarkupColor := BrGlamorousColors textMarkupColor.
	defaultBackgroundColor := BrGlamorousColors
		defaultHeaderBackgroundColor.
	disabledTextColor := BrGlamorousColors disabledHeaderTextColor.
	defaultTextColor := BrGlamorousColors defaultHeaderTextColor.
	secondaryBackgroundColor := BrGlamorousColors
		secondaryHeaderBackgroundColor
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
BrGlamorousHeaderTheme >> textMarkupColor: anObject [
	textMarkupColor := anObject
]
