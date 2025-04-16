Class {
	#name : #BrFutureHandler,
	#superclass : #Object,
	#instVars : [
		'future',
		'action',
		'monitor',
		'configuration'
	],
	#category : #'Brick-Future - Support'
}

{ #category : #'api - initialization' }
BrFutureHandler >> action: aBlockOrMessageSend [
	action := aBlockOrMessageSend
]

{ #category : #accessing }
BrFutureHandler >> configuration [
	<return: #AsyncFutureExecutionConfiguration>
	^ configuration ifNil: [ configuration := self defaultConfiguration ]
]

{ #category : #accessing }
BrFutureHandler >> configuration: aAsyncFutureExecutionConfiguration [
	configuration := aAsyncFutureExecutionConfiguration
]

{ #category : #initialization }
BrFutureHandler >> defaultConfiguration [
	^ AsyncFutureExecutionConfiguration new
		customGroup: #UI;
		highPriority
]

{ #category : #initialization }
BrFutureHandler >> initialize [
	super initialize.
	
	monitor := Mutex new
]

{ #category : #'api - initialization' }
BrFutureHandler >> receiver: anObject selector: aSelector [
	self action: (MessageSend receiver: anObject selector: aSelector)
]

{ #category : #'api - future handler' }
BrFutureHandler >> updateWithFuture: aFuture [
	monitor critical: [ 
		future := aFuture.
		future isReadyFuture
			ifTrue: [
				| theCurrentResult |
				theCurrentResult := future takeOutput.
				future := nil.
				action cull: theCurrentResult cull: true ]
			ifFalse: [
				(future await: self configuration)
					then: [ :aResult |
						monitor critical: [
							future == aFuture
								ifTrue: [ action cull: aResult cull: false ] ] ]
					otherwise: [ :anError |
						NonInteractiveTranscript stdout
							nextPutAll: anError printString;
							cr ] ] ]
]
