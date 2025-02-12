Class {
	#name : #BrTextEditorSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'textEditor',
		'text'
	],
	#category : #'Brick-Editor-Signals'
}

{ #category : #testing }
BrTextEditorSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	See {{gtMethod:BeaconSignal class>>gtNormalOperationSignal}} for a description"

	^ true.
]

{ #category : #'instance creation' }
BrTextEditorSignal class >> textEditor: aBrTextEditor [
	^ self new textEditor: aBrTextEditor
]

{ #category : #initialization }
BrTextEditorSignal >> prepareForDelivery [
	super prepareForDelivery.

	self textEditor ifNotNil: [ :anEditor | 
		text := anEditor text copy ]
]

{ #category : #accessing }
BrTextEditorSignal >> textEditor [
	^ textEditor
]

{ #category : #accessing }
BrTextEditorSignal >> textEditor: anObject [
	textEditor := anObject
]
