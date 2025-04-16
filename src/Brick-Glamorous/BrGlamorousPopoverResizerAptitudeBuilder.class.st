"
I build {{gtClass:BrGlamorousWithResizerAptitude}} instances based on given {{gtClass:BlSteppedLayoutMark}} instances.
"
Class {
	#name : #BrGlamorousPopoverResizerAptitudeBuilder,
	#superclass : #BrPopoverResizerAptitudeBuilder,
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #visiting }
BrGlamorousPopoverResizerAptitudeBuilder >> visitSteppedLayoutAllToBottomMark: aMark [
	^ (self
		initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beLeft)
		+ (self
				initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beRight)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beBottom)
]

{ #category : #visiting }
BrGlamorousPopoverResizerAptitudeBuilder >> visitSteppedLayoutAllToLeftMark: aMark [
	^ (self
		initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beLeft)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beTop)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beBottom)
]

{ #category : #visiting }
BrGlamorousPopoverResizerAptitudeBuilder >> visitSteppedLayoutAllToRightMark: aMark [
	^ (self
		initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beRight)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beTop)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beBottom)
]

{ #category : #visiting }
BrGlamorousPopoverResizerAptitudeBuilder >> visitSteppedLayoutAllToUpMark: aMark [
	^ (self
		initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beLeft)
		+ (self
				initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beRight)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beTop)
]

{ #category : #visiting }
BrGlamorousPopoverResizerAptitudeBuilder >> visitSteppedLayoutBottomLeftMark: aMark [
	^ (self
		initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beLeft)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beBottom)
]

{ #category : #visiting }
BrGlamorousPopoverResizerAptitudeBuilder >> visitSteppedLayoutBottomRightMark: aMark [
	^ (self
		initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beRight)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beBottom)
]

{ #category : #visiting }
BrGlamorousPopoverResizerAptitudeBuilder >> visitSteppedLayoutUpLeftMark: aMark [
	^ (self
		initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beLeft)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beTop)
]

{ #category : #visiting }
BrGlamorousPopoverResizerAptitudeBuilder >> visitSteppedLayoutUpRightMark: aMark [
	^ (self
		initializeResizerAptitude: BrGlamorousWithHorizontalResizerAptitude new beRight)
		+ (self
				initializeResizerAptitude: BrGlamorousWithVerticalResizerAptitude new beTop)
]
