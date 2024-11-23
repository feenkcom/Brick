"
I am responsible for splitting a given piece of text into segments
"
Class {
	#name : #BrTextEditorSplitter,
	#superclass : #Object,
	#instVars : [
		'segmentClass'
	],
	#category : #'Brick-Editor-Model - Segment-Text'
}

{ #category : #'instance creation' }
BrTextEditorSplitter >> newSegment [
	^ segmentClass new
]

{ #category : #'instance creation' }
BrTextEditorSplitter >> newSegment: aBlText from: aStartIndex to: anEndIndex delimited: aDelimiterIndex offset: anOffset [
	| aText anAbsoluteTextStart anAbsoluteTextEnd |
	"aStartIndex and anEndIndex are given in text coordinates"

	aText := aBlText
		from: aStartIndex
		to: anEndIndex.

	anAbsoluteTextStart := aStartIndex - 1.
	anAbsoluteTextEnd := anEndIndex.

	^ self newSegment
		initializeWith: aText
		from: anAbsoluteTextStart + anOffset
		to: anAbsoluteTextEnd + anOffset
		delimiter: aDelimiterIndex - anEndIndex
]

{ #category : #'instance creation' }
BrTextEditorSplitter >> segmentClass: aClass [
	segmentClass := aClass
]

{ #category : #'api - splitting' }
BrTextEditorSplitter >> split: aBlText in: aBrEditorSegmentStream [
	self
		split: (aBlText from: 1 to: aBlText size)
		in: aBrEditorSegmentStream
		offset: 0
]

{ #category : #'api - splitting' }
BrTextEditorSplitter >> split: aBrText in: aBrEditorSegmentStream offset: anOffset [
	| anIterator |
	aBrText isEmpty
		ifTrue: [ ^ aBrEditorSegmentStream
				nextPut: (self
						newSegment: aBrText
						from: 1
						to: 0
						delimited: 0
						offset: anOffset) ].

	anIterator := aBrText iterator.

	[ anIterator hasNext and: [ aBrEditorSegmentStream wantsMore ] ]
		whileTrue: [ anIterator
				nextLineIndicesDo: [ :aLineStart :aLineEnd :aLineDelimiterEnd | 
					aBrEditorSegmentStream
						nextPut: (self
								newSegment: aBrText
								from: aLineStart
								to: aLineEnd
								delimited: aLineDelimiterEnd
								offset: anOffset) ]
				shouldMerge: [ :aLineStart :aLineEnd :aLineDelimiterEnd | 
					(aBrText from: aLineEnd + 1 to: aLineDelimiterEnd) iterator
						detectAttribute: [ :eachAttribute | self wantsToMergeSegments: eachAttribute ]
						ifFound: [ true ]
						ifNone: [ false ] ] ].

	(aBrEditorSegmentStream wantsMore and: [ aBrText last isLineBreak ])
		ifTrue: [ aBrEditorSegmentStream
				nextPut: (self
						newSegment: aBrText
						from: aBrText size + 1
						to: aBrText size
						delimited: aBrText size
						offset: anOffset) ]
]

{ #category : #testing }
BrTextEditorSplitter >> wantsToMergeSegments: aTextAttribute [
	"Return true if a given attribute should merge segments and ignore a new line"
	<return: #Boolean>

	^ aTextAttribute isAdornment and: [ aTextAttribute shouldReplace ]
]
