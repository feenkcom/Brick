Class {
	#name : #BrElementUpdaterUpdateTask,
	#superclass : #BlTask,
	#instVars : [
		'updater'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #printing }
BrElementUpdaterUpdateTask >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	aStream
		nextPutAll: 'Element update task: ';
		print: (self updater ifNotNil: #element)
]

{ #category : #'api - running' }
BrElementUpdaterUpdateTask >> run: aWaker [
	self updater ifNotNil: [ :anUpdater | anUpdater updateNow ]
]

{ #category : #accessing }
BrElementUpdaterUpdateTask >> updater [

	^ updater
]

{ #category : #accessing }
BrElementUpdaterUpdateTask >> updater: anObject [

	updater := anObject
]
