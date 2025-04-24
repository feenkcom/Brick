Class {
	#name : #BrEditorSearchTextVisualizer,
	#superclass : #Object,
	#category : #'Brick-Editor - Search'
}

{ #category : #factory }
BrEditorSearchTextVisualizer class >> forEditor: aBrEditor [
	^ BrEditorSearchTextBasicVisualizer new editor: aBrEditor
]

{ #category : #factory }
BrEditorSearchTextVisualizer class >> null [
	^ BrEditorSearchTextNullVisualizer new
]

{ #category : #'api - displaying' }
BrEditorSearchTextVisualizer >> selectionContext: aBrEditorSearchTextVisualizerContext [
]
