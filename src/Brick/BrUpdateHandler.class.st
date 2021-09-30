Class {
	#name : #BrUpdateHandler,
	#superclass : #Object,
	#instVars : [
		'action',
		'monitor',
		'updateTask',
		'result',
		'element'
	],
	#category : 'Brick-Future - Support'
}

{ #category : #'api - initialization' }
BrUpdateHandler >> element: anElement action: aBlockOrMessageSend [
	element := anElement.
	action := aBlockOrMessageSend
]

{ #category : #'api - initialization' }
BrUpdateHandler >> element: anElement selector: aSelector [
	self
		element: anElement
		action: (MessageSend receiver: anElement selector: aSelector)
]

{ #category : #initialization }
BrUpdateHandler >> initialize [
	super initialize.
	
	monitor := Monitor new.
	result := nil.
	updateTask := nil.
]

{ #category : #'api - future handler' }
BrUpdateHandler >> updateValue: aValue synchronously: isSynchronous [
	monitor critical: [ 
		isSynchronous
			ifTrue: [
				result := nil.
				updateTask := nil.
				action cull: aValue ]
			ifFalse: [
				result := aValue.
				updateTask ifNil: [
					| anUpdateTask |

					anUpdateTask := BlTaskAction new.
					anUpdateTask action: [
						monitor critical: [
							| shouldExecuteTask theCurrentResult |
							shouldExecuteTask := updateTask notNil.
							theCurrentResult := result.
							updateTask := nil.
							result := nil.
							shouldExecuteTask ifTrue: [ action cull: theCurrentResult ] ] ].
					updateTask := anUpdateTask.
					element enqueueTask: anUpdateTask ] ] ]
]
