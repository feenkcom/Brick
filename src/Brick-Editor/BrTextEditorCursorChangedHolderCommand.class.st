"
I trigger a cursor update in the text piece
"
Class {
	#name : #BrTextEditorCursorChangedHolderCommand,
	#superclass : #BrTextEditorHolderCommand,
	#category : #'Brick-Editor-Commands-Holder'
}

{ #category : #executing }
BrTextEditorCursorChangedHolderCommand >> executeOn: aSegmentHolder [
	BlFrameTelemetry
		time: [ 'Segment holder onCursorChanged' ]
		during: [ aSegmentHolder onCursorChanged ]
]
