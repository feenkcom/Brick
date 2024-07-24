Class {
	#name : #BrGlamorousResizerTopAptitudeStencil,
	#superclass : #BrGlamorousResizerAptitudeStencil,
	#category : #'Brick-Dropdown - Helpers'
}

{ #category : #accessing }
BrGlamorousResizerTopAptitudeStencil >> create [
	^ (self createResizeAptitudeWith: BrGlamorousWithHorizontalResizerAptitude new beRight)
		+ (self createResizeAptitudeWith: BrGlamorousWithHorizontalResizerAptitude new beLeft)
		+ (self createResizeAptitudeWith: BrGlamorousWithVerticalResizerAptitude new beTop)
]
