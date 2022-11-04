"
I represent a single text segment that is backed up by a sub text.
We split the whole text into segment in order to support infinite list that is used to render the whole text.

By default segment is a single line: a piece of text between new line characters
"
Class {
	#name : #BrTextEditorSegment,
	#superclass : #Object,
	#traits : 'TBrTextEditorTextualPiece + TBlDebug',
	#classTraits : 'TBrTextEditorTextualPiece classTrait + TBlDebug classTrait',
	#instVars : [
		'index',
		'pieces',
		'lineSpacing',
		'wordPadding',
		'paragraphMargin'
	],
	#category : #'Brick-Editor-Model - Segment-Text'
}

{ #category : #'pieces - computation' }
BrTextEditorSegment >> clearCache [
	"Clear all caches and make this segment fresh as if it would just be created and initalized"

	pieces := nil
]

{ #category : #'pieces - computation' }
BrTextEditorSegment >> computedPieces [
	<return: #SequenceableCollection of: #BrTextEditorAbstractSegmentPiece>
	| thePieces |

	thePieces := self splitterClass new
		split: self text
		from: self textStart
		to: self textEnd.
	thePieces do: [ :eachPiece | eachPiece segment: self ].

	^ thePieces
]

{ #category : #printing }
BrTextEditorSegment >> gtDisplayOn: aStream [
	self printOn: aStream
]

{ #category : #testing }
BrTextEditorSegment >> hasPieces [
	<return: #Boolean>

	^ pieces isNotNil
]

{ #category : #accessing }
BrTextEditorSegment >> index [
	"Return segment index within BrEditor.
	Note: index can not be nil"
	<return: #Number>
	
	self
		assert: [ index isNotNil ]
		description: [ 'Index can not be nil' ].

	^ index
]

{ #category : #accessing }
BrTextEditorSegment >> index: aNumber [
	index := aNumber
]

{ #category : #accessing }
BrTextEditorSegment >> initialize [
	super initialize.

	self resetProperties
]

{ #category : #initialization }
BrTextEditorSegment >> initializeWith: aBlText from: aTextStart to: aTextEnd delimiter: aDelimiterLength [
	self
		assert: [ aBlText isKindOf: BlSubText ]
		description: [ 'Must be sub-text' ].

	text := aBlText.
	
	textStart := aTextStart.
	textEnd := aTextEnd.
	delimiterLength := aDelimiterLength.

	self clearCache.
	self updateSegmentProperties
]

{ #category : #'api - operations' }
BrTextEditorSegment >> insert: aCollectionOfSegments [
	| theSegments theRestLength |
	<return: #Collection of: #BrTextEditorSegment>

	theSegments := { self }, aCollectionOfSegments allButFirst.

	theRestLength := self textLength - (aCollectionOfSegments first textStart - textStart).

	"when inserting multiple segments we just need to alter intervals of the first (myself)
	and the last inserted segments accordingly"
	self
		scopeText: self textStart
		end: aCollectionOfSegments first textEnd.

	delimiterLength := aCollectionOfSegments first delimiterLength.

	theSegments last
		scopeText: theSegments last textStart
		end: theSegments last textEnd + theRestLength.

	^ theSegments
]

{ #category : #testing }
BrTextEditorSegment >> isAllLineBreak [
	"Return true if segment only consists of line break, false otherwise"
	<return: #Boolean>
	
	^ self text allSatisfy: #isLineBreak
]

{ #category : #testing }
BrTextEditorSegment >> isFirstIn: aTextEditor [
	"Return true if I am absolutely the very first segment (not first cached) in a given text editor"

	^ self index = 1
]

{ #category : #testing }
BrTextEditorSegment >> isFirstTextPiece: aSegmentPiece [
	<return: #Boolean>
	
	self hasPieces ifFalse: [ ^ false ].

	^ self pieces first == aSegmentPiece
]

{ #category : #testing }
BrTextEditorSegment >> isLastIn: aTextEditor [
	"Return true if I am absolutely the very last segment (not last cached) in a given text editor"

	^ self index = aTextEditor segmentCollector segments size
]

{ #category : #testing }
BrTextEditorSegment >> isLastTextPiece: aSegmentPiece [
	<return: #Boolean>
	
	self hasPieces
		ifFalse: [ ^ false ].

	self pieces reverseDo: [ :eachPiece |
		eachPiece isText ifTrue: [ ^ eachPiece == aSegmentPiece ] ].
	
	^ false
]

{ #category : #testing }
BrTextEditorSegment >> isLineBreak [
	"Return true if segment only consists of line break, false otherwise"
	<return: #Boolean>
	
	^ self text anySatisfy: #isLineBreak
]

{ #category : #'attributes - paragraph' }
BrTextEditorSegment >> lineSpacing [
	<return: #Number>

	^ lineSpacing
]

{ #category : #'attributes - paragraph' }
BrTextEditorSegment >> lineSpacing: aNumber [
	lineSpacing := aNumber
]

{ #category : #'text - modifications' }
BrTextEditorSegment >> moveTextBy: aNumber [
	"Move all sub-text pieces (#start and #end) known by the segment by a given amount of indicies.
	If aNumber is negative sub-texts will be moved to the left (maybe this is a result of a deletion).
	If aNumber is positive sub-texts will be moved to the right (maybe this is a result of an insertion).
	aNumber must not be zero - undefined behaviour (nothing was inserted but the message is sent? Probably a bug)"

	self start: textStart + aNumber end: textEnd + aNumber.

	"no pieces created (they were not requested yet so no need to move them)"
	self hasPieces
		ifFalse: [ ^ self ].

	self pieces
		do: [ :aTextPiece | aTextPiece start: aTextPiece textStart + aNumber end: aTextPiece textEnd + aNumber ]
]

{ #category : #'text - modifications' }
BrTextEditorSegment >> moveTextPiecesBy: aNumber at: aTextIndex [
	"aTextIndex is a Text index, not a cursor one!"
	| aCursorIndex |
	
	aCursorIndex := (aTextIndex - 1) max: 0.

	"no pieces created (they were not requested yet so no need to move them)"
	self hasPieces
		ifFalse: [ ^ self ].

	self pieces
		do: [ :aTextPiece |
			
			aNumber > 0
				ifTrue: [
					aTextPiece textEnd > aCursorIndex
						ifTrue: [
							aTextPiece textStart > aCursorIndex
								ifTrue: [ aTextPiece
									start: aTextPiece textStart + aNumber
									end: aTextPiece textEnd + aNumber ]
								ifFalse: [ aTextPiece
									start: aTextPiece textStart
									end: aTextPiece textEnd + aNumber ] ] ]
				ifFalse: [
					aTextPiece textEnd > aCursorIndex
						ifTrue: [
							"deletion happened before this text piece"
							aTextPiece textStart > aCursorIndex
								ifTrue: [
									| aLastDeletedIndex |
									aLastDeletedIndex := aCursorIndex + aNumber abs.
									aTextPiece
										start: aCursorIndex
										end: ((aTextPiece textEnd - aLastDeletedIndex) max: aCursorIndex) ]
								"deletion happened inside of this text piece"
								ifFalse: [
									aTextPiece
										start: aTextPiece textStart
										"end is start + how many left after deletion"
										end: aCursorIndex + ((aTextPiece textEnd - aCursorIndex - aNumber abs) max: 0) ] ] ] ]
]

{ #category : #'attributes - paragraph' }
BrTextEditorSegment >> paragraphMargin [
	<return: #BlInsets>

	^ paragraphMargin
]

{ #category : #'attributes - paragraph' }
BrTextEditorSegment >> paragraphMargin: aBlInsets [
	paragraphMargin := aBlInsets
]

{ #category : #accessing }
BrTextEditorSegment >> pieces [
	<return: #Array of: #BrTextEditorAbstractSegmentPiece>

	^ self hasPieces
		ifTrue: [ pieces ]
		ifFalse: [ pieces := self computedPieces ]
]

{ #category : #printing }
BrTextEditorSegment >> printOn: aStream [
	self text printOn: aStream
]

{ #category : #initialization }
BrTextEditorSegment >> resetProperties [
	lineSpacing := 0.
	wordPadding := BlInsets empty.
	paragraphMargin := BlInsets empty.
]

{ #category : #accessing }
BrTextEditorSegment >> segmentType [
	"Return a type of this segment responsible for creation
	of segment holder and also used as a key for caching purposes"
	<return: #BrEditorSegmentType>
	
	^ self subclassResponsibility
]

{ #category : #'pieces - computation' }
BrTextEditorSegment >> splitterClass [
	self subclassResponsibility
]

{ #category : #'text - modifications' }
BrTextEditorSegment >> updateSegmentProperties [
	| theParagraphAttributes |
	
	self resetProperties.
	
	theParagraphAttributes := text iterator selectAttributes: #isParagraphAttribute.
	theParagraphAttributes do: [ :aParagraphAttribute |
		aParagraphAttribute applyOn: self ]
]

{ #category : #'attributes - paragraph' }
BrTextEditorSegment >> wordPadding [
	<return: #BlInsets>

	^ wordPadding
]

{ #category : #'attributes - paragraph' }
BrTextEditorSegment >> wordPadding: aBlInsets [
	wordPadding := aBlInsets
]
