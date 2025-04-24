Class {
	#name : #BrEditorSearchTextBasicVisualizer,
	#superclass : #BrEditorSearchTextVisualizer,
	#instVars : [
		'editor',
		'actions'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #accessing }
BrEditorSearchTextBasicVisualizer >> action: aBlock [
	actions := self actions copyWith: aBlock
]

{ #category : #accessing }
BrEditorSearchTextBasicVisualizer >> actions [
	^ actions ifNil: [ actions := Array empty ]
]

{ #category : #accessing }
BrEditorSearchTextBasicVisualizer >> actions: anObject [
	actions := anObject
]

{ #category : #factory }
BrEditorSearchTextBasicVisualizer >> editor: aBrEditor [
	editor := aBrEditor
]

{ #category : #'api - displaying' }
BrEditorSearchTextBasicVisualizer >> executeActionInContext: aBrEditorSearchTextVisualizerContext [
	editor ifNil: [ ^ self ].

	self actions
		do: [ :eachBlock | eachBlock cull: aBrEditorSearchTextVisualizerContext cull: editor ]
]

{ #category : #'api - displaying' }
BrEditorSearchTextBasicVisualizer >> onSelectionInContext: aBrEditorSearchTextVisualizerContext [
	editor ifNil: [ ^ self ].

	self scrollContext: aBrEditorSearchTextVisualizerContext.
	self executeActionInContext: aBrEditorSearchTextVisualizerContext.
]

{ #category : #'api - displaying' }
BrEditorSearchTextBasicVisualizer >> scrollContext: aBrEditorSearchTextVisualizerContext [
	| aFirstSegment aLastSegment aStartPosition |
	editor ifNil: [ ^ self ].

	aStartPosition := aBrEditorSearchTextVisualizerContext selectedStartPosition.
	aFirstSegment := (editor layout
			findFirstVisibleChildClosestToStartCompletelyVisible: true
			acceptPartiallyVisible: false) ifNotNil: #segment.
	aLastSegment := (editor layout
			findFirstVisibleChildClosestToEndCompletelyVisible: true
			acceptPartiallyVisible: false) ifNotNil: #segment.

	(aFirstSegment isNotNil and: [ 
		aLastSegment isNotNil and: [
			aFirstSegment textStart >= aStartPosition and: [ 
				aLastSegment textEnd <= aStartPosition ] ] ]) ifTrue: [ ^ self ].

	editor smoothScrollToPosition: aBrEditorSearchTextVisualizerContext selectedLine
]

{ #category : #'api - displaying' }
BrEditorSearchTextBasicVisualizer >> selectionContext: aBrEditorSearchTextVisualizerContext [
	editor ifNil: [ ^ self ].
	
	BlTaskAction
		enqueueElement: editor
		action: [ self onSelectionInContext: aBrEditorSearchTextVisualizerContext ]
]
