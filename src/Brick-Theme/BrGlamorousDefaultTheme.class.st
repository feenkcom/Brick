Class {
	#name : #BrGlamorousDefaultTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'defaultShadowColor',
		'backdropColor',
		'primaryBorderColor',
		'darkBorderColor',
		'distinctTenStrongColors',
		'newsBackgroundColor',
		'lightBorderColor',
		'expandCollapseTriangleBackgroundColor',
		'shadowColor',
		'distinctTenLightColors',
		'contentBackgroundColor',
		'contentBackground'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #accessing }
BrGlamorousDefaultTheme >> backdropColor [
	^ backdropColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> backdropColor: anObject [
	backdropColor := anObject
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> contentBackground [
	^ contentBackground ifNil: [ self contentBackgroundColor ]
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> contentBackgroundColor [
	^ contentBackgroundColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> contentBackgroundColor: aColor [
	contentBackgroundColor := aColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> darkBorderColor [
	^ darkBorderColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> darkBorderColor: anObject [
	darkBorderColor := anObject
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> defaultShadowColor [
	^ defaultShadowColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> defaultShadowColor: anObject [
	defaultShadowColor := anObject
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> distinctTenLightColors [
	^ distinctTenLightColors
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> distinctTenLightColors: anObject [
	distinctTenLightColors := anObject
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> distinctTenStrongColors [
	^ distinctTenStrongColors
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> distinctTenStrongColors: anObject [
	distinctTenStrongColors := anObject
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> expandCollapseTriangleBackgroundColor [
	^ expandCollapseTriangleBackgroundColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> expandCollapseTriangleBackgroundColor: anObject [
	expandCollapseTriangleBackgroundColor := anObject
]

{ #category : #'as yet unclassified' }
BrGlamorousDefaultTheme >> initializeTheme [
	contentBackground := self
		background: [ :aTheme | aTheme default contentBackgroundColor ]
		source: [ :aTheme | aTheme default contentBackground ].
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> lightBorderColor [
	^ lightBorderColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> lightBorderColor: anObject [
	lightBorderColor := anObject
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> newsBackgroundColor [
	^ newsBackgroundColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> newsBackgroundColor: anObject [
	newsBackgroundColor := anObject
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> primaryBorderColor [
	^ primaryBorderColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> primaryBorderColor: anObject [
	primaryBorderColor := anObject
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> shadowColor [
	^ shadowColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> shadowColor: anObject [
	shadowColor := anObject
]
