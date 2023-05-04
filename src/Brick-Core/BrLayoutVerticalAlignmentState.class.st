Class {
	#name : #BrLayoutVerticalAlignmentState,
	#superclass : #BrLayoutAlignmentState,
	#category : #'Brick-Core-Layout Alignment'
}

{ #category : #accessing }
BrLayoutVerticalAlignmentState class >> center [
	^ BrLayoutVerticalAlignmentCenterState uniqueInstance
]

{ #category : #accessing }
BrLayoutVerticalAlignmentState class >> end [
	^ BrLayoutVerticalAlignmentEndState uniqueInstance
]

{ #category : #accessing }
BrLayoutVerticalAlignmentState class >> none [
	^ BrLayoutVerticalAlignmentNoneState uniqueInstance
]

{ #category : #accessing }
BrLayoutVerticalAlignmentState class >> start [
	^ BrLayoutVerticalAlignmentStartState uniqueInstance
]

{ #category : #accessing }
BrLayoutVerticalAlignmentState >> type [
	^ BrLayoutVerticalAlignmentState
]
