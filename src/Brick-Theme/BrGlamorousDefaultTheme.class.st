Class {
	#name : #BrGlamorousDefaultTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'defaultShadowColor',
		'primaryBorderColor',
		'darkBorderColor',
		'distinctTenStrongColors',
		'newsBackgroundColor',
		'lightBorderColor',
		'expandCollapseTriangleBackgroundColor',
		'shadowColor',
		'distinctTenLightColors',
		'contentBackground',
		'backdropBackground',
		'navigationBackground',
		'appBackground',
		'backdropEmphasisBackground'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #accessing }
BrGlamorousDefaultTheme >> appBackground [
	^ appBackground
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> backdropBackground [
	^ backdropBackground
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> backdropEmphasisBackground [
	^ backdropEmphasisBackground
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> contentBackground [
	^ contentBackground
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

{ #category : #initialization }
BrGlamorousDefaultTheme >> initializeColors [
	super initializeColors
]

{ #category : #initialization }
BrGlamorousDefaultTheme >> initializeConstants [
	super initializeConstants
]

{ #category : #initialization }
BrGlamorousDefaultTheme >> initializeThemeable [
	super initializeThemeable.

	contentBackground := self
			color: [ :aTheme | aTheme colors contentBackgroundColor ]
			source: [ :aTheme | aTheme default contentBackground ].

	backdropBackground := self
			color: [ :aTheme | aTheme colors backdropBackgroundColor ]
			source: [ :aTheme | aTheme default backdropBackground ].
			
	backdropEmphasisBackground := self
			color: [ :aTheme | aTheme colors backdropEmphasisBackgroundColor ]
			source: [ :aTheme | aTheme default backdropEmphasisBackground ].

	navigationBackground := self
			color: [ :aTheme | aTheme colors sidebarBackgroundColor ]
			source: [ :aTheme | aTheme default navigationBackground ].

	appBackground := self
			color: [ :aTheme | aTheme colors appBackgroundColor ]
			source: [ :aTheme | aTheme default appBackground ]
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
BrGlamorousDefaultTheme >> navigationBackground [
	^ navigationBackground
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
