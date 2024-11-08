Class {
	#name : #BrTextEditorExplicitScreenToCursorTransformation,
	#superclass : #BrTextEditorScreenToCursorTransformation,
	#instVars : [
		'screenPosition'
	],
	#category : #'Brick-Editor-Model - Cursor'
}

{ #category : #dispatching }
BrTextEditorExplicitScreenToCursorTransformation >> evaluateOn: aSegmentHolder [
	aSegmentHolder explicitScreenToCursor: self
]

{ #category : #dispatching }
BrTextEditorExplicitScreenToCursorTransformation >> evaluateOn: aCommand for: anEvent [
	aCommand explicitScreenToCursor: self for: anEvent
]

{ #category : #accessing }
BrTextEditorExplicitScreenToCursorTransformation >> screenPosition [
	^ screenPosition
]

{ #category : #accessing }
BrTextEditorExplicitScreenToCursorTransformation >> screenPosition: aPoint [
	screenPosition := aPoint
]
