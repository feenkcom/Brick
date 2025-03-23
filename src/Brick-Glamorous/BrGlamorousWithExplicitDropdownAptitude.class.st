Class {
	#name : #BrGlamorousWithExplicitDropdownAptitude,
	#superclass : #BrWithExplicitDropdownAptitude,
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #deprecated }
BrGlamorousWithExplicitDropdownAptitude >> beNotResizable [
	"ignore"

	
]

{ #category : #initialization }
BrGlamorousWithExplicitDropdownAptitude >> defaultElementBuilder [
	^ BrGlamorousMenuElementBuilder new
]
