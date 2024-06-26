Class {
	#name : #BrTextEditorReadonlyWithSelectionMode,
	#superclass : #BrTextEditorBasicMode,
	#category : #'Brick-Editor-Model'
}

{ #category : #initialization }
BrTextEditorReadonlyWithSelectionMode >> createEventHandlers [
	^ super createEventHandlers, {
		BrTextEditorMouseDownHandler uniqueInstance.
		BrTextEditorDoubleClickHandler uniqueInstance.
		BrTextEditorSelectionHandler new.
		BrTextEditorCursorIconHandler uniqueInstance.
	}
]

{ #category : #initialization }
BrTextEditorReadonlyWithSelectionMode >> createShortcuts [
	^ super createShortcuts, {
		BrEditorShortcut copy.
		BrEditorShortcut selectAll.
		BrEditorShortcut deselectAll.
	}
]

{ #category : #'api - hooks' }
BrTextEditorReadonlyWithSelectionMode >> installOnEditor: aTextEditor [
	super installOnEditor: aTextEditor.

	aTextEditor segmentBuilder beReadOnly
]

{ #category : #testing }
BrTextEditorReadonlyWithSelectionMode >> isReadOnly [
	^ true
]
