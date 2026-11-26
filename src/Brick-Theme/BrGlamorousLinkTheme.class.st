Class {
	#name : #BrGlamorousLinkTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'color',
		'errorColor'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #accessing }
BrGlamorousLinkTheme >> color [
	^ color
]

{ #category : #accessing }
BrGlamorousLinkTheme >> color: aColor [
	self constantAt: #color put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousLinkTheme >> errorColor [
	^ errorColor
]

{ #category : #accessing }
BrGlamorousLinkTheme >> errorColor: aColor [
	self constantAt: #errorColor put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #initialization }
BrGlamorousLinkTheme >> initializeThemeable [
	super initializeThemeable.
	color := self
			color: [ :aTheme | aTheme link constantAt: #color ]
			source: [ :aTheme | aTheme link color ].
	errorColor := self
			color: [ :aTheme | aTheme link constantAt: #errorColor ]
			source: [ :aTheme | aTheme link errorColor ]
]
