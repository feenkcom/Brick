Class {
	#name : #BrFutureHandler,
	#superclass : #Object,
	#instVars : [
		'future',
		'action',
		'monitor'
	],
	#category : 'Brick-Future - Support'
}

{ #category : #'api - initialization' }
BrFutureHandler >> action: aBlockOrMessageSend [
	action := aBlockOrMessageSend
]

{ #category : #initialization }
BrFutureHandler >> initialize [
	super initialize.
	
	monitor := Monitor new
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
				future await
					onSuccessDo: [ :aResult |
						monitor critical: [
							future == aFuture
								ifTrue: [ action cull: aResult cull: false ] ] ];
					onFailureDo: [ :anError |
						NonInteractiveTranscript stdout
							nextPutAll: anError printString;
							cr ] ] ]
]
