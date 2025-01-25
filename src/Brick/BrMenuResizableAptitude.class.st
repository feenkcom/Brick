"
I know how to resize menu elements.
I use {{gtClass:BrMenuResizerAptitudeBuilder}} to create new resizers.

"
Class {
	#name : #BrMenuResizableAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'lastMark',
		'resizerAptitude',
		'resizerAptitudeBuilder'
	],
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #initialization }
BrMenuResizableAptitude >> defaultResizerAptitudeBuilder [
	^ BrMenuResizerAptitudeBuilder new
]

{ #category : #initialization }
BrMenuResizableAptitude >> initializeListeners [
	super initializeListeners.

	self
		when: BlElementPositionChangedEvent
		do: [ :anEvent | self onElementPositionChanged: anEvent ].
	self
		when: BlElementExtentChangedEvent
		do: [ :anEvent | self onElementExtentChanged: anEvent ]
]

{ #category : #accessing }
BrMenuResizableAptitude >> lastMark [
	^ lastMark ifNil: [ lastMark := BlSteppedLayoutMark undefined ]
]

{ #category : #accessing }
BrMenuResizableAptitude >> mark [
	self widgetDo: [ :aWidget | 
		^ aWidget constraints stepped mark ].
	^ BlSteppedLayoutMark undefined
]

{ #category : #'event handling' }
BrMenuResizableAptitude >> onElementExtentChanged: anEvent [
	self onElementLayoutMarkMayChanged
]

{ #category : #'event handling' }
BrMenuResizableAptitude >> onElementLayoutMarkMayChanged [
	| aMark anAptitude |
	aMark := self mark.
	aMark = self lastMark ifTrue: [ ^ self ].
	lastMark := aMark.

	anAptitude := self visitMark: aMark.
	anAptitude
		ifNotNil: [ self resizerAptitude: anAptitude ]
		ifNil: [ self removeResizerAptitude ]
]

{ #category : #'event handling' }
BrMenuResizableAptitude >> onElementPositionChanged: anEvent [
	self onElementLayoutMarkMayChanged
]

{ #category : #private }
BrMenuResizableAptitude >> removeResizerAptitude [
	resizerAptitude ifNotNil: [ :anOldAptitude | self remove: anOldAptitude ].
	resizerAptitude := nil
]

{ #category : #visiting }
BrMenuResizableAptitude >> resizerAptitude: aResizerAptitude [
	self removeResizerAptitude.
	resizerAptitude := aResizerAptitude.
	self add: aResizerAptitude
]

{ #category : #accessing }
BrMenuResizableAptitude >> resizerAptitudeBuilder [
	<return: #BrMenuResizerAptitudeBuilder>
	^ resizerAptitudeBuilder
		ifNil: [ resizerAptitudeBuilder := self defaultResizerAptitudeBuilder ]
]

{ #category : #accessing }
BrMenuResizableAptitude >> resizerAptitudeBuilder: aBuilder [
	resizerAptitudeBuilder := aBuilder
]

{ #category : #visiting }
BrMenuResizableAptitude >> visitMark: aMark [
	<return: #BrAptitude or: nil>
	^ aMark acceptVisitor: self resizerAptitudeBuilder
]

{ #category : #'api - initialization' }
BrMenuResizableAptitude >> whenResizedDo: aBlock [
	self resizerAptitudeBuilder whenResizedDo: aBlock.
	resizerAptitude ifNotNil: [
		resizerAptitude withAllActorsDepthFirstDo: [ :anAptitude |
			anAptitude whenResizedDo: aBlock ] ]
]
