Class {
	#name : #BrTextEditorLineSegmentPiece,
	#superclass : #BrTextEditorAbstractSegmentPiece,
	#category : #'Brick-Editor-Model - Segment-Text-Line'
}

{ #category : #'api - cursor' }
BrTextEditorLineSegmentPiece >> findAddedCursors: theUpdatedCursors to: theCurrentCursors [
	"Find which cursors are new relative to the set of current cursors"
	<return: #Set of: #BrTextEditorSingleCursor>
	
	^ theUpdatedCursors difference: theCurrentCursors
]

{ #category : #'api - cursor' }
BrTextEditorLineSegmentPiece >> findRemovedCursors: theUpdatedCursors from: theCurrentCursors [
	"Find which cursors were removed relative from the set of current cursors"
	<return: #Set of: #BrTextEditorSingleCursor>
	
	^ theCurrentCursors difference: theUpdatedCursors
]

{ #category : #'api - cursor' }
BrTextEditorLineSegmentPiece >> globalCursorToLocal: aSingleCursor [
	"Convert a global cursor as specified in the editor to a local one"
	<return: #BrTextEditorSingleCursor>
	| aLocalCursor |
	
	aLocalCursor := aSingleCursor copy.
	aLocalCursor position: (self globalTextIndexToLocal: aSingleCursor position).
	
	^ aLocalCursor
]

{ #category : #'api - cursor' }
BrTextEditorLineSegmentPiece >> globalTextIndexToLocal: aTextIndex [
	"Convert global text index given in the text coordinates of the whole editor to a local index within this segment piece.
	This convertion is necessary due to the fact that text elements that represent every segment piece work with text in their own local system"
	<return: #Number>

	^ self isEmpty
		ifTrue: [ 0 ]
		ifFalse: [ aTextIndex - self textStart ]
]

{ #category : #'cursor - hooks' }
BrTextEditorLineSegmentPiece >> onCursorAdded: aCursor to: aPieceElement in: anEditorElement [
	"Is sent when a cursor is added to a given piece element within provided editor element"

	aPieceElement dispatchEvent:
		(BrTextEditorShowCursorRequest new
			editorElement: anEditorElement;
			hasFocus: anEditorElement isFocused;
			cursorPosition: aCursor position)
]

{ #category : #'cursor - hooks' }
BrTextEditorLineSegmentPiece >> onCursorRemoved: aCursor from: aPieceElement in: anEditorElement [
	"Is sent when a cursor is removed from a given piece element within provided editor element"
	
	aPieceElement dispatchEvent:
		(BrTextEditorHideCursorRequest new
			editorElement: anEditorElement;
			cursorPosition: aCursor position)
]

{ #category : #'api - cursor' }
BrTextEditorLineSegmentPiece >> screenToCursor: aTransformation of: anEditorElement in: aPieceElement [

	aPieceElement dispatchEvent:
		(BrTextEditorScreenToCursorRequest new
			transformation: aTransformation;
			editorElement: anEditorElement)
]

{ #category : #updating }
BrTextEditorLineSegmentPiece >> setCursor: aPieceElement of: aLineSegment in: anEditorElement [
	| theUpdatedCursors aFocusRequest |
	"select text editor cursors that are currently within this segment piece and convert them to local ones"
	theUpdatedCursors := (anEditorElement editor cursors allCursors
		select: [ :aCursor | aCursor insideSubText: self of: aLineSegment ]
		thenCollect: [ :aCursor | self globalCursorToLocal: aCursor ]) asSet.

	"update current cursors"
	currentCursors := theUpdatedCursors.

	"tell to add new cursors"
	theUpdatedCursors
		do: [ :aCursor | self onCursorAdded: aCursor to: aPieceElement in: anEditorElement ].
	aFocusRequest := anEditorElement isFocused
		ifTrue: [ BrTextEditorFocusRequest new ]
		ifFalse: [ BrTextEditorBlurRequest new ].
	aPieceElement
		dispatchEvent: (aFocusRequest editorElement: anEditorElement)
]

{ #category : #updating }
BrTextEditorLineSegmentPiece >> updateCursor: aPieceElement of: aLineSegment in: anEditorElement [
	| theUpdatedCursors theAddedCursors theRemovedCursors |
	"select text editor cursors that are currently within this segment piece and convert them to local ones"
	theUpdatedCursors := (anEditorElement editor cursors allCursors
		select: [ :aCursor | aCursor insideSubText: self of: aLineSegment ]
		thenCollect: [ :aCursor | self globalCursorToLocal: aCursor ]) asSet.
	theAddedCursors := self
		findAddedCursors: theUpdatedCursors
		to: self currentCursors.
	theRemovedCursors := self
		findRemovedCursors: theUpdatedCursors
		from: self currentCursors.

	"update current cursors"
	currentCursors := theUpdatedCursors.

	"tell to remove deleted cursors"
	theRemovedCursors
		do: [ :aCursor | self onCursorRemoved: aCursor from: aPieceElement in: anEditorElement ].

	"tell to add new cursors"
	theAddedCursors
		do: [ :aCursor | self onCursorAdded: aCursor to: aPieceElement in: anEditorElement ]
]

{ #category : #updating }
BrTextEditorLineSegmentPiece >> updateSelection: aTextElement of: aLineSegment in: anEditorElement [
	| aTextEditor |

	aTextEditor := anEditorElement editor.

	aTextElement dispatchEvent: (BrTextEditorDeselectRequest new
		editorElement: anEditorElement;
		fromIndex: 0;
		toIndex: self textLength).

	(aTextEditor selection + aTextEditor selectionRecorder selection) do: [ :aSelection |
		| aSelectionInterval textInterval |
		aSelectionInterval := aSelection interval.
		textInterval := BlSelection from: (self textStart + 1 min: self textEnd) to: self textEnd.
		(aSelection overlaps: textInterval)
			ifTrue: [
				| localFrom localTo |
				localFrom := (aSelectionInterval first - self textStart) max: 0.
				localTo := (aSelectionInterval last - self textStart) min: self textLength + 1.

				aTextElement dispatchEvent: (BrTextEditorSelectRequest new
					editorElement: anEditorElement;
					fromIndex: localFrom;
					toIndex: localTo) ] ]
]
