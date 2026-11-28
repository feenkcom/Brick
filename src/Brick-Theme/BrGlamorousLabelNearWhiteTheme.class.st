Class {
	#name : #BrGlamorousLabelNearWhiteTheme,
	#superclass : #BrGlamorousLabelLightTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousLabelNearWhiteTheme >> initializeConstants [
	super initializeConstants.

	self constantAt: #defaultTextForeground put: self theme colors primaryTextColor.
	self
		constantAt: #metadataTextForeground
		put: self theme colors secondaryTextColor.
	self
		constantAt: #summaryTextForeground
		put: self theme colors secondaryTextColor.
	self
		constantAt: #navigationTextForeground
		put: self theme colors sidebarTextColor
]
