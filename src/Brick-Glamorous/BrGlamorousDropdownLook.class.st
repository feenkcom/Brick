Class {
	#name : #BrGlamorousDropdownLook,
	#superclass : #BrDropdownLook,
	#category : #'Brick-Glamorous-Dropdown'
}

{ #category : #'instance creation' }
BrGlamorousDropdownLook >> initialize [
	super initialize.
	self add: BrGlamorousAnchoredLook
]
