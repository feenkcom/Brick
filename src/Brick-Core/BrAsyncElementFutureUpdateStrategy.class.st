Class {
	#name : #BrAsyncElementFutureUpdateStrategy,
	#superclass : #Object,
	#category : #'Brick-Core-Futures'
}

{ #category : #accessing }
BrAsyncElementFutureUpdateStrategy >> addEventHandlersOn: anElement withFuture: aFuture [
]

{ #category : #accessing }
BrAsyncElementFutureUpdateStrategy >> needsUpdate: anElement [
	self subclassResponsibility
]

{ #category : #accessing }
BrAsyncElementFutureUpdateStrategy >> removeEventHandlersFrom: anElement withFuture: aFuture [
]
