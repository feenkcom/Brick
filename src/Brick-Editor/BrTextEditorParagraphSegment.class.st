Class {
	#name : #BrTextEditorParagraphSegment,
	#superclass : #BrTextEditorSegment,
	#category : #'Brick-Editor-Model - Segment-Text-Paragraph'
}

{ #category : #accessing }
BrTextEditorParagraphSegment >> segmentType [
	"Return a type of this segment responsible for creation
	of segment holder and also used as a key for caching purposes"
	<return: #BrEditorSegmentType>
	
	^ BrTextEditorParagraphSegmentType uniqueInstance
]

{ #category : #'pieces - computation' }
BrTextEditorParagraphSegment >> splitterClass [
	^ BrTextEditorSegmentSplitter
]
