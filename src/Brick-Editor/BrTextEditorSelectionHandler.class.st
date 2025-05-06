Class {
	#name : #BrTextEditorSelectionHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'startIndex'
	],
	#category : #'Brick-Editor-UI - Handlers'
}

{ #category : #'dnd handlers' }
BrTextEditorSelectionHandler >> dragEvent: anEvent [
	| anEditor currentIndex |	
	anEvent consumed: true.
	
	anEvent localPosition y <= 0
		ifTrue: [ anEvent currentTarget smoothScrollBy: 0 @ 20 negated ].
				
	anEvent localPosition y >= anEvent currentTarget  height
		ifTrue: [ anEvent currentTarget smoothScrollBy: 0 @ 20 ].

	anEditor := anEvent currentTarget editor.

	currentIndex := anEditor navigator
		findTextIndexAtScreenPosition: anEvent localPosition
		ifAbsent: [ ^ self ].

	self
		assert: [ currentIndex between: 0 and: anEditor text size ]
		description: [ 'Text index ({1}) must be within text bounds {2}'
			format: { currentIndex . 0 to: anEditor text size } ].
	
	startIndex ifNil: [ startIndex := currentIndex ].
	
	startIndex = currentIndex
		ifTrue: [
			anEditor deselecter
				all;
				deselect.
			anEditor navigator
				  moveTo: currentIndex;
				  apply ]
		ifFalse: [
			anEditor selecter
				overwrite;
				from: startIndex to: currentIndex;
				select ]
]

{ #category : #'dnd handlers' }
BrTextEditorSelectionHandler >> dragStartEvent: anEvent [
	| anEditor |	
	anEvent consumed: true.

	anEditor := anEvent currentTarget editor.
	anEditor deselecter all deselect.
	
	startIndex := anEditor navigator
		findTextIndexAtScreenPosition: anEvent localPosition
		ifAbsent: [ nil ].
]

{ #category : #'api - accessing' }
BrTextEditorSelectionHandler >> eventsToHandle [
	^ { BlDragEvent . BlDragStartEvent }
]
