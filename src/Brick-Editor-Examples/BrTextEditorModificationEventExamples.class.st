Class {
	#name : #BrTextEditorModificationEventExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples-Model'
}

{ #category : #examples }
BrTextEditorModificationEventExamples >> deleteTextCreatesModificationEvent [
	<gtExample>
	<return: #BrTextEditorDeletionModificationEvent>
	| textEditor targetEvent triggerCount |
	textEditor := self newTextEditorWithNonEmptyText.

	targetEvent := nil.
	triggerCount := 0.
	textEditor
		when: BrTextEditorModificationEvent
		do: [ :anEvent | 
			targetEvent := anEvent.
			triggerCount := triggerCount + 1 ].

	textEditor deleter
		from: 1 to: 3;
		delete.

	self assert: triggerCount equals: 1.
	self assert: textEditor text asString equals: '14'.
	self assert: targetEvent indices asArray equals: #(2).
	self assert: targetEvent lengths asArray equals: #(2).

	^ targetEvent
]

{ #category : #'examples - document id' }
BrTextEditorModificationEventExamples >> deleteTextEventsCarryThePostMutationDocumentId [
	"See #insertTextEventsCarryThePostMutationDocumentId."

	<gtExample>
	<return: #Array>
	| textEditor aDocumentIdBefore theEventDocumentIds |
	textEditor := self newTextEditorWithNonEmptyText.
	aDocumentIdBefore := textEditor documentId.

	theEventDocumentIds := OrderedCollection new.
	textEditor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | theEventDocumentIds add: #modified -> anEvent documentId ].
	textEditor
		when: BrTextEditorDeletionModificationEvent
		do: [ :anEvent | theEventDocumentIds add: #deleted -> anEvent documentId ].

	textEditor deleter
		from: 1 to: 3;
		delete.

	self assert: textEditor text asString equals: '14'.
	self
		assert: (theEventDocumentIds collect: [ :each | each key ]) asArray
		equals: #(#modified #deleted).
	theEventDocumentIds
		do: [ :each | self assert: each value equals: textEditor documentId ].

	self assert: textEditor documentId textId equals: aDocumentIdBefore textId.
	self
		assert: textEditor documentId revisionId
		equals: aDocumentIdBefore revisionId + 1.

	^ theEventDocumentIds asArray
]

{ #category : #examples }
BrTextEditorModificationEventExamples >> deleteTextIntoEditorEvent [
	<gtExample>
	<return: #BrTextEditorModifiedEvent>
	| textEditor targetEvent triggerCount |
	textEditor := self newTextEditorWithNonEmptyText.

	targetEvent := nil.
	triggerCount := 0.
	textEditor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | 
			targetEvent := anEvent.
			triggerCount := triggerCount + 1 ].

	textEditor deleter
		from: 1 to: 2;
		delete.

	self assert: triggerCount equals: 1.
	self assert: textEditor text asString equals: '134'.
	self assert: targetEvent text asString equals: '134'.

	^ targetEvent
]

{ #category : #examples }
BrTextEditorModificationEventExamples >> deleteTextIntoEditorEvent_deleteCommand [
	<gtExample>
	<return: #BrTextEditorHistoryDeletionCommand>
	| editEvent insertCommand |
	editEvent := self deleteTextIntoEditorEvent.
	insertCommand := editEvent editCommand.

	self assert: insertCommand notNil.
	self assert: insertCommand texts size equals: 1.
	self assert: insertCommand texts first asString equals: '2'.
	self assert: insertCommand undoIndices equals: #(2).
	self assert: insertCommand redoIndices equals: #(2).

	^ insertCommand
]

{ #category : #examples }
BrTextEditorModificationEventExamples >> insertTextCreatesModificationEvent [
	<gtExample>
	<return: #BrTextEditorDeletionModificationEvent>
	| textEditor targetEvent triggerCount |
	textEditor := self newTextEditorWithEmptyText.

	targetEvent := nil.
	triggerCount := 0.
	textEditor
		when: BrTextEditorModificationEvent
		do: [ :anEvent | 
			targetEvent := anEvent.
			triggerCount := triggerCount + 1 ].

	textEditor inserter
		atEnd;
		string: 'abc';
		insert.

	self assert: triggerCount equals: 1.
	self assert: textEditor text asString equals: 'abc'.
	self assert: targetEvent indices asArray equals: #(0).
	self assert: targetEvent lengths asArray equals: #(3).
	self assert: targetEvent strings asArray equals: #('abc').

	^ targetEvent
]

{ #category : #'examples - document id' }
BrTextEditorModificationEventExamples >> insertTextEventsCarryThePostMutationDocumentId [
	"Every event of one insertion must carry the document id the text has *after* the change.
	The text advances its revision before announcing, and the editor reads its document id
	through to the text, so this is what it reported before the id moved to the text too."

	<gtExample>
	<return: #Array>
	| textEditor aDocumentIdBefore theEventDocumentIds |
	textEditor := self newTextEditorWithEmptyText.
	aDocumentIdBefore := textEditor documentId.

	theEventDocumentIds := OrderedCollection new.
	textEditor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | theEventDocumentIds add: #modified -> anEvent documentId ].
	textEditor
		when: BrTextEditorInsertionModificationEvent
		do: [ :anEvent | theEventDocumentIds add: #inserted -> anEvent documentId ].

	textEditor inserter
		atEnd;
		string: 'abc';
		insert.

	self assert: textEditor text asString equals: 'abc'.
	self
		assert: (theEventDocumentIds collect: [ :each | each key ]) asArray
		equals: #(#modified #inserted).
	theEventDocumentIds
		do: [ :each | self assert: each value equals: textEditor documentId ].

	self assert: textEditor documentId textId equals: aDocumentIdBefore textId.
	self
		assert: textEditor documentId revisionId
		equals: aDocumentIdBefore revisionId + 1.

	^ theEventDocumentIds asArray
]

{ #category : #examples }
BrTextEditorModificationEventExamples >> insertTextIntoEmptyEditorEvent [
	<gtExample>
	<return: #BrTextEditorModifiedEvent>
	| textEditor targetEvent triggerCount |
	textEditor := self newTextEditorWithEmptyText.

	targetEvent := nil.
	triggerCount := 0.
	textEditor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | 
			targetEvent := anEvent.
			triggerCount := triggerCount + 1 ].

	textEditor inserter
		atEnd;
		string: 'a';
		insert.

	self assert: triggerCount equals: 1.
	self assert: textEditor text asString equals: 'a'.
	self assert: targetEvent text asString equals: 'a'.

	^ targetEvent
]

{ #category : #examples }
BrTextEditorModificationEventExamples >> insertTextIntoEmptyEditorEvent_insertCommand [
	<gtExample>
	<return: #BrTextEditorHistoryInsertionCommand>
	| editEvent insertCommand |
	editEvent := self insertTextIntoEmptyEditorEvent.
	insertCommand := editEvent editCommand.

	self assert: insertCommand notNil.
	self assert: insertCommand strings equals: #('a').
	self assert: insertCommand undoIndices equals: #(0).
	self assert: insertCommand redoIndices equals: #(0).

	^ insertCommand
]

{ #category : #'examples - setup' }
BrTextEditorModificationEventExamples >> newTextEditorWithEmptyText [
	<gtExample>
	<return: #BrTextEditorModel>
	| textEditor |
	textEditor := BrTextEditorModel new.

	self assert: textEditor text isEmpty.

	^ textEditor
]

{ #category : #'examples - setup' }
BrTextEditorModificationEventExamples >> newTextEditorWithNonEmptyText [
	<gtExample>
	<return: #BrTextEditorModel>
	| textEditor |
	textEditor := BrTextEditorModel new.
	textEditor text: '1234' asRopedText.

	self assert: textEditor text isNotEmpty.

	^ textEditor
]

{ #category : #'examples - document id' }
BrTextEditorModificationEventExamples >> replacingTheTextCarriesTheDocumentIdOfTheNewText [
	"Replacing the text means editing a different document, so the event must carry the id of
	the text that just became the editor's own."

	<gtExample>
	<return: #BrTextEditorTextReplacedEvent>
	| textEditor aDocumentIdBefore aNewText targetEvent |
	textEditor := self newTextEditorWithNonEmptyText.
	aDocumentIdBefore := textEditor documentId.
	aNewText := 'abcd' asRopedText.

	targetEvent := nil.
	textEditor
		when: BrTextEditorTextReplacedEvent
		do: [ :anEvent | targetEvent := anEvent ].

	textEditor text: aNewText.

	self assert: targetEvent documentId equals: aNewText documentId.
	self assert: targetEvent documentId equals: textEditor documentId.
	self
		assert: targetEvent documentId textId = aDocumentIdBefore textId
		equals: false.

	^ targetEvent
]

{ #category : #'examples - document id' }
BrTextEditorModificationEventExamples >> replacingTheTextSignalsTheDocumentIdChange [
	"Replacing the text still emits BrTextEditorModelDocumentIdChangedSignal, now reporting the
	id of the text that just became the editor's rather than an id the editor kept itself."

	<gtExample>
	<return: #Array>
	| textEditor aDocumentIdBefore aLogger theSignalledDocumentIds |
	textEditor := self newTextEditorWithNonEmptyText.
	aDocumentIdBefore := textEditor documentId.

	aLogger := MemoryLogger new.
	aLogger runDuring: [ textEditor text: 'abcd' asRopedText ].

	theSignalledDocumentIds := (aLogger recordings
		select: [ :each | each isKindOf: BrTextEditorModelDocumentIdChangedSignal ]
		thenCollect: [ :each | each documentId ]) asArray.

	self assert: theSignalledDocumentIds size equals: 1.
	self assert: theSignalledDocumentIds first equals: textEditor documentId.
	self
		assert: theSignalledDocumentIds first textId = aDocumentIdBefore textId
		equals: false.

	^ theSignalledDocumentIds
]
