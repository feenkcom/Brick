"
I am a {{gtClass:BrEditorSearchTextComputation}}. 
I search all text places using a {{gtClass:TAsyncFuture}}. 

"
Class {
	#name : #BrEditorSearchTextAsyncFutureComputation,
	#superclass : #BrEditorSearchTextComputation,
	#instVars : [
		'executionConfiguration'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #'instance creation' }
BrEditorSearchTextAsyncFutureComputation class >> newDefault [
	^ self new
		executionConfiguration: (AsyncFutureExecutionConfiguration new
				customGroup: #SearchText;
				defaultPriority)
]

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
	
	aMarkContext patternItems: allPatternItems.
	aMarker notifyFoundItems: allPatternItems context: aMarkContext.
	
	^ BrEditorSearchTextResult new
		styledText: aText;
		patternItems: allPatternItems;
		context: aMarkContext;
		marker: aMarker
]

{ #category : #'api - styling' }
BrEditorSearchTextAsyncFutureComputation >> markText: aMarkContext using: aMarker [
	| anElement anElementFuture aText |
	anElement := aMarkContext element ifNil: [ ^ self ].
	anElementFuture := anElement userData
			at: BrEditorSearchTextAsyncFutureComputation
			ifPresent: [ :theElementFuture | theElementFuture ]
			ifAbsentPut: [ self newElementFutureFor: anElement ].

	aText := aMarkContext nextGenerationText.
	anElementFuture
		future: [ self
				markText: aText
				context: aMarkContext
				using: aMarker ]
]

{ #category : #private }
BrEditorSearchTextAsyncFutureComputation >> newElementFutureFor: anElement [
	^ (BrAsyncElementFuture on: anElement)
		executionConfiguration: self executionConfiguration;
		whenPending: [ :theElement | ];
		whenError: [ :theElement :anError | ];
		whenSuccess: [ :theElement :aSearchTextResult | 
			self onSearchTextResult: aSearchTextResult fromElement: theElement ]
]

{ #category : #private }
BrEditorSearchTextAsyncFutureComputation >> onSearchTextResult: aSearchTextResult fromElement: anElement [
	"This method must be called from a UI process"

	| aResult |
	aResult := aSearchTextResult context textSource
			updateText: aSearchTextResult styledText.
	aResult ifTrue: [ ^ self ].

	self flag: #todo
]
