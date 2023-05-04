Class {
	#name : #BrLayoutHorizontalAlignmentState,
	#superclass : #BrLayoutAlignmentState,
	#category : #'Brick-Core-Layout Alignment'
}

{ #category : #accessing }
BrLayoutHorizontalAlignmentState class >> center [
	^ BrLayoutHorizontalAlignmentCenterState uniqueInstance
]

{ #category : #accessing }
BrLayoutHorizontalAlignmentState class >> end [
	^ BrLayoutHorizontalAlignmentEndState uniqueInstance
]

{ #category : #accessing }
BrLayoutHorizontalAlignmentState class >> none [
	^ BrLayoutHorizontalAlignmentNoneState uniqueInstance
]

{ #category : #accessing }
BrLayoutHorizontalAlignmentState class >> start [
	^ BrLayoutHorizontalAlignmentStartState uniqueInstance
]

{ #category : #accessing }
BrLayoutHorizontalAlignmentState >> type [
	^ BrLayoutHorizontalAlignmentState
]
