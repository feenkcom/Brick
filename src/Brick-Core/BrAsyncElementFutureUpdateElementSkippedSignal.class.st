Class {
	#name : #BrAsyncElementFutureUpdateElementSkippedSignal,
	#superclass : #BrAsyncElementFutureSignal,
	#instVars : [
		'dataSnapshot',
		'previousDataSnapshot'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #accessing }
BrAsyncElementFutureUpdateElementSkippedSignal >> dataSnapshot [
	^ dataSnapshot
]

{ #category : #accessing }
BrAsyncElementFutureUpdateElementSkippedSignal >> dataSnapshot: anObject [
	dataSnapshot := anObject
]

{ #category : #accessing }
BrAsyncElementFutureUpdateElementSkippedSignal >> previousDataSnapshot [
	^ previousDataSnapshot
]

{ #category : #accessing }
BrAsyncElementFutureUpdateElementSkippedSignal >> previousDataSnapshot: anObject [
	previousDataSnapshot := anObject
]
