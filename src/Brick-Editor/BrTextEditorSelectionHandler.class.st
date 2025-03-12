Class {
	#name : #BrTextEditorSelectionHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'startIndex'
	],
	#category : #'Brick-Editor-UI - Handlers'
}

{ #category : #'dnd handlers' }
BrTextEditorSelectionHandler >> dragEndEvent: anEvent [
	"I end a selection at an event's editor, while also updating the cursor."

	| anEditor currentIndex |
	anEvent consumed: true.

	anEditor := anEvent currentTarget editor.

	currentIndex := anEditor navigator
			findTextIndexAtScreenPosition: anEvent localPosition
			ifAbsent: [ ^ self ].

	self
		assert: [ currentIndex between: 0 and: anEditor text size ]
		description: [ 'Text index ({1}) must be within text bounds {2}'
				format: {currentIndex.
						0 to: anEditor text size} ].

	startIndex ifNil: [ startIndex := currentIndex ].

	anEditor selecter
		overwrite;
		from: (startIndex min: currentIndex) to: (startIndex max: currentIndex);
		select
]

{ #category : #'dnd handlers' }
BrTextEditorSelectionHandler >> dragEvent: anEvent [
	"I update an event's editor selection, upon a mouse drag.
	For performance reasons I make sure to not update the cursor with the selection."

	| anEditor currentIndex |
	anEvent consumed: true.

	anEditor := anEvent currentTarget editor.

	currentIndex := anEditor navigator
			findTextIndexAtScreenPosition: anEvent localPosition
			ifAbsent: [ ^ self ].

	self
		assert: [ currentIndex between: 0 and: anEditor text size ]
		description: [ 'Text index ({1}) must be within text bounds {2}'
				format: {currentIndex.
						0 to: anEditor text size} ].

	startIndex ifNil: [ startIndex := currentIndex ].

	anEditor selecter
		overwrite;
		withoutCursorUpdate;
		from: (startIndex min: currentIndex) to: (startIndex max: currentIndex);
		select
]

{ #category : #'dnd handlers' }
BrTextEditorSelectionHandler >> dragStartEvent: anEvent [
	"I initiate a selection at an event's editor."

	| anEditor |
	anEvent consumed: true.

	anEditor := anEvent currentTarget editor.
	anEditor deselecter all deselect.

	startIndex := anEditor navigator
			findTextIndexAtScreenPosition: anEvent localPosition
			ifAbsent: [ nil ]
]

{ #category : #'api - accessing' }
BrTextEditorSelectionHandler >> eventsToHandle [
	^ {BlDragEvent.
		BlDragStartEvent.
		BlDragEndEvent}
]
