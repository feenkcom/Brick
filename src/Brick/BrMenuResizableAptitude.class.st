Class {
	#name : #BrMenuResizableAptitude,
	#superclass : #BrAptitude,
	#traits : 'TBlSteppedLayoutMarkVisitor',
	#classTraits : 'TBlSteppedLayoutMarkVisitor classTrait',
	#instVars : [
		'lastMark',
		'whenResizedHandler',
		'isKeepRatio',
		'resizerAptitude'
	],
	#category : #'Brick-Menu - Aptitude'
}

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

{ #category : #private }
BrMenuResizableAptitude >> initializeResizerAptitude: anAptitude [
	whenResizedHandler ifNotNil: [ anAptitude whenResizedDo: whenResizedHandler ].
	isKeepRatio ifNotNil: [ :aBoolean | anAptitude keepRatio: aBoolean ].
	^ anAptitude
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
	| aMark |
	aMark := self mark.
	aMark = self lastMark ifTrue: [ ^ self ].
	lastMark := aMark.
	self visitMark: aMark
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

{ #category : #visiting }
BrMenuResizableAptitude >> visitSteppedLayoutAllToBottomMark: aMark [
	| anAptitude |
	anAptitude := (self
			initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beLeft)
			+ (self
					initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beRight)
			+ (self
					initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beBottom).
	self resizerAptitude: anAptitude
]

{ #category : #visiting }
BrMenuResizableAptitude >> visitSteppedLayoutAllToLeftMark: aMark [
	| anAptitude |
	anAptitude := (self
			initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beLeft)
			+ (self
					initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beTop)
			+ (self
					initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beBottom).
	self resizerAptitude: anAptitude
]

{ #category : #visiting }
BrMenuResizableAptitude >> visitSteppedLayoutAllToRightMark: aMark [
	| anAptitude |
	anAptitude := (self
			initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beRight)
			+ (self
					initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beTop)
			+ (self
					initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beBottom).
	self resizerAptitude: anAptitude
]

{ #category : #visiting }
BrMenuResizableAptitude >> visitSteppedLayoutAllToUpMark: aMark [
	| anAptitude |
	anAptitude := (self
			initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beLeft)
			+ (self
					initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beRight)
			+ (self
					initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beTop).
	self resizerAptitude: anAptitude
]

{ #category : #visiting }
BrMenuResizableAptitude >> visitSteppedLayoutBottomLeftMark: aMark [
	| anAptitude |
	anAptitude := (self
			initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beLeft)
			+ (self
					initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beBottom).
	self resizerAptitude: anAptitude
]

{ #category : #visiting }
BrMenuResizableAptitude >> visitSteppedLayoutBottomRightMark: aMark [
	| anAptitude |
	anAptitude := (self
			initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beRight)
			+ (self
					initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beBottom).
	self resizerAptitude: anAptitude
]

{ #category : #visiting }
BrMenuResizableAptitude >> visitSteppedLayoutMark: aMark [
	self removeResizerAptitude
]

{ #category : #visiting }
BrMenuResizableAptitude >> visitSteppedLayoutUpLeftMark: aMark [
	| anAptitude |
	anAptitude := (self
			initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beLeft)
			+ (self
					initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beTop).
	self resizerAptitude: anAptitude
]

{ #category : #visiting }
BrMenuResizableAptitude >> visitSteppedLayoutUpRightMark: aMark [
	| anAptitude |
	anAptitude := (self
			initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beRight)
			+ (self
					initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beTop).
	self resizerAptitude: anAptitude
]

{ #category : #'api - initialization' }
BrMenuResizableAptitude >> whenResizedDo: aBlock [
	whenResizedHandler := aBlock.
	resizerAptitude ifNotNil: [
		resizerAptitude withAllActorsDepthFirstDo: [ :anAptitude |
			anAptitude whenResizedDo: whenResizedHandler ] ]
]
