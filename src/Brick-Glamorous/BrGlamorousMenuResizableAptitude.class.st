Class {
	#name : #BrGlamorousMenuResizableAptitude,
	#superclass : #BrMenuResizableAptitude,
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #initialization }
BrGlamorousMenuResizableAptitude >> defaultResizerAptitudeBuilder [
	^ BrGlamorousMenuResizerAptitudeBuilder new
]
