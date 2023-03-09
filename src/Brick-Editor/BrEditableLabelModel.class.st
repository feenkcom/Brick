Class {
	#name : #BrEditableLabelModel,
	#superclass : #BrTextEditorModel,
	#category : #'Brick-Editor-Model'
}

{ #category : #'private - focus' }
BrEditableLabelModel >> onGotFocus [
	isFocused := true.

	self processCursorEnterEvents.
	self enqueueCommand: (self newFocusChangedCommand hasFocus: true)
]
