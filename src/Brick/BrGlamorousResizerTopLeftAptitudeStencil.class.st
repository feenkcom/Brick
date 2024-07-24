Class {
	#name : #BrGlamorousResizerTopLeftAptitudeStencil,
	#superclass : #BrGlamorousResizerAptitudeStencil,
	#category : #'Brick-Dropdown - Helpers'
}

{ #category : #accessing }
BrGlamorousResizerTopLeftAptitudeStencil >> create [
	^ (self createResizeAptitudeWith: BrGlamorousWithHorizontalResizerAptitude new beLeft)
		+ (self createResizeAptitudeWith: BrGlamorousWithVerticalResizerAptitude new beTop)
]
