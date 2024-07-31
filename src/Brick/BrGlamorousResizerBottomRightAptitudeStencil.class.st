Class {
	#name : #BrGlamorousResizerBottomRightAptitudeStencil,
	#superclass : #BrGlamorousResizerAptitudeStencil,
	#category : #'Brick-Dropdown - Helpers'
}

{ #category : #accessing }
BrGlamorousResizerBottomRightAptitudeStencil >> create [
	^ (self createResizeAptitudeWith: BrGlamorousWithHorizontalResizerAptitude new beRight)
		+ (self createResizeAptitudeWith: BrGlamorousWithVerticalResizerAptitude new beBottom)
]
