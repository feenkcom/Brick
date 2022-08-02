"
I am same editable mode as {{gtClass:BrTextEditorEditableMode}}.
I always insert `CR` line ending when a user presses the `return` key.


"
Class {
	#name : #BrTextEditorEditableCodeMode,
	#superclass : #BrTextEditorEditableMode,
	#category : #'Brick-Editor-Model'
}

{ #category : #defaults }
BrTextEditorEditableCodeMode >> returnKeyAndAction [
	^ BrEditorShortcut carriageReturn 
]
