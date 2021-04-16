"
I am sent when a cursor related change happened at a given text position.

It can be that a cursor was removed from this position or added at it
"
Class {
	#name : #BrTextEditorCursorChangeCommand,
	#superclass : #BrTextEditorCommand,
	#instVars : [
		'position',
		'cursor'
	],
	#category : #'Brick-Editor-Commands'
}

{ #category : #accessing }
BrTextEditorCursorChangeCommand >> cursor [
	<return: #BrTextEditorSingleCursor>

	^ cursor
]

{ #category : #accessing }
BrTextEditorCursorChangeCommand >> cursor: anObject [
	cursor := anObject
]

{ #category : #executing }
BrTextEditorCursorChangeCommand >> executeOn: aTextEditor [
	
	self telemetry
		timeSync: [ 'Process attributes' ]
		during: [ self processAttributesOn: aTextEditor ].

	aTextEditor segmentCollector
		cachedSegmentAt: self position
		ifFound: [ :aSegment |
			self telemetry
				timeSync: [ 'Enqueue cursor changed holder command {1}' format: { aSegment index to: aSegment index } ]
				during: [
					aTextEditor
						enqueueHolderCommand: self newHolderCommand
						interval: (aSegment index to: aSegment index) ] ]
		ifNotFound: [  ].
]

{ #category : #'instance creation' }
BrTextEditorCursorChangeCommand >> newHolderCommand [
	^ BrTextEditorCursorChangedHolderCommand new context: self context
]

{ #category : #accessing }
BrTextEditorCursorChangeCommand >> position [
	^ position
]

{ #category : #accessing }
BrTextEditorCursorChangeCommand >> position: anObject [
	position := anObject
]

{ #category : #printing }
BrTextEditorCursorChangeCommand >> printOn: aStream [
	aStream
		nextPutAll: 'Cursor changed at ';
		print: self position
]

{ #category : #executing }
BrTextEditorCursorChangeCommand >> processAttributesOn: aTextEditor [
	| anEditorText thePotentialHandlerTextInterval theEventHandlingAttributes eventHandlingAttributesOutside eventHandlingAttributesInside |

	anEditorText := aTextEditor text.

	self position > anEditorText size
		ifTrue: [ ^ self ].
		
	self position <= 0
		ifTrue: [ ^ self ].
	
	"only chars to the left from the cursor handle cursor events"
	thePotentialHandlerTextInterval := self position to: self position.

	theEventHandlingAttributes := ((thePotentialHandlerTextInterval
		flatCollect: [ :eachTextIndex | anEditorText attributesAt: eachTextIndex ])
			select: [ :eachAttribute | eachAttribute isEventHandler ]) asSet.

	theEventHandlingAttributes
		ifEmpty: [ ^ self ].
	
	eventHandlingAttributesOutside := OrderedCollection new.
	eventHandlingAttributesInside := OrderedCollection new.

	theEventHandlingAttributes do: [ :eachEventHandlerAttribute |
		anEditorText
			findAttribute: eachEventHandlerAttribute
			indicesDo: [ :eachEventHandlerStart :eachEventHandlerEnd |
				aTextEditor cursors do: [ :eachCursor |
					(eachCursor position between: eachEventHandlerStart and: eachEventHandlerEnd)
						ifTrue: [ eventHandlingAttributesInside add: eachEventHandlerAttribute ]
						ifFalse: [ eventHandlingAttributesOutside add: eachEventHandlerAttribute ] ] ] ].
	
	eventHandlingAttributesOutside do: [ :eachEventHandlerAttribute |
		| anEvent |
		anEvent := BrTextEditorCursorRemovedEvent cursor: self cursor.
		(eachEventHandlerAttribute wantsEvent: anEvent in: aTextEditor)
			ifTrue: [ eachEventHandlerAttribute handleEvent: anEvent in: aTextEditor on: nil ] ].

	eventHandlingAttributesInside do: [ :eachEventHandlerAttribute |
		| anEvent |
		anEvent := BrTextEditorCursorAddedEvent cursor: self cursor.
		(eachEventHandlerAttribute wantsEvent: anEvent in: aTextEditor)
			ifTrue: [ eachEventHandlerAttribute handleEvent: anEvent in: aTextEditor on: nil ] ]
]
