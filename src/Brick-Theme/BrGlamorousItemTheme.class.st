Class {
	#name : #BrGlamorousItemTheme,
	#superclass : #BrTheme,
	#instVars : [
		'selectedColor',
		'deselectedColor',
		'hoveredColor',
		'defaultColor',
		'focusedBorderColor',
		'pressedColor'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #accessing }
BrGlamorousItemTheme >> defaultColor [
	^ defaultColor
]

{ #category : #accessing }
BrGlamorousItemTheme >> defaultColor: anObject [
	defaultColor := anObject
]

{ #category : #accessing }
BrGlamorousItemTheme >> deselectedColor [
	^ deselectedColor
]

{ #category : #accessing }
BrGlamorousItemTheme >> deselectedColor: anObject [
	deselectedColor := anObject
]

{ #category : #accessing }
BrGlamorousItemTheme >> focusedBorderColor [
	^ focusedBorderColor
]

{ #category : #accessing }
BrGlamorousItemTheme >> focusedBorderColor: anObject [
	focusedBorderColor := anObject
]

{ #category : #accessing }
BrGlamorousItemTheme >> hoveredColor [
	^ hoveredColor
]

{ #category : #accessing }
BrGlamorousItemTheme >> hoveredColor: anObject [
	hoveredColor := anObject
]

{ #category : #initialization }
BrGlamorousItemTheme >> initialize [
	super initialize.
	selectedColor := BrGlamorousColors selectedListItemColor.
	deselectedColor := BrGlamorousColors deselectedListItemColor.
	hoveredColor := BrGlamorousColors hoveredListItemColor.
	defaultColor := BrGlamorousColors defaultListItemColor.
	focusedBorderColor := BrGlamorousColors focusedListItemBorder.
	pressedColor := BrGlamorousColors pressedListItemColor
]

{ #category : #accessing }
BrGlamorousItemTheme >> pressedColor [
	^ pressedColor
]

{ #category : #accessing }
BrGlamorousItemTheme >> pressedColor: anObject [
	pressedColor := anObject
]

{ #category : #accessing }
BrGlamorousItemTheme >> selectedColor [
	^ selectedColor
]

{ #category : #accessing }
BrGlamorousItemTheme >> selectedColor: anObject [
	selectedColor := anObject
]
