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
	anEvent currentTarget userData removeKey: #wordSelectionAnchor ifAbsent: []
]

{ #category : #'dnd handlers' }
BrTextEditorSelectionHandler >> dragEvent: anEvent [
	| anEditor currentIndex anchor aSelecter currentUnitInterval selStart selEnd |
	anEvent consumed: true.
	anEvent localPosition y <= 0
		ifTrue: [ anEvent currentTarget smoothScrollBy: 0 @ 20 negated ].
	anEvent localPosition y >= anEvent currentTarget height
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
	anchor := anEvent currentTarget userData at: #wordSelectionAnchor ifAbsent: [ nil ].
	anchor ifNil: [
		startIndex = currentIndex
			ifTrue: [
				anEditor deselecter all; deselect.
				anEditor navigator moveTo: currentIndex; apply ]
			ifFalse: [
				anEditor selecter
					overwrite;
					from: startIndex to: currentIndex;
					select ].
		^ self ].
	aSelecter := anEditor selecter.
	currentUnitInterval := aSelecter findDelimitedUnitAt: currentIndex.
	currentUnitInterval isEmpty
		ifTrue: [ currentUnitInterval := aSelecter
				findWordAt: currentIndex
				withClassifier: anEditor doubleClickWordClassifier ].
	selStart := anchor key min: currentUnitInterval first.
	selEnd := anchor value max: currentUnitInterval last.
	anEditor selecter
		overwrite;
		from: selStart to: selEnd;
		select
]

{ #category : #'dnd handlers' }
BrTextEditorSelectionHandler >> dragStartEvent: anEvent [
	| anEditor currentIndex |
	anEvent consumed: true.
	anEditor := anEvent currentTarget editor.
	currentIndex := anEditor navigator
		findTextIndexAtScreenPosition: anEvent localPosition
		ifAbsent: [ nil ].
	startIndex := currentIndex.
	anEvent currentTarget userData removeKey: #wordSelectionAnchor ifAbsent: [].
	currentIndex ifNil: [ ^ self ].
	anEditor selection isEmpty
		ifTrue: [ anEditor deselecter all deselect ]
		ifFalse: [
			| aSelecter aUnitInterval |
			aSelecter := anEditor selecter.
			aUnitInterval := aSelecter findDelimitedUnitAt: currentIndex.
			aUnitInterval isEmpty
				ifTrue: [ aUnitInterval := aSelecter
						findWordAt: currentIndex
						withClassifier: anEditor doubleClickWordClassifier ].
			anEvent currentTarget userData
				at: #wordSelectionAnchor
				put: (aUnitInterval first -> aUnitInterval last) ]
]

{ #category : #'api - accessing' }
BrTextEditorSelectionHandler >> eventsToHandle [
	^ { BlDragEvent . BlDragStartEvent . BlDragEndEvent }
]
