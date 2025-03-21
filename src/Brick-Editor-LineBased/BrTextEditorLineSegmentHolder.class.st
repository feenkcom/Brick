"
I am a line segment holder and is responsible for binding ===BrTextEditorLineSegment=== with corresponding visual element
"
Class {
	#name : #BrTextEditorLineSegmentHolder,
	#superclass : #BrTextEditorSegmentHolder,
	#classInstVars : [
		'defaultSegmentLayoutBlock'
	],
	#category : #'Brick-Editor-LineBased-Model'
}

{ #category : #cleanup }
BrTextEditorLineSegmentHolder class >> cleanUp [
	super cleanUp.
	
	defaultSegmentLayoutBlock := nil
]

{ #category : #accessing }
BrTextEditorLineSegmentHolder class >> defaultSegmentLayout [
	^ (defaultSegmentLayoutBlock ifNil: [ BrEditorTextFlowLayout new ]) value
]

{ #category : #accessing }
BrTextEditorLineSegmentHolder class >> defaultSegmentLayout: aBlock [
	defaultSegmentLayoutBlock := aBlock
]

{ #category : #'private - segment' }
BrTextEditorLineSegmentHolder >> buildSegment: anEditorSegment [
	| newPieceElements thePieces hasSelection hasCursor |

	segment := anEditorSegment.

	hasSelection := self hasSelection.
	hasCursor := self hasCursor.
	
	BlFrameTelemetry
		time: [ 'Update segment properties' ]
		during: [ segment updateSegmentProperties ].

	pieceElements := self newPiecesMap.
	newPieceElements := OrderedCollection new.

	thePieces := BlFrameTelemetry
		time: [ 'Get pieces' ]
		during: [ segment pieces ].
	
	BlFrameTelemetry
		time: [ 'Create piece elements' ]
		during: [
			thePieces withIndexDo: [ :aPiece :eachIndex | 
				| thePieceElements |
				
				thePieceElements := BlFrameTelemetry
					time: [ 'Create piece elements at {1} for {2}' format: { eachIndex. aPiece class name } ]
					during: [ (aPiece createElement: self infiniteElement) asOrderedCollection ].
				
				newPieceElements addAll: thePieceElements.
				pieceElements atPiece: aPiece putElements: thePieceElements ] ].

	(hasCursor or: [ hasSelection ])
		ifTrue: [
			BlFrameTelemetry
				timeSync: [ 'Set cursor, selection' ]
				during: [
					pieceElements piecesAndTheirElementsDo: [ :aPiece :aPieceElement |
						hasCursor
							ifTrue: [
								BlFrameTelemetry
									timeSync: [ 'Set cursor' ]
									during: [ aPiece setCursor: aPieceElement of: anEditorSegment in: self infiniteElement ] ].
						
						BlFrameTelemetry
							timeSync: [ 'Set focus' ]
							during: [ aPiece updateFocus: self infiniteElement isFocused of: aPieceElement in: self infiniteElement ].
						
						hasSelection
							ifTrue: [
								BlFrameTelemetry
									timeSync: [ 'Set selection' ]
									during: [ aPiece updateSelection: aPieceElement of: anEditorSegment in: self infiniteElement ] ] ] ] ].

	BlFrameTelemetry
		timeSync: [ 'Remove segment children' ]
		during: [ itemElement removeChildren ].

	BlFrameTelemetry
		timeSync: [ 'Add segment children' ]
		during: [ itemElement addChildren: newPieceElements ].

	itemElement
		constraintsDo: [ :c | c horizontal resizer: infiniteElement constraints horizontal resizer ];
		padding: anEditorSegment paragraphMargin
]

{ #category : #'private - accessing' }
BrTextEditorLineSegmentHolder >> cachedPieces [
	<return: #Collection of: #BrTextEditorAbstractSegmentPiece>
	
	^ pieceElements allPieces
]

{ #category : #initialization }
BrTextEditorLineSegmentHolder >> createSegmentElement [
	<return: #BlElement>

	^ BrTextEditorSegmentElement new
		beInSeparateCompositionLayer;
		layout: self class defaultSegmentLayout;
		focusability: BlFocusability after;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		aptitude: (BrLayoutResizerAptitude new
			hInherit;
			vAnyToFitContent);
		yourself
]

{ #category : #cursor }
BrTextEditorLineSegmentHolder >> explicitScreenToCursor: aTransformation [
	| aBoundsInEditor aPositionInSegment aClosestPieceElement aClosestPiece aTransformedScreenPosition |
	
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
			
	aPositionInSegment := (itemElement globalBoundsToMine: (BlBounds origin: aTransformation screenPosition extent: 0.0@0.0) fromParent: self infiniteElement) center.	
	segment hasPieces
		ifFalse: [ ^ self ].
	
	"trying to find a segment that actually contains a given position"
	pieceElements piecesAndTheirElementsDo: [ :aPiece :aPieceElement |
		(aPieceElement bounds inParent bounds containsPoint: aPositionInSegment)
			ifTrue: [ ^ aPiece screenToCursor: aTransformation of: self infiniteElement in: aPieceElement ] ].
		
	"clicked outside of a segment piece, should find the closest element"
	
	aClosestPieceElement := itemElement layout findClosestChildOf: itemElement to: aPositionInSegment.
	aClosestPiece := pieceElements 
		pieceForElement: aClosestPieceElement
		ifAbsent: [ ^ self ].
		
	aClosestPiece screenToCursor: aTransformation of: self infiniteElement in: aClosestPieceElement
]

{ #category : #updating }
BrTextEditorLineSegmentHolder >> onCursorChanged [
	"Is sent when text editor's cursor changes.
	Segment holder should update text elements accordingly"

	pieceElements piecesAndTheirElementsDo: [ :aPiece :aPieceElement |
		aPiece updateCursor: aPieceElement of: segment in: self infiniteElement ]
]

{ #category : #updating }
BrTextEditorLineSegmentHolder >> onFocusChanged: aBoolean [
	"Is sent when text editor's focus state changes.
	Segment holder should update text elements accordingly"

	self
		assert: [ segment isNotNil ]
		description: [ 'Segment must be bound!' ].

	pieceElements piecesAndTheirElementsDo: [ :aPiece :aPieceElement |
		aPiece updateFocus: aBoolean of: aPieceElement in: self infiniteElement ]
]

{ #category : #updating }
BrTextEditorLineSegmentHolder >> onRecycled [

	itemElement removeChildren.
	pieceElements piecesAndTheirElementsDo: [ :aPiece :aPieceElement | aPiece onRecycled: aPieceElement in: self infiniteElement ].
	pieceElements := nil.
	segment := nil.
]

{ #category : #updating }
BrTextEditorLineSegmentHolder >> onSelectionChanged [
	"Is sent when text editor's selection changes.
	Segment holder should update text elements accordingly"
		
	self
		assert: [ segment isNotNil ]
		description: [ 'Segment must be bound!' ].

	pieceElements piecesAndTheirElementsDo: [ :aPiece :aPieceElement |
		aPiece updateSelection: aPieceElement of: segment in: self infiniteElement ]
]

{ #category : #cursor }
BrTextEditorLineSegmentHolder >> relativeScreenToCursor: aTransformation [	
	"trying to find a segment that actually contains a given position"

	pieceElements piecesAndTheirElementsDo: [ :aPiece :aPieceElement |
		(aTransformation cursor insideSubText: aPiece of: segment)
			ifTrue: [
				^ aPiece screenToCursor: aTransformation of: self infiniteElement in: aPieceElement ] ]
]

{ #category : #accessing }
BrTextEditorLineSegmentHolder >> segment: anEditorSegment [
	segment == anEditorSegment
		ifTrue:
			[ BlFrameTelemetry time: [ 'Update segment at {1}' format: {anEditorSegment index} ] during: [ self updateSegment ] ]
		ifFalse:
			[ BlFrameTelemetry
				time: [ 'Build segment at {1}' format: {anEditorSegment index} ]
				during: [ self buildSegment: anEditorSegment ] ]
]

{ #category : #'private - segment' }
BrTextEditorLineSegmentHolder >> updateCursorPresent: hasCursor selectionPresent: hasSelection [
	(hasCursor or: [ hasSelection ])
		ifTrue: [ BlFrameTelemetry
				timeSync: [ 'Update cursor and selection' format: {segment index} ]
				during: [ pieceElements
						piecesAndTheirElementsDo: [ :aPiece :aPieceElement | 
							BlFrameTelemetry
								timeSync: [ 'Update cursor of {1}' format: {aPiece} ]
								during: [ aPiece
										updateCursor: aPieceElement
										of: segment
										in: self infiniteElement ].
							BlFrameTelemetry
								timeSync: [ 'Update selection of {1}' format: {aPiece} ]
								during: [ aPiece
										updateSelection: aPieceElement
										of: segment
										in: self infiniteElement ].
							BlFrameTelemetry
								timeSync: [ 'Update focus of {1}' format: {aPiece} ]
								during: [ aPiece
										updateFocus: self infiniteElement isFocused
										of: aPieceElement
										in: self infiniteElement ] ] ] ]
]
