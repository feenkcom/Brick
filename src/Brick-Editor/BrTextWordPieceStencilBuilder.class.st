Class {
	#name : #BrTextWordPieceStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'wordPadding',
		'wordMargin',
		'segmentPiece',
		'shouldUsePool'
	],
	#classInstVars : [
		'TextPiecePool'
	],
	#category : #'Brick-Editor-UI - Stencils'
}

{ #category : #'class initialization' }
BrTextWordPieceStencilBuilder class >> cleanUp [
	self initialize
]

{ #category : #initialization }
BrTextWordPieceStencilBuilder class >> initialize [
	TextPiecePool := BlObjectPool new: 1000
]

{ #category : #accessing }
BrTextWordPieceStencilBuilder class >> pool [
	^TextPiecePool 
]

{ #category : #'private - pool' }
BrTextWordPieceStencilBuilder >> acquire [
	<return: #BrTextElementWithCursors or: nil>
	
	shouldUsePool
		ifFalse: [ ^ nil ].
	
	^ self pool acquire
]

{ #category : #'api - instantiation' }
BrTextWordPieceStencilBuilder >> buildDefault [
	| aTextElement |
	
	aTextElement := BlFrameTelemetry
		time: [ 'Try to acquire a word element from a pool' ]
		during: [ self acquire ].
	
	aTextElement := (aTextElement ifNil: [
		BlFrameTelemetry
			time: [ 'Create new word element' ]
			during: [ self createWordElement ] ]).

	BlFrameTelemetry
			time: [ 'Assign segment piece to the word element' ]
			during: [ aTextElement segmentPiece: self segmentPiece ].
			
	aTextElement
		padding: self wordPadding;
		margin: self wordMargin.
		
	aTextElement userData at: #editorPool put: self pool.

	^ aTextElement
]

{ #category : #'api - instantiation' }
BrTextWordPieceStencilBuilder >> createWordElement [
	<return: #BrTextElementWithCursors>

	^ self subclassResponsibility
]

{ #category : #initialization }
BrTextWordPieceStencilBuilder >> initialize [
	super initialize.
	
	self reset
]

{ #category : #'api - instantiation' }
BrTextWordPieceStencilBuilder >> paramsOn: aStencilExecutor [
	aStencilExecutor push: self segmentPiece
]

{ #category : #'private - pool' }
BrTextWordPieceStencilBuilder >> pool [
	^ self class pool
]

{ #category : #'private - pool' }
BrTextWordPieceStencilBuilder >> recycle: aPieceElement [
	aPieceElement removeFromParent.
	aPieceElement removeCursors.
	aPieceElement selectNone.
	aPieceElement resetDefaultFontSize.

	"otherwise attributes may not be garbage collected
	see https://github.com/feenkcom/gtoolkit/issues/537"
	aPieceElement removeSegmentPiece.

	aPieceElement userData
		at: #editorPool
		ifPresent: [ :aPool | aPool == self pool ifTrue: [ self pool release: aPieceElement  ] ]
]

{ #category : #initialization }
BrTextWordPieceStencilBuilder >> reset [
	wordPadding := BlInsets empty.
	wordMargin := BlInsets empty.
	segmentPiece := nil.
	shouldUsePool := true
]

{ #category : #accessing }
BrTextWordPieceStencilBuilder >> segmentPiece [
	<return: #TBrTextEditorTextualPiece>

	^ segmentPiece
]

{ #category : #accessing }
BrTextWordPieceStencilBuilder >> segmentPiece: aTBrTextEditorTextualPiece [
	segmentPiece := aTBrTextEditorTextualPiece
]

{ #category : #accessing }
BrTextWordPieceStencilBuilder >> shouldUsePool [
	^ shouldUsePool
]

{ #category : #accessing }
BrTextWordPieceStencilBuilder >> shouldUsePool: aBoolean [
	shouldUsePool := aBoolean
]

{ #category : #accessing }
BrTextWordPieceStencilBuilder >> wordMargin [
	<return: #BlInsets>

	^ wordMargin
]

{ #category : #accessing }
BrTextWordPieceStencilBuilder >> wordMargin: aBlInsets [
	wordMargin := aBlInsets
]

{ #category : #accessing }
BrTextWordPieceStencilBuilder >> wordPadding [
	<return: #BlInsets>

	^ wordPadding
]

{ #category : #accessing }
BrTextWordPieceStencilBuilder >> wordPadding: aBlInsets [
	wordPadding := aBlInsets
]
