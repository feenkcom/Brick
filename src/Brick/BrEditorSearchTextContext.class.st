Class {
	#name : #BrEditorSearchTextContext,
	#superclass : #Object,
	#instVars : [
		'editorElement',
		'text',
		'visibleTextStart',
		'visibleTextEnd',
		'visibleText',
		'pattern',
		'currentIndex',
		'nextGenerationText',
		'computedPatternItems',
		'element',
		'computedCurrentPatternItem'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #accessing }
BrEditorSearchTextContext >> computeNextPatternItem [
	| aNewIndex aNewItem anIndex aCurrentItem |
	aCurrentItem := self computedCurrentPatternItem.
	aCurrentItem ifNil: [ self ].
	anIndex := self computedPatternItems
			identityIndexOf: aCurrentItem
			ifAbsent: [ self ].
	aNewIndex := anIndex + 1.
	aNewIndex > self computedPatternItems size ifTrue: [ aNewIndex := 1 ].
	aNewItem := self computedPatternItems at: aNewIndex.
	aCurrentItem isSelected: false.
	aNewItem isSelected: true.
	computedCurrentPatternItem := aNewItem.
	^ aNewItem
]

{ #category : #accessing }
BrEditorSearchTextContext >> computePreviousPatternItem [
	| aNewIndex aNewItem anIndex aCurrentItem |
	aCurrentItem := self computedCurrentPatternItem.
	aCurrentItem ifNil: [ self ].
	anIndex := self computedPatternItems
			identityIndexOf: aCurrentItem
			ifAbsent: [ self ].
	aNewIndex := anIndex - 1.
	aNewIndex < 1 ifTrue: [ aNewIndex := self computedPatternItems size ].
	aNewItem := self computedPatternItems at: aNewIndex.
	aCurrentItem isSelected: false.
	aNewItem isSelected: true.
	computedCurrentPatternItem := aNewItem.
	^ aNewItem
]

{ #category : #'api - pattern' }
BrEditorSearchTextContext >> computedCurrentPatternItem [
	<return: #BrEditorSearchTextPatternItem or: nil>
	self computedPatternItems ifNil: [ ^ nil ].
	computedCurrentPatternItem ifNotNil: [ ^ computedCurrentPatternItem ].
	^ self computedPatternItems
		detect: [ :eachItem | eachItem isSelected ]
		ifFound: [ :anItem | computedCurrentPatternItem := anItem ]
		ifNone: [ nil ]
]

{ #category : #'api - pattern' }
BrEditorSearchTextContext >> computedPatternItems [
	<return: #Collection of: #BrEditorSearchTextPatternItem>
	^ computedPatternItems
]

{ #category : #'api - pattern' }
BrEditorSearchTextContext >> computedPatternItems: aCollection [
	computedPatternItems := aCollection.
	computedCurrentPatternItem := nil.
]

{ #category : #'api - accessing' }
BrEditorSearchTextContext >> currentIndex [
	<return: #Integer>
	^ currentIndex ifNil: [ currentIndex := 1 ]
]

{ #category : #'api - accessing' }
BrEditorSearchTextContext >> currentIndex: anInteger [
	currentIndex := anInteger
]

{ #category : #'api - initialization' }
BrEditorSearchTextContext >> editor: aBrEditor [ 
	editorElement := aBrEditor
]

{ #category : #'api - accessing' }
BrEditorSearchTextContext >> editorElement [
	^ editorElement
]

{ #category : #'api - accessing' }
BrEditorSearchTextContext >> editorElementDo: aBlock [
	editorElement ifNotNil: aBlock
]

{ #category : #'api - accessing' }
BrEditorSearchTextContext >> element [
	"Return an element for which a computation happens, e.g., search text dialog"

	^ element ifNil: [ editorElement ]
]

{ #category : #'api - accessing' }
BrEditorSearchTextContext >> element: anElement [
	"Set an element for which a computation happens, e.g., search text dialog"

	element := anElement
]

{ #category : #'api - initialization' }
BrEditorSearchTextContext >> fromEditor: aBrEditor [
	self editor: aBrEditor.
	self text: aBrEditor editor text.
	aBrEditor firstVisibleSegment ifNotNil: [ :aSegment | 
		self visibleTextStart: aSegment textStart ].
	aBrEditor lastVisibleSegment ifNotNil: [ :aSegment | 
		self visibleTextEnd: aSegment textEnd ].
	self hasVisibleText ifTrue: [ self visibleText ].
]

{ #category : #'api - testing' }
BrEditorSearchTextContext >> hasText [
	^ text isNotNil
]

{ #category : #'api - testing' }
BrEditorSearchTextContext >> hasVisibleText [
	^ self hasText and: [ visibleTextStart isNotNil and: [ visibleTextEnd isNotNil ] ]
]

{ #category : #'api - pattern' }
BrEditorSearchTextContext >> isCurrentPatternItem: aPatternItem index: anIndex [
	| anItem |
	anItem := self computedCurrentPatternItem.
	anItem ifNil: [ ^ self currentIndex = anIndex ].

	^ anItem absoluteStartIndex = aPatternItem absoluteStartIndex
		and: [ anItem absoluteStopIndex = aPatternItem absoluteStopIndex ]
]

{ #category : #accessing }
BrEditorSearchTextContext >> nextGenerationText [
	^ nextGenerationText ifNil: [ nextGenerationText := self text copy nextGeneration ].
]

{ #category : #'api - pattern' }
BrEditorSearchTextContext >> pattern [
	<return: #BrEditorSearchTextPattern>
	^ pattern
]

{ #category : #'api - pattern' }
BrEditorSearchTextContext >> pattern: aPattern [
	pattern := aPattern
]

{ #category : #'api - pattern' }
BrEditorSearchTextContext >> subtext: aBlText [
	self pattern: (BrEditorSearchTextSubstringPattern new text: aBlText).
]

{ #category : #'api - accessing' }
BrEditorSearchTextContext >> text [
	"Return a text in which a pattern is searched for.
	Note that this text is shared with editor, so it can be accessed only from a UI process."

	<return: #BlText>
	self editorElementDo: [ :anEditor | anEditor editor assertUIProcess ].
	^ text
]

{ #category : #'api - initialization' }
BrEditorSearchTextContext >> text: aBlText [
	text := aBlText
]

{ #category : #'api - accessing' }
BrEditorSearchTextContext >> visibleText [
	"Return a visible part of the text in which a pattern is searched for"

	<return: #BlText>
	self editorElementDo: [ :anEditor | anEditor editor assertUIProcess ].
	
	^ visibleText ifNil: [
		visibleText := self text from: visibleTextStart to: visibleTextEnd ]
]

{ #category : #'api - initialization' }
BrEditorSearchTextContext >> visibleTextEnd: anIndex [
	visibleTextEnd := anIndex
]

{ #category : #'api - initialization' }
BrEditorSearchTextContext >> visibleTextStart: anInteger [
	visibleTextStart := anInteger max: 1
]
