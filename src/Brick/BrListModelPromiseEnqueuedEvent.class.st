Class {
	#name : #BrListModelPromiseEnqueuedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'promise'
	],
	#category : #'Brick-List - Events'
}

{ #category : #accessing }
BrListModelPromiseEnqueuedEvent >> promise [

	^ promise
]

{ #category : #accessing }
BrListModelPromiseEnqueuedEvent >> promise: anObject [

	promise := anObject
]
