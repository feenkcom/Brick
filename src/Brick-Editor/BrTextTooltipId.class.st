"
I represent an id for a given {{gtClass:BrWithExplicitPopoverAptitude}}. 
I am used by {{gtClass:BrTextTooltipAttribute}}. 
"
Class {
	#name : #BrTextTooltipId,
	#superclass : #Object,
	#instVars : [
		'startIndex',
		'stopIndex'
	],
	#category : #'Brick-Editor-Attributes - Support'
}

{ #category : #'instance creation' }
BrTextTooltipId class >> from: aStartIndex to: aStopIndex [
	^ self new
		startIndex: aStartIndex;
		stopIndex: aStopIndex
]

{ #category : #comparing }
BrTextTooltipId >> = anObject [
	self == anObject ifTrue: [ ^ true ].

	self class = anObject class ifFalse: [ ^ false ].

	^ self startIndex = anObject startIndex
		and: [ self stopIndex = anObject stopIndex ]
]

{ #category : #comparing }
BrTextTooltipId >> hash [
	^ self startIndex hash bitXor: self stopIndex hash
]

{ #category : #printing }
BrTextTooltipId >> printIdOn: aStream [
	aStream
		nextPut: $[;
		print: self startIndex;
		nextPut: $,;
		print: self stopIndex;
		nextPut: $]
]

{ #category : #printing }
BrTextTooltipId >> printOn: aStream [
	super printOn: aStream.
	self printIdOn: aStream
]

{ #category : #accessing }
BrTextTooltipId >> startIndex [
	^ startIndex
]

{ #category : #accessing }
BrTextTooltipId >> startIndex: anObject [
	startIndex := anObject
]

{ #category : #accessing }
BrTextTooltipId >> stopIndex [
	^ stopIndex
]

{ #category : #accessing }
BrTextTooltipId >> stopIndex: anObject [
	stopIndex := anObject
]
