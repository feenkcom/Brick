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
		'index'
	],
	#category : #'Brick-Editor-Model - Segment-Text'
}

{ #category : #'pieces - computation' }
BrTextEditorSegment >> clearCache [
	"Clear all caches and make this segment fresh as if it would just be created and initalized"
]

{ #category : #printing }
BrTextEditorSegment >> gtDisplayOn: aStream [
	self printOn: aStream
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
BrTextEditorSegment >> isLastIn: aTextEditor [
	"Return true if I am absolutely the very last segment (not last cached) in a given text editor"

	^ self index = aTextEditor segmentCollector segments size
]

{ #category : #testing }
BrTextEditorSegment >> isLineBreak [
	"Return true if segment only consists of line break, false otherwise"
	<return: #Boolean>
	
	^ self text anySatisfy: #isLineBreak
]

{ #category : #'text - modifications' }
BrTextEditorSegment >> moveTextBy: aNumber [
	"Move all sub-text pieces (#start and #end) known by the segment by a given amount of indicies.
	If aNumber is negative sub-texts will be moved to the left (maybe this is a result of a deletion).
	If aNumber is positive sub-texts will be moved to the right (maybe this is a result of an insertion).
	aNumber must not be zero - undefined behaviour (nothing was inserted but the message is sent? Probably a bug)"

	self start: textStart + aNumber end: textEnd + aNumber
]

{ #category : #'text - modifications' }
BrTextEditorSegment >> moveTextPiecesBy: aNumber at: aTextIndex [
]

{ #category : #printing }
BrTextEditorSegment >> printOn: aStream [
	self text printOn: aStream
]

{ #category : #accessing }
BrTextEditorSegment >> segmentType [
	"Return a type of this segment responsible for creation
	of segment holder and also used as a key for caching purposes"
	<return: #BrEditorSegmentType>
	
	^ self subclassResponsibility
]

{ #category : #'text - modifications' }
BrTextEditorSegment >> updateSegmentProperties [
]
