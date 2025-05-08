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
	computedPatternItems := aCollection
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
		self visibleTextEnd: aSegment textEnd ]
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
	"Return a text in which a pattern is searched for"

	<return: #BlText>
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
