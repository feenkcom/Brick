Class {
	#name : #BrTextEditorParagraphSegmentTextPiece,
	#superclass : #BrTextEditorParagraphSegmentPiece,
	#category : #'Brick-Editor-Model - Segment-Text-Paragraph'
}

{ #category : #'instance creation' }
BrTextEditorParagraphSegmentTextPiece >> createElement: anEditorElement [
	<return: #BlElement>
	^ self createTextElement: anEditorElement
]

{ #category : #testing }
BrTextEditorParagraphSegmentTextPiece >> isText [
	^ true
]
