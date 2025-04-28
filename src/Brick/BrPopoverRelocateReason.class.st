Class {
	#name : #BrPopoverRelocateReason,
	#superclass : #Object,
	#classVars : [
		'Extent',
		'Position',
		'Reappear',
		'Show'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #factory }
BrPopoverRelocateReason class >> extent [
	^ Extent ifNil: [ Extent := BrPopoverRelocatePositionExtentReason new ]
]

{ #category : #factory }
BrPopoverRelocateReason class >> position [
	^ Position ifNil: [ Position := BrPopoverRelocatePositionChangedReason new ]
]

{ #category : #factory }
BrPopoverRelocateReason class >> reappear [
	^ Reappear ifNil: [ Reappear := BrPopoverRelocateReappearReason new ]
]

{ #category : #factory }
BrPopoverRelocateReason class >> show [
	^ Show ifNil: [ Show := BrPopoverRelocateShowReason new ]
]
