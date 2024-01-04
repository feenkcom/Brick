"
I model a state of the resizer's lcoation.

I am useful to let resizer widgets style themselves based on the location. For example if location is bottom, then widget should look like a horizontal bar. If location is left then resizer should be a vertical bar.
"
Class {
	#name : #BrResizerLocationState,
	#superclass : #BlElementUniqueState,
	#instVars : [
		'location'
	],
	#category : #'Brick-Resizer - State'
}

{ #category : #accessing }
BrResizerLocationState class >> location: aResizerLocation [
	^ self new location: aResizerLocation
]

{ #category : #comparing }
BrResizerLocationState >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ location = anObject location
]

{ #category : #comparing }
BrResizerLocationState >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ location hash
]

{ #category : #accessing }
BrResizerLocationState >> location [
	^ location
]

{ #category : #accessing }
BrResizerLocationState >> location: aResizerLocation [
	location := aResizerLocation
]

{ #category : #accessing }
BrResizerLocationState >> priority [
	^ UserPriority
]
