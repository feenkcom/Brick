"
I handle mouse down events and move or add a cursor at a corresponding position
"
Class {
	#name : #BrTextEditorMouseDownHandler,
	#superclass : #BlCustomEventHandler,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Brick-Editor-UI - Handlers'
}

{ #category : #cleanup }
BrTextEditorMouseDownHandler class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #cleanup }
BrTextEditorMouseDownHandler class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #'api - accessing' }
BrTextEditorMouseDownHandler >> eventsToHandle [
	^ { BlMouseDownEvent }
]

{ #category : #'api - event managing' }
BrTextEditorMouseDownHandler >> mouseDownEvent: anEvent [
	| aNavigator aScreenPosition anEditorElement aTextIndex editor |
	"To not create an instance of me for each tiny text element"
	anEditorElement := anEvent currentTarget
			withAllParentsDetect: [ :anElement | anElement isKindOf: BrEditorElement ]
			ifFound: #yourself
			ifNone: [ ^ self ].

	anEvent target
		withAllParentsUpTo: anEditorElement
		detect: [ :anElement | anElement userData at: #brickEditorAdornment ifAbsent: [ false ] ]
		ifFound: [ :anAdornmentElement | ^ self ]
		ifNone: #yourself.

	anEvent consumed: true.
	aScreenPosition := (anEditorElement
			localBoundsToMine: (BlBounds origin: anEvent localPosition extent: 0.0 @ 0.0)
			fromChild: anEvent currentTarget) center.

	editor := anEditorElement editor.
	aNavigator := editor navigator.
	aTextIndex := aNavigator
			findTextIndexAtScreenPosition: aScreenPosition
			ifAbsent: [ nil ].

	anEvent modifiers isShift
		ifTrue: [ aTextIndex
				ifNotNil: [ (editor selection contains: aTextIndex)
						ifTrue: [ editor deselecter
								from: aTextIndex to: editor selection indices last;
								deselect ]
						ifFalse: [ editor selecter
								extendToIndex: aTextIndex;
								select ] ] ]
		ifFalse: [ editor deselecter all deselect ].

	anEvent modifiers isPrimaryModifier
		ifTrue: [ aNavigator addAtScreenPosition: aScreenPosition ]
		ifFalse: [ aNavigator moveToScreenPosition: aScreenPosition ].
	aNavigator apply.	
	
	"it is important to request focus *after* we add a cursor, otherwise it would jump to the 0 position when
	handling focus event"
	anEditorElement requestFocus
]

{ #category : #'api - event managing' }
BrTextEditorMouseDownHandler >> wantsEvent: anEvent [
	^ (super wantsEvent: anEvent) and: [ anEvent primaryButtonPressed ]
]
