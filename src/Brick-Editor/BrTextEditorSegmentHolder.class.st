"
I am a text segment holder (===BrTextEditorSegment===) designed to be used by ===BrTextEditor===
"
Class {
	#name : #BrTextEditorSegmentHolder,
	#superclass : #BrEditorSegmentHolder,
	#instVars : [
		'segment',
		'pieceElements'
	],
	#category : #'Brick-Editor-Model - Segment-Text'
}

{ #category : #'private - testing' }
BrTextEditorSegmentHolder >> hasCursor [
	| aTextEditor |
	aTextEditor := self infiniteElement editor.
	aTextEditor cursors
		do: [ :aCursor | 
			(aCursor insideSegment: segment)
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'private - testing' }
BrTextEditorSegmentHolder >> hasSelection [
	| aTextEditor textInterval |

	aTextEditor := self infiniteElement editor.
	textInterval := BlSelection from: (segment textStart + 1 min: segment textEnd) to: segment textEnd.
	
	(aTextEditor selection + aTextEditor selectionRecorder selection) do: [ :aSelection |
		(aSelection overlaps: textInterval)
			ifTrue: [ ^ true ] ].

	^ false
]

{ #category : #'private - segment' }
BrTextEditorSegmentHolder >> newPiecesMap [
	^ BrTextEditorLineSegmentPieceDictionaryMap new
]

{ #category : #updating }
BrTextEditorSegmentHolder >> onCursorChanged [
	"Is sent when text editor's cursor changes.
	Segment holder should update text elements accordingly"
	
	self subclassResponsibility
]

{ #category : #updating }
BrTextEditorSegmentHolder >> onFocusChanged: aBoolean [
	"Is sent when text editor's focus state changes.
	Segment holder should update text elements accordingly"

	self subclassResponsibility
]

{ #category : #updating }
BrTextEditorSegmentHolder >> onSelectionChanged [
	"Is sent when text editor's selection changes.
	Segment holder should update text elements accordingly"
	
	self subclassResponsibility
]

{ #category : #updating }
BrTextEditorSegmentHolder >> onTextChanged [
	"Is sent when text changed in the editor (for example style attributes).
	Segment holder should update text elements accordingly"

	self
		assert: [ segment isNotNil ]
		description: [ 'Segment must be bound!' ].

	pieceElements piecesAndTheirElementsDo: [ :aPiece :aPieceElement |
		aPiece updateText: aPieceElement of: segment in: self infiniteElement ]
]

{ #category : #cursor }
BrTextEditorSegmentHolder >> screenToCursor: aTransformation [
	aTransformation evaluateOn: self
]

{ #category : #'private - segment' }
BrTextEditorSegmentHolder >> updateConstraints [
	itemElement
		constraintsDo: [ :c | c horizontal resizer: infiniteElement constraints horizontal resizer ];
		padding: segment paragraphMargin
]

{ #category : #'private - segment' }
BrTextEditorSegmentHolder >> updateCursorPresent: hasCursor selectionPresent: hasSelection [ 
	self subclassResponsibility
]

{ #category : #'private - segment' }
BrTextEditorSegmentHolder >> updatePieceElements [
	| newPieceElements newPieceMap |
	newPieceMap := self newPiecesMap.
	newPieceElements := OrderedCollection new.
	segment pieces
		do: [ :eachSegmentPiece | 
			| thePieceElements |
			thePieceElements := pieceElements
					at: eachSegmentPiece
					pieceAndElementsDo: [ :eachPiece :theSegmentElements | 
						eachSegmentPiece currentCursors: eachPiece currentCursors.
						theSegmentElements
							do: [ :eachSegmentElement | 
								eachPiece
									updateText: eachSegmentElement
									of: segment
									in: self infiniteElement ].
						theSegmentElements ]
					ifAbsent: [ (eachSegmentPiece createElement: self infiniteElement)
							asOrderedCollection ].

			newPieceElements addAll: thePieceElements.
			newPieceMap atPiece: eachSegmentPiece putElements: thePieceElements ].

	pieceElements := newPieceMap.
	^ newPieceElements
]

{ #category : #'private - segment' }
BrTextEditorSegmentHolder >> updateSegment [
	| newPieceElements hasCursor hasSelection |
	
	(BrTextEditorSegmentUpdateSignal new
		textEditor: self editor;
		segment: segment;
		itemElement: itemElement) emit.
	
	hasSelection := self hasSelection.
	hasCursor := self hasCursor.
	
	segment updateSegmentProperties.

	newPieceElements := self updatePieceElements.

	itemElement removeChildren.
	itemElement addChildren: newPieceElements.
	self updateCursorPresent: hasCursor selectionPresent: hasSelection.
	self updateConstraints
]
