Class {
	#name : #BrGlamorousSummaryLabelAptitude,
	#superclass : #BrGlamorousLabelAptitude,
	#category : #'Brick-Glamorous-Label'
}

{ #category : #initialization }
BrGlamorousSummaryLabelAptitude >> initialize [
	super initialize.
	
	self foreground: self theme label summaryTextForeground
]
