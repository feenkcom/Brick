Class {
	#name : #BrEditorShiftLeftShortcut,
	#superclass : #BrEditorShortcut,
	#category : #'Brick-Editor-Shortcuts'
}

{ #category : #accessing }
BrEditorShiftLeftShortcut >> description [
	^ 'Shift text at the cursor or if there is selection, the selected lines, one indetation to the left.'
]

{ #category : #initialization }
BrEditorShiftLeftShortcut >> initialize [
	super initialize.
	
	combination := BlKeyCombination builder shift tab build
]

{ #category : #accessing }
BrEditorShiftLeftShortcut >> name [
	^ 'Shift left'
]

{ #category : #evaluation }
BrEditorShiftLeftShortcut >> performOnEditor: aBrTextEditor element: aBrEditorElement dueTo: aShortcutEvent [
	aBrTextEditor selection isEmpty
		ifTrue: [
			aBrTextEditor deleter
				beforeCurrentLineIfIndent;
				delete ]
		ifFalse: [
			aBrTextEditor deleter
				beforeSelectedLinesIfIndent;
				delete ]
]
