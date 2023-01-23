Class {
	#name : #BrTextEditorHistoryExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples-Model'
}

{ #category : #accessing }
BrTextEditorHistoryExamples >> assertEditorHistoryFor: aTextEditor undoCount: anUndoCount redoCount: aRedoCount [ 
	self 
		assert: aTextEditor history undoCommands size 
		equals: anUndoCount.
		
	self 
		assert: aTextEditor history redoCommands size 
		equals: aRedoCount.
]

{ #category : #asserting }
BrTextEditorHistoryExamples >> assertNoHistoryForEditor: aTextEditor [ 
	self assert: aTextEditor history undoCommands isEmpty.
	self assert: aTextEditor history redoCommands isEmpty.
]

{ #category : #accessing }
BrTextEditorHistoryExamples >> deleteSingleCharacterInEditor [
	<gtExample>
	| textEditor |

	textEditor := self newTextEditorWithInitialText.
	textEditor deleter
		from: 1 to: 2;
		delete.
		
	self assert: textEditor history isEnabled.
	self assert: textEditor history shouldGroup not.
	self assert: textEditor text asString equals: '134'.
		
	^ textEditor
]

{ #category : #accessing }
BrTextEditorHistoryExamples >> deleteSingleCharacterInEditor_command [
	<gtExample>
	| textEditor command |

	textEditor := self deleteSingleCharacterInEditor.
	command := textEditor history undoCommands first.
	
	self assert: command texts size equals: 1.
	self assert: command texts first asString equals: '2'.
	self assert: command undoIndices equals: #(2).
	self assert: command redoIndices equals: #(2).
		
	^ command
]

{ #category : #accessing }
BrTextEditorHistoryExamples >> deleteSingleCharacterInEditor_hasUndoCommand [
	<gtExample>
	| textEditor |

	textEditor := self deleteSingleCharacterInEditor.
		
	self assertEditorHistoryFor: textEditor undoCount: 1 redoCount: 0.
		 
	^ textEditor
]

{ #category : #accessing }
BrTextEditorHistoryExamples >> insertSingleCharacterInEmptyEditor [
	<gtExample>
	| textEditor |

	textEditor := self newTextEditor.
	textEditor inserter
		atEnd;
		string: 'a';
		insert.
		
	self assert: textEditor history isEnabled.
	self assert: textEditor history shouldGroup not.
	self assert: textEditor text asString equals: 'a'.
		
	^ textEditor
]

{ #category : #accessing }
BrTextEditorHistoryExamples >> insertSingleCharacterInEmptyEditor_command [
	<gtExample>
	| textEditor command |

	textEditor := self insertSingleCharacterInEmptyEditor.
	command := textEditor history undoCommands first.
	
	self assert: command strings equals: #('a').
	self assert: command undoIndices equals: #(0).
	self assert: command redoIndices equals: #(0).
		
	^ command
]

{ #category : #accessing }
BrTextEditorHistoryExamples >> insertSingleCharacterInEmptyEditor_hasUndoCommand [
	<gtExample>
	| textEditor |

	textEditor := self insertSingleCharacterInEmptyEditor.
		
	self assert: textEditor history undoCommands size equals: 1.
	self assert: textEditor history redoCommands size equals: 0.
		
	^ textEditor
]

{ #category : #accessing }
BrTextEditorHistoryExamples >> newTextEditor [
	<gtExample>
	| textEditor |

	textEditor := BrTextEditorModel new.
	self assert: textEditor history isEnabled.
	self assert: textEditor history shouldGroup not.
		
	^ textEditor
]

{ #category : #accessing }
BrTextEditorHistoryExamples >> newTextEditorWithInitialText [
	<gtExample>
	| textEditor |

	textEditor := self newTextEditor.
	textEditor text: '1234' asRopedText. 
	
	self assert: textEditor history isEnabled.
	self assert: textEditor history shouldGroup not.
		
	^ textEditor
]

{ #category : #accessing }
BrTextEditorHistoryExamples >> newTextEditorWithInitialText_noInitialHistory [
	<gtExample>
	| textEditor |

	textEditor := self newTextEditorWithInitialText.
	self assertNoHistoryForEditor: textEditor.
		
	^ textEditor
]

{ #category : #accessing }
BrTextEditorHistoryExamples >> newTextEditor_noInitialHistory [
	<gtExample>
	| textEditor |

	textEditor := self newTextEditor.
	self assertNoHistoryForEditor: textEditor.
		
	^ textEditor
]
