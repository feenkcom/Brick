Class {
	#name : #BrTextEditorCommand,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'context'
	],
	#category : #'Brick-Editor-Commands'
}

{ #category : #accessing }
BrTextEditorCommand >> context [
	^ context
]

{ #category : #accessing }
BrTextEditorCommand >> context: anObject [
	context := anObject
]

{ #category : #executing }
BrTextEditorCommand >> executeOn: aTextEditor [
	self subclassResponsibility
]

{ #category : #accessing }
BrTextEditorCommand >> telemetry [
	<return: #Telemetry>

	^ BlFrameTelemetry
]
