Class {
	#name : #BrTextEditorLineSegmentTextPiece,
	#superclass : #BrTextEditorLineSegmentPiece,
	#category : #'Brick-Editor-Model - Segment-Text-Line'
}

{ #category : #comparing }
BrTextEditorLineSegmentTextPiece >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject class == self class)
		ifFalse: [ ^ false ].
	
	^ anotherObject text = self text
]

{ #category : #'instance creation' }
BrTextEditorLineSegmentTextPiece >> createElement: anEditorElement [
	<return: #BlElement>
	^ self createTextElement: anEditorElement
]

{ #category : #comparing }
BrTextEditorLineSegmentTextPiece >> hash [
	^ self class hash bitXor: self text hash
]

{ #category : #testing }
BrTextEditorLineSegmentTextPiece >> isText [
	^ true
]

{ #category : #'instance creation' }
BrTextEditorLineSegmentTextPiece >> onRecycled: aPieceElement in: anEditorElement [
	anEditorElement editor segmentBuilder wordStencilBuilder recycle: aPieceElement
]
