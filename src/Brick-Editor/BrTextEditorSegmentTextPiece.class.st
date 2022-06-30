Class {
	#name : #BrTextEditorSegmentTextPiece,
	#superclass : #BrTextEditorLineSegmentPiece,
	#category : #'Brick-Editor-Model - Segment-Text-Line'
}

{ #category : #comparing }
BrTextEditorSegmentTextPiece >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject class == self class)
		ifFalse: [ ^ false ].
	
	^ anotherObject text = self text
]

{ #category : #'instance creation' }
BrTextEditorSegmentTextPiece >> createElement: anEditorElement [
	<return: #BlElement>
	| anElement |
	anElement := (anEditorElement editor segmentBuilder wordStencilBuilder
			wordPadding: self wordPadding;
			wordMargin: self wordMargin;
			segmentPiece: self;
			shouldUsePool: false) asElement.
	anElement userData removeKey: #brickEditorAdornment ifAbsent: [  ].
	^ anElement
]

{ #category : #comparing }
BrTextEditorSegmentTextPiece >> hash [
	^ self class hash bitXor: self text hash
]

{ #category : #testing }
BrTextEditorSegmentTextPiece >> isText [
	^ true
]

{ #category : #'instance creation' }
BrTextEditorSegmentTextPiece >> onRecycled: aPieceElement in: anEditorElement [
	anEditorElement editor segmentBuilder wordStencilBuilder recycle: aPieceElement
]
