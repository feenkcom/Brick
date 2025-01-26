"
I build resizer aptitude instances based on given {{gtClass:BlSteppedLayoutMark}} instances.
I can return either:
- `nil`, indicating that no resizers should be used, or
- {{gtClass:BrAptitude}} instances that knows how to display resizers.

"
Class {
	#name : #BrMenuResizerAptitudeBuilder,
	#superclass : #Object,
	#traits : 'TBlSteppedLayoutMarkVisitor',
	#classTraits : 'TBlSteppedLayoutMarkVisitor classTrait',
	#instVars : [
		'whenResizedHandler'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #private }
BrMenuResizerAptitudeBuilder >> initializeResizerAptitude: anAptitude [
	whenResizedHandler ifNotNil: [ 
		anAptitude whenResizedDo: whenResizedHandler ].
	^ anAptitude
]

{ #category : #visiting }
BrMenuResizerAptitudeBuilder >> visitSteppedLayoutMark: aMark [
	^ nil
]

{ #category : #accessing }
BrMenuResizerAptitudeBuilder >> whenResizedDo: aBlock [
	whenResizedHandler := aBlock
]

{ #category : #accessing }
BrMenuResizerAptitudeBuilder >> whenResizedHandler [
	^ whenResizedHandler
]
