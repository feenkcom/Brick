"
I know how to resize menu elements.
I use {{gtClass:BrPopoverResizerAptitudeBuilder}} to create new resizers.

"
Class {
	#name : #BrPopoverResizableAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'lastMark',
		'resizerAptitude',
		'resizerAptitudeBuilder'
	],
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #initialization }
BrPopoverResizableAptitude >> defaultResizerAptitudeBuilder [
	^ BrPopoverResizerAptitudeBuilder new
]

{ #category : #initialization }
BrPopoverResizableAptitude >> initializeListeners [
	super initializeListeners.

	self
		when: BlElementPositionChangedEvent
		do: [ :anEvent | self onElementPositionChanged: anEvent ].
	self
		when: BlElementExtentChangedEvent
		do: [ :anEvent | self onElementExtentChanged: anEvent ]
]

{ #category : #accessing }
BrPopoverResizableAptitude >> lastMark [
	^ lastMark ifNil: [ lastMark := BlSteppedLayoutMark undefined ]
]

{ #category : #accessing }
BrPopoverResizableAptitude >> mark [
	self widgetDo: [ :aWidget | 
		^ aWidget constraints stepped mark ].
	^ BlSteppedLayoutMark undefined
]

{ #category : #'event handling' }
BrPopoverResizableAptitude >> onElementExtentChanged: anEvent [
	self onElementLayoutMarkMayChanged
]

{ #category : #'event handling' }
BrPopoverResizableAptitude >> onElementLayoutMarkMayChanged [
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
BrPopoverResizableAptitude >> onElementPositionChanged: anEvent [
	self onElementLayoutMarkMayChanged
]

{ #category : #private }
BrPopoverResizableAptitude >> removeResizerAptitude [
	resizerAptitude ifNotNil: [ :anOldAptitude | self remove: anOldAptitude ].
	resizerAptitude := nil
]

{ #category : #visiting }
BrPopoverResizableAptitude >> resizerAptitude: aResizerAptitude [
	self removeResizerAptitude.
	resizerAptitude := aResizerAptitude.
	self add: aResizerAptitude
]

{ #category : #accessing }
BrPopoverResizableAptitude >> resizerAptitudeBuilder [
	<return: #BrPopoverResizerAptitudeBuilder>
	^ resizerAptitudeBuilder
		ifNil: [ resizerAptitudeBuilder := self defaultResizerAptitudeBuilder ]
]

{ #category : #accessing }
BrPopoverResizableAptitude >> resizerAptitudeBuilder: aBuilder [
	resizerAptitudeBuilder := aBuilder
]

{ #category : #visiting }
BrPopoverResizableAptitude >> visitMark: aMark [
	<return: #BrAptitude or: nil>
	^ aMark acceptVisitor: self resizerAptitudeBuilder
]

{ #category : #'api - initialization' }
BrPopoverResizableAptitude >> whenResizedDo: aBlock [
	self resizerAptitudeBuilder whenResizedDo: aBlock.
	resizerAptitude ifNotNil: [
		resizerAptitude withAllActorsDepthFirstDo: [ :anAptitude |
			anAptitude whenResizedDo: aBlock ] ]
]
