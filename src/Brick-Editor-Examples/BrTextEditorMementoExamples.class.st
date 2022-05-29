Class {
	#name : #BrTextEditorMementoExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples-Model'
}

{ #category : #'examples - memento' }
BrTextEditorMementoExamples >> editorRestoreState [
	<gtExample>
	| aMemento aTextEditor |
	
	aMemento := self editorSaveState.
	aTextEditor := self newTextEditor.
	
	aTextEditor restoreState: aMemento.
	
	^ aTextEditor
]

{ #category : #'examples - memento' }
BrTextEditorMementoExamples >> editorRestoreStateWithShorterText [
	<gtExample>
	| anEditor aScripter aMemento |
	
	anEditor := BrEditor new.
	anEditor aptitude: BrEditorAptitude new glamorousRegularFont.
	anEditor text: 'test12
^ 22'.
	anEditor navigator
		moveToEnd;
		apply.

	aScripter := BlDevScripter new element: anEditor.
	aScripter requestFocus play.
	
	aMemento := BrTextEditorCompositeMemento new.
	aMemento addMemento: (BrTextEditorCursorsMemento new cursors: (BrTextEditorCursor at: 4)).
	aMemento addMemento: (BrTextEditorTextMemento new text: 'haba' asRopedText).
	
	aScripter do
		action: [ :anEditorInScripter | anEditorInScripter editor restoreState: aMemento ];
		play.

	aScripter check
		value: [ :anEditorInScripter | anEditorInScripter text asString ] equals: 'haba';
		value: [ :anEditorInScripter | anEditorInScripter cursors ] equals: (BrTextEditorCursor atAll: #(4));
		play.

	^ aScripter
]

{ #category : #'examples - memento' }
BrTextEditorMementoExamples >> editorSaveState [
	<gtExample>
	| aTextEditor aMemento |
	
	aTextEditor := self textEditorWithState.
	aMemento := aTextEditor saveState.
	
	^ aMemento
]

{ #category : #'instance creation' }
BrTextEditorMementoExamples >> newTextEditor [
	<gtExample>
	| aTextEditor |

	aTextEditor := BrTextEditor new.
	^ aTextEditor
]

{ #category : #'instance creation' }
BrTextEditorMementoExamples >> textEditorWithState [
	<gtExample>
	| aTextEditor |

	aTextEditor := BrTextEditor new
		text: 'Hello world' asRopedText glamorousCodeFontAndSize.
	
	aTextEditor navigator
		addAt: 1;
		addAt: 9;
		apply.	

	aTextEditor selecter
		from: 3 to: 8;
		withoutCursorUpdate;
		select.
	
	^ aTextEditor
]
