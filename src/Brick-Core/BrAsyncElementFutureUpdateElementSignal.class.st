Class {
	#name : #BrAsyncElementFutureUpdateElementSignal,
	#superclass : #BrAsyncElementFutureSignal,
	#instVars : [
		'dataSnapshot'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #accessing }
BrAsyncElementFutureUpdateElementSignal >> dataSnapshot [
	^ dataSnapshot
]

{ #category : #accessing }
BrAsyncElementFutureUpdateElementSignal >> dataSnapshot: anObject [
	dataSnapshot := anObject
]
