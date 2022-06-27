Class {
	#name : #BrTextEditorLineSegmentTextPiece,
	#superclass : #BrTextEditorLineSegmentPiece,
	#category : #'Brick-Editor-Model - Segment-Text-Line'
}

{ #category : #'instance creation' }
BrTextEditorLineSegmentTextPiece >> createElement: anEditorElement [
	<return: #BlElement>
	^ self createTextElement: anEditorElement
]

{ #category : #testing }
BrTextEditorLineSegmentTextPiece >> isText [
	^ true
]
