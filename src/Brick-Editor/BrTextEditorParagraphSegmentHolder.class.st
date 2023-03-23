Class {
	#name : #BrTextEditorParagraphSegmentHolder,
	#superclass : #BrTextEditorSegmentHolder,
	#classInstVars : [
		'defaultSegmentLayoutBlock'
	],
	#category : #'Brick-Editor-Model - Segment-Text-Paragraph'
}

{ #category : #cleanup }
BrTextEditorParagraphSegmentHolder class >> cleanUp [
	super cleanUp.
	
	defaultSegmentLayoutBlock := nil
]

{ #category : #accessing }
BrTextEditorParagraphSegmentHolder class >> defaultSegmentLayout [
	^ (defaultSegmentLayoutBlock ifNil: [ BrEditorTextFlowLayout new ]) value
]

{ #category : #accessing }
BrTextEditorParagraphSegmentHolder class >> defaultSegmentLayout: aBlock [
	defaultSegmentLayoutBlock := aBlock
]

{ #category : #'private - segment' }
BrTextEditorParagraphSegmentHolder >> buildSegment: anEditorSegment [
	| newPieceElements thePieces hasSelection hasCursor |
	segment := anEditorSegment.
	itemElement segment: segment.

	hasSelection := self hasSelection.
	hasCursor := self hasCursor.
	itemElement text: segment text.

	segment updateSegmentProperties.

	pieceElements := self newPiecesMap.
	newPieceElements := OrderedCollection new.

	thePieces := segment pieces.

	thePieces
		withIndexDo: [ :aPiece :eachIndex | 
			| thePieceElements |
			thePieceElements := (aPiece createElement: self infiniteElement)
					asOrderedCollection.

			newPieceElements addAll: thePieceElements.
			pieceElements atPiece: aPiece putElements: thePieceElements ].

	itemElement removeChildren.
	itemElement addChildren: newPieceElements.

	(hasCursor or: [ hasSelection ])
		ifTrue: [ hasCursor ifTrue: [ self onCursorChanged ].
			hasSelection ifTrue: [ self onSelectionChanged ] ].

	itemElement
		constraintsDo: [ :c | c horizontal resizer: infiniteElement constraints horizontal resizer ];
		padding: anEditorSegment paragraphMargin
]

{ #category : #initialization }
BrTextEditorParagraphSegmentHolder >> createSegmentElement [
	<return: #BlElement>

	^ BrTextEditorParagraphElement new
		beInSeparateCompositionLayer;
		focusability: BlFocusability block;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		aptitude: (BrLayoutResizerAptitude new
			hInherit;
			vAnyToFitContent);
		yourself
]

{ #category : #cursor }
BrTextEditorParagraphSegmentHolder >> explicitScreenToCursor: aTransformation [
	| aBoundsInEditor aTransformedScreenPosition |
	
	aTransformedScreenPosition := aTransformation screenPosition.
	aBoundsInEditor := (itemElement bounds inParent: self infiniteElement) bounds.
	
	"if location is above the first segment then the index is 0"
	((segment isFirstIn: self editor) and: [ aTransformedScreenPosition y < aBoundsInEditor top ])
		ifTrue: [ ^ aTransformation transformed: 0 ].

	"if location is below the last segment then the index is text size"
	((segment isLastIn: self editor) and: [ aTransformedScreenPosition y > aBoundsInEditor bottom ])
		ifTrue: [ ^ aTransformation transformed: self editor text size ].	

	"not in this segment, ignoring"
	(aTransformedScreenPosition y between: aBoundsInEditor top and: aBoundsInEditor bottom)
		ifFalse: [  ^ self ].

	segment hasPieces
		ifFalse: [ ^ self ].

	itemElement
		screenToCursor: aTransformation
		of: self infiniteElement
		at: aTransformation screenPosition
]

{ #category : #updating }
BrTextEditorParagraphSegmentHolder >> onCursorChanged [
	"Is sent when text editor's cursor changes.
	Segment holder should update text elements accordingly"

	| theCursors |
	self
		assert: [ segment isNotNil ]
		description: [ 'Segment must be bound!' ].
	theCursors := BlFrameTelemetry
		timeSync: [ 'Compute segment cursors' ]
		during: [ (self infiniteElement editor cursors allCursors
				select: [ :aCursor | aCursor insideSegment: segment ]
				thenCollect: [ :aCursor | aCursor position - segment textStart ])
				asSet ].
	BlFrameTelemetry
		timeSync: [ 'Set segment cursors {1}' format: {theCursors} ]
		during: [ itemElement setCursors: theCursors ].
	(theCursors isNotEmpty and: [ self infiniteElement isFocused ])
		ifTrue: [ BlFrameTelemetry
				timeSync: [ 'Show segment cursors' ]
				during: [ itemElement showCursors ] ]
]

{ #category : #updating }
BrTextEditorParagraphSegmentHolder >> onFocusChanged: aBoolean [
	"Is sent when text editor's focus state changes.
	Segment holder should update text elements accordingly"

	self assert: [ segment isNotNil ] description: [ 'Segment must be bound!' ].

	aBoolean
		ifTrue: [ itemElement showCursors ]
		ifFalse: [ itemElement hideCursors ].

	pieceElements
		piecesAndTheirElementsDo: [ :aPiece :aPieceElement | 
			aPiece
				updateFocus: aBoolean
				of: aPieceElement
				in: self infiniteElement ]
]

{ #category : #updating }
BrTextEditorParagraphSegmentHolder >> onRecycled [

	itemElement removeChildren. 
	pieceElements piecesAndTheirElementsDo: [ :aPiece :aPieceElement | aPiece onRecycled: aPieceElement in: self infiniteElement ].
	itemElement selection: BlSelection empty.
	itemElement removeCursors.
	pieceElements := nil.
	segment := nil.
]

{ #category : #updating }
BrTextEditorParagraphSegmentHolder >> onSelectionChanged [
	"Is sent when text editor's selection changes.
	Segment holder should update text elements accordingly"
		
	self
		assert: [ segment isNotNil ]
		description: [ 'Segment must be bound!' ].

	itemElement selection: (self selectionIn: self infiniteElement editor)
]

{ #category : #updating }
BrTextEditorParagraphSegmentHolder >> onTextChanged [
	super onTextChanged.
	itemElement text: segment text
]

{ #category : #cursor }
BrTextEditorParagraphSegmentHolder >> relativeScreenToCursor: aTransformation [
	"trying to find a segment that actually contains a given position"
		
	itemElement relativeScreenToCursor: aTransformation of: self infiniteElement
]

{ #category : #accessing }
BrTextEditorParagraphSegmentHolder >> segment: anEditorSegment [
	self infiniteElement
		ignoreRequestLayoutDuring:
			[ segment == anEditorSegment
				ifTrue:
					[ BlFrameTelemetry timeSync: [ 'Update segment at {1}' format: {anEditorSegment index} ] during: [ self updateSegment ] ]
				ifFalse:
					[ BlFrameTelemetry
						timeSync: [ 'Build segment at {1}' format: {anEditorSegment index} ]
						during: [ self buildSegment: anEditorSegment ] ] ]
]

{ #category : #'private - accessing' }
BrTextEditorParagraphSegmentHolder >> selectionIn: aTextEditor [
	| theLocalSelection |
	
	theLocalSelection := BlCompositeSelection new.
	
	(aTextEditor selection + aTextEditor selectionRecorder selection) do: [ :aSelection |
		| aSelectionInterval textInterval |
		aSelectionInterval := aSelection interval.
		textInterval := BlSelection from: (segment textStart + 1 min: segment textEnd) to: segment textEnd.
		(aSelection overlaps: textInterval)
			ifTrue: [
				| localFrom localTo |
				localFrom := (aSelectionInterval first - segment textStart) max: 0.
				localTo := (aSelectionInterval last - segment textStart) min: segment textLength + 1.
				
				theLocalSelection select: localFrom to: localTo ] ].
		
	^ theLocalSelection
]

{ #category : #'private - segment' }
BrTextEditorParagraphSegmentHolder >> updateCursorPresent: hasCursor selectionPresent: hasSelection [
	hasCursor
		ifTrue: [ BlFrameTelemetry timeSync: [ 'Set cursor' ] during: [ self onCursorChanged ].
			hasSelection
				ifTrue: [ BlFrameTelemetry
						timeSync: [ 'Set selection' ]
						during: [ self onSelectionChanged ] ] ].

	BlFrameTelemetry
		timeSync: [ 'Set cursor' ]
		during: [ self onFocusChanged: self infiniteElement isFocused ]
]
