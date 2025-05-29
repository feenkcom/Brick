Class {
	#name : #BrGlamorousLabelTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'defaultTextForeground',
		'metadataTextForeground'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousLabelTheme >> defaultTextForeground [
	^ defaultTextForeground
]

{ #category : #'as yet unclassified' }
BrGlamorousLabelTheme >> initializeTheme [
	super initializeTheme.
	
	defaultTextForeground := self
		color: [ :aTheme | aTheme colors primaryTextColor ]
		source: [ :aTheme | aTheme label defaultTextForeground ].

	metadataTextForeground := self
		color: [ :aTheme | aTheme colors secondaryTextColor ]
		source: [ :aTheme | aTheme label metadataTextForeground ].
]

{ #category : #'as yet unclassified' }
BrGlamorousLabelTheme >> metadataTextForeground [
	^ metadataTextForeground
]
