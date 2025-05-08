Class {
	#name : #BrEditorSearchTextAsyncFutureComputation,
	#superclass : #BrEditorSearchTextComputation,
	#instVars : [
		'executionConfiguration'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #accessing }
BrEditorSearchTextAsyncFutureComputation >> defaultExecutionConfiguration [
	^ AsyncFutureExecutionConfiguration new
		customGroup: #SearchText;
		defaultPriority
]

{ #category : #accessing }
BrEditorSearchTextAsyncFutureComputation >> executionConfiguration [
	^ executionConfiguration ifNil: [ self defaultExecutionConfiguration ]
]

{ #category : #accessing }
BrEditorSearchTextAsyncFutureComputation >> executionConfiguration: anObject [
	executionConfiguration := anObject
]

{ #category : #private }
BrEditorSearchTextAsyncFutureComputation >> markText: aText context: aMarkContext using: aMarker [
	| allPatternItems |
	allPatternItems := aMarker markText: aText context: aMarkContext.
	
	aMarker notifyFoundItems: allPatternItems context: aMarkContext.
	
	^ BrEditorSearchTextResult new
		styledText: aText;
		patternItems: allPatternItems;
		context: aMarkContext;
		marker: aMarker
]

{ #category : #'api - styling' }
BrEditorSearchTextAsyncFutureComputation >> markText: aMarkContext using: aMarker [
	| anElement anElementFuture aText anEditorElement |
	anElement := aMarkContext element ifNil: [ ^ self ].
	anEditorElement := aMarkContext editorElement ifNil: [ ^ self ].
	anElementFuture := anElement userData
			at: BrEditorSearchTextAsyncFutureComputation
			ifPresent: [ :theElementFuture | theElementFuture ]
			ifAbsentPut: [ self
					newElementFutureFor: anElement
					editorElement: anEditorElement ].

	aText := aMarkContext nextGenerationText.
	anElementFuture
		future: [ self
				markText: aText
				context: aMarkContext
				using: aMarker ]
]

{ #category : #private }
BrEditorSearchTextAsyncFutureComputation >> newElementFutureFor: anElement editorElement: anEditorElement [
	^ (BrAsyncElementFuture on: anElement)
		executionConfiguration: self executionConfiguration;
		whenPending: [ :theElement | ];
		whenError: [ :theElement :anError | ];
		whenSuccess: [ :theElement :aSearchTextResult | 
			self onSearchTextResult: aSearchTextResult editorElement: anEditorElement ]
]

{ #category : #private }
BrEditorSearchTextAsyncFutureComputation >> onSearchTextResult: aSearchTextResult editorElement: anEditorElement [
	"Influenced by `BrTextEditorModel>>#onTextStyled:`"

	| anEditorModel |
	anEditorModel := anEditorElement editor.
	anEditorModel assertUIProcess.

	aSearchTextResult isNextGeneration
		ifFalse: [ false
				ifTrue: [ self flag: #todo.
					BlTaskAction
						enqueueElement: anEditorElement
						action: [ self markText: aSearchTextResult context using: aSearchTextResult marker ] ].
			^ self ].

	(anEditorModel segmentBuilder
		requiresResplittingFrom: anEditorModel text
		to: aSearchTextResult styledText)
		ifTrue: [  "It is possible that the segment structure has changed"anEditorModel
				segmentBuilder resetSegmentCacheAndNotify: anEditorModel ].

	anEditorModel text updateFrom: aSearchTextResult styledText text.

	anEditorModel notifyTextStyled: anEditorModel text.

	anEditorModel processCursorEnterEvents.

	anEditorModel updater
		all;
		update
]
