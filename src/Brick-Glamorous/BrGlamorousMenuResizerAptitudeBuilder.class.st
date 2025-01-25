"
I build {{gtClass:BrGlamorousWithResizerAptitude}} instances based on given {{gtClass:BlSteppedLayoutMark}} instances.
"
Class {
	#name : #BrGlamorousMenuResizerAptitudeBuilder,
	#superclass : #BrMenuResizerAptitudeBuilder,
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #visiting }
BrGlamorousMenuResizerAptitudeBuilder >> visitSteppedLayoutAllToBottomMark: aMark [
	^ (self
		initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beLeft)
		+ (self
				initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beRight)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beBottom)
]

{ #category : #visiting }
BrGlamorousMenuResizerAptitudeBuilder >> visitSteppedLayoutAllToLeftMark: aMark [
	^ (self
		initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beLeft)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beTop)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beBottom)
]

{ #category : #visiting }
BrGlamorousMenuResizerAptitudeBuilder >> visitSteppedLayoutAllToRightMark: aMark [
	^ (self
		initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beRight)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beTop)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beBottom)
]

{ #category : #visiting }
BrGlamorousMenuResizerAptitudeBuilder >> visitSteppedLayoutAllToUpMark: aMark [
	^ (self
		initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beLeft)
		+ (self
				initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beRight)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beTop)
]

{ #category : #visiting }
BrGlamorousMenuResizerAptitudeBuilder >> visitSteppedLayoutBottomLeftMark: aMark [
	^ (self
		initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beLeft)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beBottom)
]

{ #category : #visiting }
BrGlamorousMenuResizerAptitudeBuilder >> visitSteppedLayoutBottomRightMark: aMark [
	^ (self
		initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beRight)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beBottom)
]

{ #category : #visiting }
BrGlamorousMenuResizerAptitudeBuilder >> visitSteppedLayoutUpLeftMark: aMark [
	^ (self
		initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beLeft)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beTop)
]

{ #category : #visiting }
BrGlamorousMenuResizerAptitudeBuilder >> visitSteppedLayoutUpRightMark: aMark [
	^ (self
		initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beRight)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beTop)
]
