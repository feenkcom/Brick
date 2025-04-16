"
I know how to resize menu elements.
I use {{gtClass:BrGlamorousPopoverResizerAptitudeBuilder}} to create new resizers.

"
Class {
	#name : #BrGlamorousPopoverResizableAptitude,
	#superclass : #BrPopoverResizableAptitude,
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #initialization }
BrGlamorousPopoverResizableAptitude >> defaultResizerAptitudeBuilder [
	^ BrGlamorousPopoverResizerAptitudeBuilder new
]
