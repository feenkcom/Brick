"
I am used by {{gtClass:BrElementUpdater}} to explicitly inform {{gtClass:BlScripter}} that there is a pending and postponed update task.
Once, the pending action is scheduled, I am removed from the space task queue ({{gtClass:BlSpaceTaskQueue}}) and a {{gtClass:BrElementUpdaterUpdateTask}} is enqueued. 

See method {{gtMethod:BrElementUpdater>>#enqueuePostponedUpdate}} for more details.


"
Class {
	#name : #BrElementUpdaterPendingUpdateTask,
	#superclass : #BlTask,
	#instVars : [
		'updater',
		'isUpdated'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #'api - running' }
BrElementUpdaterPendingUpdateTask >> beUpdated [
	isUpdated := true
]

{ #category : #initiailize }
BrElementUpdaterPendingUpdateTask >> initialize [
	super initialize.
	isUpdated := false
]

{ #category : #'private - testing' }
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

{ #category : #'private - testing' }
BrElementUpdaterPendingUpdateTask >> requeueTaskAfterExecution [
	^ self isUpdated not
]

{ #category : #'api - running' }
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
