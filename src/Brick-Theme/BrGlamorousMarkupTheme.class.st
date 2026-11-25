Class {
	#name : #BrGlamorousMarkupTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'foreground',
		'background',
		'codeFenceForeground'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #accessing }
BrGlamorousMarkupTheme >> background [
	^ background
]

{ #category : #accessing }
BrGlamorousMarkupTheme >> codeFenceForeground [
	^ codeFenceForeground
]

{ #category : #accessing }
BrGlamorousMarkupTheme >> foreground [
	^ foreground
]

{ #category : #initialization }
BrGlamorousMarkupTheme >> initializeThemeable [
	super initializeThemeable.
	foreground := self
			color: [ :aTheme | aTheme markup constantAt: #foreground ]
			source: [ :aTheme | aTheme markup foreground ].
	background := self
			color: [ :aTheme | aTheme markup constantAt: #background ]
			source: [ :aTheme | aTheme markup background ].
	codeFenceForeground := self
			color: [ :aTheme | aTheme markup constantAt: #codeFenceForeground ]
			source: [ :aTheme | aTheme markup codeFenceForeground ]
]
