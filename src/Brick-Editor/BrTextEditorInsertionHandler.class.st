"
I handle keystroke-based insertions and must be added to the editor element
"
Class {
	#name : #BrTextEditorInsertionHandler,
	#superclass : #BlCustomEventHandler,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Brick-Editor-UI - Handlers'
}

{ #category : #accessing }
BrTextEditorInsertionHandler class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #accessing }
BrTextEditorInsertionHandler class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #'api - accessing' }
BrTextEditorInsertionHandler >> eventsToHandle [
	^ { BlTextInputEvent }
]

{ #category : #'api - insertion' }
BrTextEditorInsertionHandler >> insert: aString atCursorIn: anEditor context: anElement [

	anEditor surroundMap
		closingFor: aString asSymbol
		ifPresent: [ :aSurroundSymbol |
			anEditor inserter
				context: anElement;
				inputFilter: anEditor inputFilter;
				atCursor;
				string: aString;
				surroundings: anEditor surroundMap;
				withoutSelectionDelete;
				insert ]
		ifAbsent: [
			anEditor inserter
				context: anElement;
				inputFilter: anEditor inputFilter;
				atCursor;
				string: aString;
				surroundings: anEditor surroundMap;
				insert ]
]

{ #category : #'api - event managing' }
BrTextEditorInsertionHandler >> textInputEvent: anEvent [
    "we don't want to insert anything if primary modifier key is pressed.
    without this check if users try to use shortcuts that may don't exist such as (meta+s) the action will result in typing
    which lead to unwanted effects"

	(anEvent text allSatisfy: [ :aCharacter | Unicode isPrintable: aCharacter ])
		ifFalse: [ ^ self ].

    anEvent consumed: true.

	BlFrameTelemetry
		time: [ 'Insert {1} at cursor' format: { anEvent text asString } ]
		during: [
			self
        		insert: anEvent text asString
        		atCursorIn: anEvent currentTarget editor
				context: anEvent currentTarget ]
]
