"
# Widget with dropdown look
Adds the dropdown functionality to an element
Use {{gtClass:BrGlamorousWithExplicitDropdownAptitude}} instead.
"
Class {
	#name : #BrGlamorousWithDropdownAptitude,
	#superclass : #BrWithDropdownAptitude,
	#category : #'Brick-Glamorous-Dropdown'
}

{ #category : #accessing }
BrGlamorousWithDropdownAptitude class >> anchoredAptitudeClass [
	^ BrGlamorousDropdownAptitude
]
