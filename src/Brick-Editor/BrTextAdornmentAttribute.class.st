"
nil
"
Class {
	#name : #BrTextAdornmentAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'renderingStrategy',
		'cache',
		'alignmentMode',
		'placeholderAlignment'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #accessing }
BrTextAdornmentAttribute >> affect: aTBrTextEditorTextualPiece in: anEditorElement [
	"Return an element that should affect (either append or replace) a provided text piece"
	<return: #SequenceableCollection of: #BlElement>
	
	^ self cache ifAbsentPut: [ self renderingStrategy affect: aTBrTextEditorTextualPiece in: anEditorElement ]
]

{ #category : #accessing }
BrTextAdornmentAttribute >> beAppend [
	alignmentMode := #append
]

{ #category : #accessing }
BrTextAdornmentAttribute >> beOverlay [
	alignmentMode := #overlay
]

{ #category : #accessing }
BrTextAdornmentAttribute >> beReplace [
	alignmentMode := #replace
]

{ #category : #accessing }
BrTextAdornmentAttribute >> beSync [
	self renderingStrategy: BrTextAdornmentAttributeSyncRenderingStrategy new.
]

{ #category : #'api - cache' }
BrTextAdornmentAttribute >> cache [
	<return: #BrTextAdornmentAttributeCache>

	^ cache
]

{ #category : #'api - cache' }
BrTextAdornmentAttribute >> cache: aBrTextAdornmentAttributeCache [
	cache := aBrTextAdornmentAttributeCache
]

{ #category : #accessing }
BrTextAdornmentAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	"Return an element that should affect (either append or replace) a provided text piece"
	<return: #SequenceableCollection of: #BlElement>

	^ self subclassResponsibility
]

{ #category : #initialization }
BrTextAdornmentAttribute >> initialize [
	super initialize.

	self beReplace.
	self renderingStrategy: BrTextAdornmentAttributeSyncRenderingStrategy new.
	cache := BrTextAdornmentAttributeNoCache uniqueInstance
]

{ #category : #initialization }
BrTextAdornmentAttribute >> initializeLazyElement: aBlLazyElement [
	"Subclasses can initialize the element"
]

{ #category : #testing }
BrTextAdornmentAttribute >> isAdornment [
	"Return true if attribute influences text structure, for examples if it replaces one or more characters
	with any amount of other arbitrary items, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #testing }
BrTextAdornmentAttribute >> isFocusable [
	"Return true if an element (but not its children) created by the adornment attribute can be focused"
	<return: #Boolean>

	^ false
]

{ #category : #testing }
BrTextAdornmentAttribute >> isStyle [
	"I am not a text style related attribute"

	^ false
]

{ #category : #testing }
BrTextAdornmentAttribute >> mayHaveExternalReferences [
	"Answer if this attribute can have references to some external objects like AST nodes or computation results"

	^ true
]

{ #category : #private }
BrTextAdornmentAttribute >> newPooledCache [
	^ BrTextAdornmentAttributePooledCache new
]

{ #category : #accessing }
BrTextAdornmentAttribute >> placeholderAlignment [
	^ placeholderAlignment
]

{ #category : #accessing }
BrTextAdornmentAttribute >> placeholderAlignment: aSymbol [
	placeholderAlignment := aSymbol
]

{ #category : #accessing }
BrTextAdornmentAttribute >> renderingStrategy [
	<return: #BrTextAdornmentAttributeRenderingStrategy>
	^ renderingStrategy
]

{ #category : #accessing }
BrTextAdornmentAttribute >> renderingStrategy: aBrTextAdornmentAttributeRenderingStrategy [
	self 
		assert: [ aBrTextAdornmentAttributeRenderingStrategy isNotNil ] 
		description: [ 'Text attribute rendering strategy must be non-nil' ].
	aBrTextAdornmentAttributeRenderingStrategy attribute: self.
	renderingStrategy := aBrTextAdornmentAttributeRenderingStrategy
]

{ #category : #testing }
BrTextAdornmentAttribute >> shouldAppend [
	^ alignmentMode == #append
]

{ #category : #testing }
BrTextAdornmentAttribute >> shouldOverlay [
	^ alignmentMode == #overlay
]

{ #category : #testing }
BrTextAdornmentAttribute >> shouldReplace [
	^ alignmentMode == #replace
]

{ #category : #printing }
BrTextAdornmentAttribute >> storeOn: aStream [
	super storeOn: aStream.
	
	aStream nextPutAll: ' '.
	aStream nextPutAll: (self shouldAppend
		ifTrue: [ #beAppend ]
		ifFalse: [ #beReplace ]) asString
]

{ #category : #comparing }
BrTextAdornmentAttribute >> type [
	^ self
]

{ #category : #'api - cache' }
BrTextAdornmentAttribute >> withCache: aDictionary key: aKey [
	self cache: (aDictionary
		at: aKey
		ifAbsentPut: [ self newPooledCache ])
]

{ #category : #'api - cache' }
BrTextAdornmentAttribute >> withCache: anObject selector: aSelectorSymbol [
	(anObject perform: aSelectorSymbol withArguments: #())
		ifNil: [
			| aNewCache |
			
			aNewCache := self newPooledCache.
			anObject perform: aSelectorSymbol asMutator withArguments: { aNewCache }.
			self cache: aNewCache ]
		ifNotNil: [ :aCache | self cache: aCache ]
]

{ #category : #'api - cache' }
BrTextAdornmentAttribute >> withCacheGet: aGetBlock set: aSetBlock [
	aGetBlock value
		ifNil: [
			| aNewCache |
			
			aNewCache := self newPooledCache.
			aSetBlock value: aNewCache.
			self cache: aNewCache ]
		ifNotNil: [ :aCache | self cache: aCache ]
]

{ #category : #'api - cache' }
BrTextAdornmentAttribute >> withoutCache [
	self cache: BrTextAdornmentAttributeNoCache uniqueInstance
]
