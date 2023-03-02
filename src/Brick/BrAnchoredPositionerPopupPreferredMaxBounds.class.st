"
I am a value holder used by {{gtClass:BrAnchoredPositioner}}.

"
Class {
	#name : #BrAnchoredPositionerPopupPreferredMaxBounds,
	#superclass : #Object,
	#instVars : [
		'bounds',
		'position'
	],
	#category : #'Brick-Anchored - Support'
}

{ #category : #'instance creation' }
BrAnchoredPositionerPopupPreferredMaxBounds class >> position: aPosition bounds: aBounds [
	^ self new
		position: aPosition;
		bounds: aBounds
]

{ #category : #accessing }
BrAnchoredPositionerPopupPreferredMaxBounds >> bounds [
	^ bounds
]

{ #category : #accessing }
BrAnchoredPositionerPopupPreferredMaxBounds >> bounds: anObject [
	bounds := anObject
]

{ #category : #accessing }
BrAnchoredPositionerPopupPreferredMaxBounds >> position [
	^ position
]

{ #category : #accessing }
BrAnchoredPositionerPopupPreferredMaxBounds >> position: anObject [
	position := anObject
]
