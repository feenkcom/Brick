Class {
	#name : #BrGlamorousResizerBottomLeftAptitudeStencil,
	#superclass : #BrGlamorousResizerAptitudeStencil,
	#category : #'Brick-Dropdown - Helpers'
}

{ #category : #accessing }
BrGlamorousResizerBottomLeftAptitudeStencil >> create [
	^ (self createResizeAptitudeWith: BrGlamorousWithHorizontalResizerAptitude new beLeft)
		+ (self createResizeAptitudeWith: BrGlamorousWithVerticalResizerAptitude new beBottom)
]
