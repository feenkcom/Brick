"
I split a piece of text behind a {{gtClass:BrTextEditorLineSegment}} into pieces {{gtClass:BrTextEditorAbstractSegmentPiece}}.

"
Class {
	#name : #BrTextEditorLineSegmentSplitter,
	#superclass : #BrTextEditorAbstractSegmentSplitter,
	#category : #'Brick-Editor-Model - Segment-Text-Line'
}

{ #category : #'private - pieces computation' }
BrTextEditorLineSegmentSplitter >> itemValueType: anObject [
	"Return a type of an item within a segment.
	Note: return value should be never used explicitely, it is only needed
	for direct comparison, therefore can be any immutable object"
	<return: #Symbol>

	^ anObject isCharacter
		ifTrue: [ anObject isSeparator
			ifTrue: [ #separator ]
			ifFalse: [ #letter ] ]
		ifFalse: [ #object ]
]
