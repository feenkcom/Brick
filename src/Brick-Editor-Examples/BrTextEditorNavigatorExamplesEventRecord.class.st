Class {
	#name : #BrTextEditorNavigatorExamplesEventRecord,
	#superclass : #Object,
	#instVars : [
		'addedEvents',
		'movedEvents',
		'removedEvents'
	],
	#category : #'Brick-Editor-Examples-Operators'
}

{ #category : #accessing }
BrTextEditorNavigatorExamplesEventRecord >> addedEvents [
	^ addedEvents
]

{ #category : #'as yet unclassified' }
BrTextEditorNavigatorExamplesEventRecord >> initialize [
	super initialize.
	addedEvents := OrderedCollection new.
	movedEvents := OrderedCollection new.
	removedEvents := OrderedCollection new
]

{ #category : #accessing }
BrTextEditorNavigatorExamplesEventRecord >> movedEvents [
	^ movedEvents
]

{ #category : #testing }
BrTextEditorNavigatorExamplesEventRecord >> noEventsOfTypes: selectorArray [
	^ selectorArray allSatisfy: [ :sel | (self perform: sel) isEmpty ]
]

{ #category : #accessing }
BrTextEditorNavigatorExamplesEventRecord >> removedEvents [
	^ removedEvents
]
