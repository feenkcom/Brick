Class {
	#name : #BrTextEditorNewSegmentSplitter,
	#superclass : #BrTextEditorAbstractSegmentSplitter,
	#category : #'Brick-Editor-Model - Segment'
}

{ #category : #accessing }
BrTextEditorNewSegmentSplitter >> itemValueType: anObject [
	"Return a type of an item within a segment.
	Note: return value should be never used explicitely, it is only needed
	for direct comparison, therefore can be any immutable object"
	<return: #Symbol>
	
	^ #char
]

{ #category : #accessing }
BrTextEditorNewSegmentSplitter >> processSegment: aTextIterator in: aStream offset: anOffset [
	aTextIterator
		nextSpanAny: [ :eachAttribute | eachAttribute isAdornment and: [ eachAttribute shouldAppend not ] ]
		indicesDo: [ :aStart :anEnd :hasReplacements | 
			| aSpanIterator aDelta |
			aSpanIterator := (aTextIterator text from: aStart to: anEnd) iterator.
			aDelta := aStart - 1 max: 0.
			[ aSpanIterator hasNext ]
				whileTrue: [ hasReplacements
						ifTrue: [ self
								processWithReplacements: aSpanIterator
								in: aStream
								offset: anOffset + aDelta
								start: aStart
								end: anEnd ]
						ifFalse: [ self
								processWithoutReplacements: aSpanIterator
								in: aStream
								offset: anOffset + aDelta ] ] ]
]

{ #category : #accessing }
BrTextEditorNewSegmentSplitter >> processWithReplacements: aTextIterator in: aStream offset: anOffset start: start end: end [
	"There is at least one replacement attribute applied on every character within the scope of the given text iterator"

	| theAttributes replacementFound |
	theAttributes := aTextIterator attributes
			select: [ :eachAttribute | eachAttribute isAdornment and: [ eachAttribute shouldReplace ] ].

	replacementFound := false.

	theAttributes
		do: [ :eachAttribute | 
			| anAdornmentSpan aTextStart aTextEnd |
			aTextStart := (start - 1 max: 0) + anOffset.
			aTextEnd := end + anOffset.	
			
			"adornment span must not be cached, because each line piece requires a unique sub-text"
			anAdornmentSpan := aTextIterator text from: start to: end.

			(anAdornmentSpan allSatisfy: #isLineBreak) ifTrue: [ aTextEnd := aTextStart ].

			self
				processAdornmentAttribute: eachAttribute
				of: anAdornmentSpan
				in: aStream
				from: aTextStart
				to: aTextEnd
				virtual: (eachAttribute shouldAppend or: [ replacementFound ]).
			replacementFound := replacementFound or: [ eachAttribute shouldReplace ] ]
]

{ #category : #accessing }
BrTextEditorNewSegmentSplitter >> split: aText from: aStartIndex to: anEndIndex [
	"aStartIndex and anEndIndex are given in cursor coordinates"

	^ (Array
		streamContents: [ :aStream | 
			self
				processStartingAdornments: aText
				in: aStream
				offset: aStartIndex.
			aText
				attributeRunsDo: [ :start :end :atts | 
					start = 0
						ifFalse: [ atts
								detect: [ :att | att isAdornment and: [ att shouldReplace ] ]
								ifFound: [ :att | 
									self
										processAdornmentAttribute: att
										of: (aText from: start to: end)
										in: aStream
										from: start
										to: end
										virtual: false ]
								ifNone: [ aStream
										nextPut: (self
												textPiece: (aText from: start to: end)
												from: start
												to: end).
									atts
										detect: [ :att | att isAdornment ]
										ifFound: [ :att | 
											self
												processAdornmentAttribute: att
												of: (aText from: start to: end)
												in: aStream
												from: start
												to: end
												virtual: true ] ] ] ] ])
		ifEmpty: [ {self
					textPiece: (aText from: 1 to: aText size)
					from: aStartIndex
					to: anEndIndex} ]
]
