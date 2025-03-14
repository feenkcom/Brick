Class {
	#name : #BrGlamorousWithExplicitTooltipAptitude,
	#superclass : #BrWithExplicitTooltipAptitude,
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #initialization }
BrGlamorousWithExplicitTooltipAptitude >> defaultElementBuilder [
	^ BrGlamorousMenuElementBuilder new
]

{ #category : #'api - initialization' }
BrGlamorousWithExplicitTooltipAptitude >> withDefaultHandle [
	^ self withTooltipHandle
]
