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
		'contentBackground',
		'backdropBackground',
		'navigationBackgroundColor',
		'navigationBackground'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'accessing - background' }
BrGlamorousDefaultTheme >> backdropBackground [
	^ backdropBackground ifNil: [ self backdropColor ]
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> backdropColor [
	^ backdropColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> backdropColor: anObject [
	backdropColor := anObject
]

{ #category : #'accessing - background' }
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
		
	backdropBackground := self
		background: [ :aTheme | aTheme default backdropColor ]
		source: [ :aTheme | aTheme default backdropBackground ].
		
	navigationBackground := self
		background: [ :aTheme | aTheme default navigationBackgroundColor ]
		source: [ :aTheme | aTheme default navigationBackground ].
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> lightBorderColor [
	^ lightBorderColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> lightBorderColor: anObject [
	lightBorderColor := anObject
]

{ #category : #'accessing - background' }
BrGlamorousDefaultTheme >> navigationBackground [
	^ navigationBackground ifNil: [ BrGlamorousColors neutralBackgroundColor ]
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> navigationBackgroundColor [
	^ navigationBackgroundColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> navigationBackgroundColor: anObject [
	navigationBackgroundColor := anObject
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
