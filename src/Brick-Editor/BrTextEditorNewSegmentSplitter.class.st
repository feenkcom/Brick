Class {
	#name : #BrTextEditorNewSegmentSplitter,
	#superclass : #BrTextEditorAbstractSegmentSplitter,
	#category : #'Brick-Editor-Model - Segment'
}

{ #category : #accessing }
BrTextEditorNewSegmentSplitter >> split: aText from: aStartIndex to: anEndIndex [
	"aStartIndex and anEndIndex are given in cursor coordinates"

	^ (Array
		streamContents: [ :aStream | 
			| spans |
			self
				processStartingAdornments: aText
				in: aStream
				offset: aStartIndex.


			spans := aText spansBasedOn: [ :atts | atts anySatisfy: #isAdornment ].
			spans
				do: [ :span | 
					| start end atts replacing |
					start := span first.
					end := span second.
					atts := aText attributesAt: start.
					replacing := false.
					atts
						detect: [ :att | att isAdornment and: [ att shouldReplace ] ]
						ifFound: [ :att | 
							replacing := true.
							self
								processAdornmentAttribute: att
								of: (aText from: start to: end)
								in: aStream
								from: start
								to: end
								virtual: false ].
					atts
						select: [ :att | att isAdornment and: [ att shouldOverlay ] ]
						thenDo: [ :att | 
							self
								processAdornmentAttribute: att
								of: (aText from: start to: end)
								in: aStream
								from: start
								to: end
								virtual: true ].
					replacing
						ifFalse: [ self
								splitEventsFrom: aText
								from: start
								to: end
								into: aStream.
							atts
								select: [ :att | att isAdornment and: [ att shouldAppend ] ]
								thenDo: [ :att | 
									self
										processAdornmentAttribute: att
										of: (aText from: start to: end)
										in: aStream
										from: start
										to: end
										virtual: true ] ] ] ])
		ifEmpty: [ {self
					textPiece: (aText from: 1 to: aText size)
					from: aStartIndex
					to: anEndIndex} ]
]

{ #category : #accessing }
BrTextEditorNewSegmentSplitter >> splitEventsFrom: aText from: start to: end into: aStream [
	| spans |
	spans := aText spansBasedOn: [ :atts | atts anySatisfy: #isEventHandler ] from: start to: end.
	spans
		do: [ :span | 
			aStream
				nextPut: (self
						textPiece: (aText from: (span first max: 1) to: span second)
						from: span first
						to: span second) ]
]
