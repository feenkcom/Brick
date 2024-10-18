Class {
	#name : #BrTextEditorSegmentSignal,
	#superclass : #BrTextEditorSignal,
	#instVars : [
		'itemElement',
		'segment'
	],
	#category : #'Brick-Editor-Signals'
}

{ #category : #accessing }
BrTextEditorSegmentSignal >> itemElement [
	^ itemElement
]

{ #category : #accessing }
BrTextEditorSegmentSignal >> itemElement: anObject [
	itemElement := anObject
]

{ #category : #initialization }
BrTextEditorSegmentSignal >> prepareForDelivery [
	super prepareForDelivery.

	segment := segment copy
]

{ #category : #accessing }
BrTextEditorSegmentSignal >> segment [
	^ segment
]

{ #category : #accessing }
BrTextEditorSegmentSignal >> segment: anObject [
	segment := anObject
]
