Class {
	#name : #BrTextEditorAbstractSegmentSplitter,
	#superclass : #Object,
	#category : #'Brick-Editor-Model - Segment'
}

{ #category : #'instance creation' }
BrTextEditorAbstractSegmentSplitter >> adornmentPiece: aBlText with: anAdornmentAttribute from: aTextStart to: aTextEnd [
	"Create and return a segment piece with adornment"

	<return: #BrTextEditorAbstractSegmentPiece>
	^ BrTextEditorLineSegmentAdornmentPiece new
		initializeWith: aBlText
			from: aTextStart
			to: aTextEnd
			delimiter: 0;
		adornmentAttribute: anAdornmentAttribute
]

{ #category : #accessing }
BrTextEditorAbstractSegmentSplitter >> itemValueType: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #'private - pieces computation' }
BrTextEditorAbstractSegmentSplitter >> processAdornmentAttribute: anAdornmentAttribute of: aText in: aStream from: aTextStart to: aTextEnd virtual: isVirtual [
	aStream
		nextPut: ((self
				adornmentPiece: aText
				with: anAdornmentAttribute
				from: aTextStart
				to: aTextEnd) virtual: isVirtual)
]

{ #category : #'private - pieces computation' }
BrTextEditorAbstractSegmentSplitter >> processPureWords: aTextIterator in: aStream offset: anOffset [
	"Process a text within a scope of the given iterator as if it does not contain any adornment attributes
	nor event handling attributes. At this point we should just split it in words based on the text separator
	such as space or some other characters abnd create a text piece for each `word`"
	
	aTextIterator
		nextSegment: [ :aCharacter | self itemValueType: aCharacter ]
		indicesDo: [ :aStart :anEnd |
			| aWord aTextStart aTextEnd |
			aWord := aTextIterator text from: ((aStart + 1) min: anEnd) to: anEnd.
			
			aTextStart := aStart + anOffset.
			aTextEnd := anEnd + anOffset.
			(aWord allSatisfy: #isLineBreak)
				ifTrue: [ aTextEnd := aTextStart ].
			
			aStream nextPut: (self textPiece: aWord from: aTextStart to: aTextEnd) ]
]

{ #category : #'private - pieces computation' }
BrTextEditorAbstractSegmentSplitter >> processSegment: aTextIterator in: aStream offset: anOffset [
	
	aTextIterator
		nextSpanAny: [ :eachAttribute | eachAttribute isAdornment and: [ eachAttribute shouldAppend not ] ]
		indicesDo: [ :aStart :anEnd :hasReplacements | 
			| aSpanIterator aDelta |
			
			aSpanIterator := (aTextIterator text from: aStart to: anEnd) iterator.
			aDelta := (aStart - 1) max: 0.	
			[ aSpanIterator hasNext ]
				whileTrue: [
					hasReplacements
						ifTrue: [ self processWithReplacements: aSpanIterator in: aStream offset: anOffset + aDelta ]
						ifFalse: [ self processWithoutReplacements: aSpanIterator in: aStream offset: anOffset + aDelta ] ] ]
]

{ #category : #splitting }
BrTextEditorAbstractSegmentSplitter >> processStartingAdornments: aText in: aStream offset: offset [
	(aText attributesAt: 0)
		select: [ :eachAttribute | eachAttribute isAdornment and: [ eachAttribute shouldAppend ] ]
		thenDo: [ :eachAttribute | 
			self
				processAdornmentAttribute: eachAttribute
				of: (aText from: 1 to: 0) 
				in: aStream
				from: 0
				to: 0
				virtual: true ]
]

{ #category : #'private - pieces computation' }
BrTextEditorAbstractSegmentSplitter >> processWithReplacements: aTextIterator in: aStream offset: anOffset [
	"There is at least one replacement attribute applied on every character within the scope of the given text iterator"

	aTextIterator
		nextAttributedEnd: [ :eachAttribute | eachAttribute isAdornment ]
		indicesDo: [ :aStart :anEnd :theAdornmentAttributes |
			| theAttributes replacementFound |
			
			theAttributes := theAdornmentAttributes
				ifEmpty: [ aTextIterator attributes
					select: [ :eachAttribute | eachAttribute isAdornment and: [ eachAttribute shouldReplace ] ] ].
			
			replacementFound := false.
			
			theAttributes do: [ :eachAttribute |
				| anAdornmentSpan aTextStart aTextEnd |
				
				aTextStart := ((aStart - 1) max: 0) + anOffset.
				aTextEnd := anEnd + anOffset.
				
				"adornment span must not be cached, because each line piece requires a unique sub-text"
				anAdornmentSpan := aTextIterator text from: aStart to: anEnd.
					
				(anAdornmentSpan allSatisfy: #isLineBreak)
					ifTrue: [ aTextEnd := aTextStart ].
				
				self
					processAdornmentAttribute: eachAttribute
					of: anAdornmentSpan
					in: aStream
					from: aTextStart
					to: aTextEnd
					virtual: (eachAttribute shouldAppend or: [ replacementFound ]).
				replacementFound := replacementFound or: [ eachAttribute shouldReplace ]  ] ]
]

{ #category : #'private - pieces computation' }
BrTextEditorAbstractSegmentSplitter >> processWithoutAdornments: aTextIterator in: aStream offset: anOffset [
	"Process a text within the scope of the given iterator as there are no adornment attributes.
	Now that adornment attributes are filtered we can split text into pieces based on the presence of
	event handling attributes. Every combination of event handling elements should be a separate text piece
	with its own unique visual element"

	aTextIterator
		nextSpan: [ :eachAttribute | eachAttribute isEventHandler ]
		indicesDo: [ :aStart :anEnd :theEventHandlerAttributes | 
			| aSpan aSpanIterator aDelta |
			aSpan := aTextIterator text from: aStart to: anEnd.
			aSpanIterator := aSpan iterator.
			aDelta := (aStart - 1) max: 0.
			[ aSpanIterator hasNext ] whileTrue: [
				self processPureWords: aSpanIterator in: aStream offset: anOffset + aDelta ] ]
]

{ #category : #'private - pieces computation' }
BrTextEditorAbstractSegmentSplitter >> processWithoutReplacements: aTextIterator in: aStream offset: anOffset [
	"There are no replacement attributes within the scope of the given iterator"

	aTextIterator
		nextAttributedEnd: [ :eachAttribute | eachAttribute isAdornment and: [ eachAttribute shouldAppend ] ]
		indicesDo: [ :aStart :anEnd :theEndedAttributes |
			| aSpan aSpanIterator aNewOffset |

			aSpan := aTextIterator text from: aStart to: anEnd.
			aSpanIterator := aSpan iterator.			
			aNewOffset := anOffset + ((aStart - 1) max: 0).

			[ aSpanIterator hasNext ] whileTrue: [
				self processWithoutAdornments: aSpanIterator in: aStream offset: aNewOffset ].

			"aStart is not necessarily where attributes start, so we have to search for them explicitly"

			theEndedAttributes do: [ :eachEndedAttribute |
				| aTextStart aTextEnd |
				
				aSpanIterator := aSpan iterator.
			
				[ aSpanIterator hasNext ] whileTrue: [
					aSpanIterator
						nextSpan: [ :eachAttribute | eachAttribute == eachEndedAttribute ]
						indicesDo: [ :anAttributeStart :anAttributeEnd :theAttributes |
							theAttributes
								ifNotEmpty: [
									| anAttributeSpan |
									anAttributeSpan := aSpan from: anAttributeStart to: anAttributeEnd.
									
									aTextStart := ((anAttributeStart - 1) max: 0) + aNewOffset.
									aTextEnd := anAttributeEnd + aNewOffset.

									(anAttributeSpan allSatisfy: #isLineBreak)
										ifTrue: [ aTextEnd := aTextStart ].

									self
										processAdornmentAttribute: eachEndedAttribute
										of: anAttributeSpan
										in: aStream
										from: aTextStart
										to: aTextEnd
										virtual: true ]	] ] ] ]
]

{ #category : #splitting }
BrTextEditorAbstractSegmentSplitter >> split: aText from: aStartIndex to: anEndIndex [
	"aStartIndex and anEndIndex are given in cursor coordinates"

	^ (Array
		streamContents: [ :aStream | 
			| lineIterator |
			self
				processStartingAdornments: aText
				in: aStream
				offset: aStartIndex.
			lineIterator := aText iterator.
			[ lineIterator hasNext ]
				whileTrue: [ self
						processSegment: lineIterator
						in: aStream
						offset: aStartIndex ] ])
		ifEmpty: [ {self
					textPiece: (aText from: 1 to: aText size)
					from: aStartIndex
					to: anEndIndex} ]
]

{ #category : #'instance creation' }
BrTextEditorAbstractSegmentSplitter >> textPiece: aBlText from: aTextStart to: aTextEnd [
	"Create and return a text segment piece"

	<return: #BrTextEditorAbstractSegmentPiece>
	^ BrTextEditorSegmentTextPiece new
		initializeWith: aBlText
		from: aTextStart
		to: aTextEnd
		delimiter: 0
]
