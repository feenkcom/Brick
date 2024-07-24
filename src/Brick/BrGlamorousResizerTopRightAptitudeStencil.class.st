Class {
	#name : #BrGlamorousResizerTopRightAptitudeStencil,
	#superclass : #BrGlamorousResizerAptitudeStencil,
	#category : #'Brick-Dropdown - Helpers'
}

{ #category : #accessing }
BrGlamorousResizerTopRightAptitudeStencil >> create [
	^ (self createResizeAptitudeWith: BrGlamorousWithHorizontalResizerAptitude new beRight)
		+ (self createResizeAptitudeWith: BrGlamorousWithVerticalResizerAptitude new beTop)
]
