"
Use {{gtClass:BrGlamorousWithExplicitTooltipAptitude}} instead.
"
Class {
	#name : #BrGlamorousWithTooltipAptitude,
	#superclass : #BrWithTooltipAptitude,
	#category : #'Brick-Glamorous-Tooltip'
}

{ #category : #'as yet unclassified' }
BrGlamorousWithTooltipAptitude class >> anchoredAptitudeClass [
	^ BrGlamorousTooltipAptitude
]

{ #category : #testing }
BrGlamorousWithTooltipAptitude class >> isDeprecated [
	"Use BrGlamorousWithExplicitTooltipAptitude instead"

	^ true
]
