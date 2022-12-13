Class {
	#name : #BrAsyncElementFutureNeverUpdateStrategy,
	#superclass : #BrAsyncElementFutureUpdateStrategy,
	#category : #'Brick-Core-Futures'
}

{ #category : #accessing }
BrAsyncElementFutureNeverUpdateStrategy >> needsUpdate: anElement [
	^ false
]
