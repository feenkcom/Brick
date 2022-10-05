Class {
	#name : #BrElementUpdaterPendingUpdateTask,
	#superclass : #BlTask,
	#instVars : [
		'updater',
		'isUpdated'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #accessing }
BrElementUpdaterPendingUpdateTask >> beUpdated [
	isUpdated := true
]

{ #category : #initiailize }
BrElementUpdaterPendingUpdateTask >> initialize [
	super initialize.
	isUpdated := false
]

{ #category : #testing }
BrElementUpdaterPendingUpdateTask >> isUpdated [
	^ isUpdated ifNil: [ false ]
]

{ #category : #printing }
BrElementUpdaterPendingUpdateTask >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	aStream
		nextPutAll: 'Pending element update task: ';
		print: (self updater ifNotNil: #element)
]

{ #category : #accessing }
BrElementUpdaterPendingUpdateTask >> requeueTaskAfterExecution [
	^ self isUpdated not
		and: [ self updater ifNotNil: #isUpdateRequested ifNil: [ false ] ]
]

{ #category : #accessing }
BrElementUpdaterPendingUpdateTask >> run: aWaker [
	"do nothing, just wait"

	
]

{ #category : #accessing }
BrElementUpdaterPendingUpdateTask >> updater [

	^ updater
]

{ #category : #accessing }
BrElementUpdaterPendingUpdateTask >> updater: anObject [

	updater := anObject
]
