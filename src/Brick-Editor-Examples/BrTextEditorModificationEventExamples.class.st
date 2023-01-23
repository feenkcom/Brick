Class {
	#name : #BrTextEditorModificationEventExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples-Model'
}

{ #category : #examples }
BrTextEditorModificationEventExamples >> deleteTextIntoEditorEvent [
	<gtExample>
	| textEditor targetEvent triggerCount |
	
	textEditor := self newTextEditorWithNonEmptyText.
	
	targetEvent := nil.
	triggerCount := 0.
	textEditor when: BrTextEditorModifiedEvent do: [ :anEvent |
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
	| editEvent  insertCommand |
	
	editEvent := self deleteTextIntoEditorEvent.
	insertCommand := editEvent editCommand.
	
	self assert: insertCommand  notNil.
	self assert: insertCommand texts size equals: 1.
	self assert: insertCommand texts first asString equals: '2'.
	self assert: insertCommand undoIndices equals: #(2).
	self assert: insertCommand redoIndices equals: #(2).
	
	^ insertCommand
]

{ #category : #examples }
BrTextEditorModificationEventExamples >> insertTextIntoEmptyEditorEvent [
	<gtExample>
	| textEditor targetEvent triggerCount |
	
	textEditor := self newTextEditorWithEmptyText.
	
	targetEvent := nil.
	triggerCount := 0.
	textEditor when: BrTextEditorModifiedEvent do: [ :anEvent |
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
	| editEvent  insertCommand |
	
	editEvent := self insertTextIntoEmptyEditorEvent.
	insertCommand := editEvent editCommand.
	
	self assert: insertCommand  notNil.
	self assert: insertCommand strings equals: #('a').
	self assert: insertCommand undoIndices equals: #(0).
	self assert: insertCommand redoIndices equals: #(0).
	
	^ insertCommand
]

{ #category : #'examples - setup' }
BrTextEditorModificationEventExamples >> newTextEditorWithEmptyText [
	<gtExample>
	| textEditor |

	textEditor := BrTextEditorModel new.
	
	self assert: textEditor text isEmpty.
		
	^ textEditor
]

{ #category : #'examples - setup' }
BrTextEditorModificationEventExamples >> newTextEditorWithNonEmptyText [
	<gtExample>
	| textEditor |

	textEditor := BrTextEditorModel new.
	textEditor text: '1234' asRopedText.
	
	self assert: textEditor text isNotEmpty.
		
	^ textEditor
]
