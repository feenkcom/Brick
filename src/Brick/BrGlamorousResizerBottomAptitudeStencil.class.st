Class {
	#name : #BrGlamorousResizerBottomAptitudeStencil,
	#superclass : #BrGlamorousResizerAptitudeStencil,
	#category : #'Brick-Dropdown - Helpers'
}

{ #category : #accessing }
BrGlamorousResizerBottomAptitudeStencil >> create [
	^ (self createResizeAptitudeWith: BrGlamorousWithHorizontalResizerAptitude new beRight)
		+ (self createResizeAptitudeWith: BrGlamorousWithHorizontalResizerAptitude new beLeft)
		+ (self createResizeAptitudeWith: BrGlamorousWithVerticalResizerAptitude new beBottom)
]
