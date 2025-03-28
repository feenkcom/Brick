Class {
	#name : #BrTextEditorLineSegment,
	#superclass : #BrTextEditorSegment,
	#category : #'Brick-Editor-LineBased-Model'
}

{ #category : #accessing }
BrTextEditorLineSegment >> segmentType [
	"Return a type of this segment responsible for creation
	of segment holder and also used as a key for caching purposes"
	<return: #BrEditorSegmentType>
	
	^ BrTextEditorLineSegmentType uniqueInstance
]

{ #category : #'pieces - computation' }
BrTextEditorLineSegment >> splitterClass [
	^ BrTextEditorLineSegmentSplitter
]
