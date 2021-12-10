Class {
	#name : #BrAsyncElementPromiseSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'element',
		'promise',
		'spaceTasks',
		'elementTasks',
		'dataSnapshot'
	],
	#category : #'Brick-Future - Support'
}

{ #category : #'instance creation' }
BrAsyncElementPromiseSignal class >> forElement: anElement [
	^ self new
		element: anElement;
		yourself
]

{ #category : #accessing }
BrAsyncElementPromiseSignal >> dataSnapshot [

	^ dataSnapshot
]

{ #category : #accessing }
BrAsyncElementPromiseSignal >> dataSnapshot: anObject [

	dataSnapshot := anObject
]

{ #category : #accessing }
BrAsyncElementPromiseSignal >> element [

	^ element
]

{ #category : #accessing }
BrAsyncElementPromiseSignal >> element: anObject [

	element := anObject
]

{ #category : #accessing }
BrAsyncElementPromiseSignal >> elementTasks [

	^ elementTasks
]

{ #category : #accessing }
BrAsyncElementPromiseSignal >> prepareForDelivery [
	element ifNil: [ ^ self ].

	spaceTasks := (element space ifNotNil: [ :s | s taskQueue tasks ]).
	elementTasks := element taskQueue tasks
]

{ #category : #accessing }
BrAsyncElementPromiseSignal >> promise [

	^ promise
]

{ #category : #accessing }
BrAsyncElementPromiseSignal >> promise: anObject [

	promise := anObject
]

{ #category : #accessing }
BrAsyncElementPromiseSignal >> spaceTasks [

	^ spaceTasks
]
