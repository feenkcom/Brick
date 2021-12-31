Class {
	#name : #BrTextStylerSignal,
	#superclass : #ContextStackSignal,
	#category : 'Brick-Editor-Signals'
}

{ #category : #testing }
BrTextStylerSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	See {{gtMethod:BeaconSignal class>>gtNormalOperationSignal}} for a description"

	^ true.
]
