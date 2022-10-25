"
I am used by {{gtClass:BrElementUpdater}}  which enqueues me to trigger an {{gtClass:BlElement | label=element}} update in a next {{gtMethod:BlSpace>>#pulse|label=space pulse}}.

See method {{gtMethod:BrElementUpdater>>#enqueueUpdate}} for more details.

"
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
