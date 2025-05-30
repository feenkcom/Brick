Class {
	#name : #BrGlamorousMetadataLabelAptitude,
	#superclass : #BrGlamorousLabelAptitude,
	#category : #'Brick-Glamorous-Label'
}

{ #category : #initialization }
BrGlamorousMetadataLabelAptitude >> initialize [
	super initialize.
	
	self foreground: self theme label metadataTextForeground
]
