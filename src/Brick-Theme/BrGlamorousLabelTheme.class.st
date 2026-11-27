Class {
	#name : #BrGlamorousLabelTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'defaultTextForeground',
		'metadataTextForeground',
		'summaryTextForeground',
		'navigationTextForeground'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #accessing }
BrGlamorousLabelTheme >> defaultTextForeground [
	^ defaultTextForeground
]

{ #category : #initialization }
BrGlamorousLabelTheme >> initializeThemeable [
	super initializeThemeable.

	defaultTextForeground := self
			color: [ :aTheme | aTheme label constantAt: #defaultTextForeground ]
			source: [ :aTheme | aTheme label defaultTextForeground ].

	metadataTextForeground := self
			color: [ :aTheme | aTheme label constantAt: #metadataTextForeground ]
			source: [ :aTheme | aTheme label metadataTextForeground ].

	summaryTextForeground := self
			color: [ :aTheme | aTheme label constantAt: #summaryTextForeground ]
			source: [ :aTheme | aTheme label summaryTextForeground ].

	navigationTextForeground := self
			color: [ :aTheme | aTheme label constantAt: #navigationTextForeground ]
			source: [ :aTheme | aTheme label navigationTextForeground ]
]

{ #category : #accessing }
BrGlamorousLabelTheme >> metadataTextForeground [
	^ metadataTextForeground
]

{ #category : #accessing }
BrGlamorousLabelTheme >> navigationTextForeground [
	^ navigationTextForeground
]

{ #category : #accessing }
BrGlamorousLabelTheme >> summaryTextForeground [
	^ summaryTextForeground
]
