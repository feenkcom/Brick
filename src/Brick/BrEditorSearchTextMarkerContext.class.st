Class {
	#name : #BrEditorSearchTextMarkerContext,
	#superclass : #Object,
	#instVars : [
		'text',
		'visibleText',
		'pattern',
		'nextGenerationText',
		'element',
		'textSource',
		'selectedIndex',
		'selectedPatternItem',
		'patternItems'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #'api - pattern' }
BrEditorSearchTextMarkerContext >> computeNextPatternItem [
	| aNewIndex aNewItem anIndex aCurrentItem |
	aCurrentItem := self selectedPatternItem.
	aCurrentItem ifNil: [ self ].
	anIndex := self patternItems
			identityIndexOf: aCurrentItem
			ifAbsent: [ self ].
	aNewIndex := anIndex + 1.
	aNewIndex > self patternItems size ifTrue: [ aNewIndex := 1 ].
	aNewItem := self patternItems at: aNewIndex.
	aCurrentItem isSelected: false.
	aNewItem isSelected: true.
	selectedPatternItem := aNewItem.
	selectedIndex := aNewIndex.
	^ aNewItem
]

{ #category : #'api - pattern' }
BrEditorSearchTextMarkerContext >> computePreviousPatternItem [
	| aNewIndex aNewItem anIndex aCurrentItem |
	aCurrentItem := self selectedPatternItem.
	aCurrentItem ifNil: [ self ].
	anIndex := self patternItems
			identityIndexOf: aCurrentItem
			ifAbsent: [ self ].
	aNewIndex := anIndex - 1.
	aNewIndex < 1 ifTrue: [ aNewIndex := self patternItems size ].
	aNewItem := self patternItems at: aNewIndex.
	aCurrentItem isSelected: false.
	aNewItem isSelected: true.
	selectedPatternItem := aNewItem.
	selectedIndex := aNewIndex.
	^ aNewItem
]

{ #category : #'api - accessing' }
BrEditorSearchTextMarkerContext >> editorModelText [
	"Return a current editor model text.
	Note that the code must be called from a UI process."

	<return: #BlText or: nil>
	^ self textSource text
]

{ #category : #'api - accessing' }
BrEditorSearchTextMarkerContext >> editorModelTextDo: aBlock [
	self editorModelText ifNotNil: aBlock
]

{ #category : #'api - accessing' }
BrEditorSearchTextMarkerContext >> element [
	"Return an element for which a computation happens, e.g., search text dialog"

	^ element ifNil: [ element := self textSource element ]
]

{ #category : #'api - accessing' }
BrEditorSearchTextMarkerContext >> element: anElement [
	"Set an element for which a computation happens, e.g., search text dialog"

	element := anElement
]

{ #category : #'api - initialization' }
BrEditorSearchTextMarkerContext >> fromEditor: aBrEditor [
	self textSource: (BrEditorSearchTextEditorElementSource new editorElement: aBrEditor).
]

{ #category : #'api - testing' }
BrEditorSearchTextMarkerContext >> hasText [
	^ self textSource hasText
]

{ #category : #'api - testing' }
BrEditorSearchTextMarkerContext >> hasVisibleText [
	^ self textSource hasVisibleText
]

{ #category : #'api - pattern' }
BrEditorSearchTextMarkerContext >> isCurrentPatternItem: aPatternItem index: anIndex [
	| anItem |
	anItem := self selectedPatternItem.
	anItem ifNil: [ ^ self selectedIndex = anIndex ].

	^ anItem absoluteStartIndex = aPatternItem absoluteStartIndex
		and: [ anItem absoluteStopIndex = aPatternItem absoluteStopIndex ]
]

{ #category : #'api - accessing' }
BrEditorSearchTextMarkerContext >> nextGenerationText [
	^ nextGenerationText ifNil: [ nextGenerationText := self text nextGeneration ].
]

{ #category : #'api - pattern' }
BrEditorSearchTextMarkerContext >> pattern [
	<return: #BrEditorSearchTextPattern>
	^ pattern
]

{ #category : #'api - pattern' }
BrEditorSearchTextMarkerContext >> pattern: aPattern [
	pattern := aPattern
]

{ #category : #'api - pattern' }
BrEditorSearchTextMarkerContext >> patternItems [
	<return: #Collection of: #BrEditorSearchTextPatternItem>
	^ patternItems
]

{ #category : #'api - pattern' }
BrEditorSearchTextMarkerContext >> patternItems: aCollection [
	patternItems := aCollection.
	selectedPatternItem := nil.
]

{ #category : #'api - pattern' }
BrEditorSearchTextMarkerContext >> selectedIndex [
	<return: #Integer>
	^ selectedIndex ifNil: [ selectedIndex := 1 ]
]

{ #category : #'api - pattern' }
BrEditorSearchTextMarkerContext >> selectedLine [
	<return: #Integer>
	^ (self text from: 1 to: self selectedPatternItem absoluteStartIndex) lineCount
]

{ #category : #'api - pattern' }
BrEditorSearchTextMarkerContext >> selectedPatternItem [
	<return: #BrEditorSearchTextPatternItem or: nil>
	self patternItems ifNil: [ ^ nil ].
	selectedPatternItem ifNotNil: [ ^ selectedPatternItem ].
	^ self patternItems
		detect: [ :eachItem | eachItem isSelected ]
		ifFound: [ :anItem |
			(self patternItems identityIndexOf: anItem ifAbsent: [ nil ])
				ifNotNil: [ :anIndex | selectedIndex := anIndex ].
			selectedPatternItem := anItem ]
		ifNone: [ nil ]
]

{ #category : #'api - pattern' }
BrEditorSearchTextMarkerContext >> selectedStartPosition [
	<return: #Integer>
	^ self selectedPatternItem absoluteStartIndex
]

{ #category : #'api - pattern' }
BrEditorSearchTextMarkerContext >> subtext: aBlText [
	self pattern: (BrEditorSearchTextSubstringPattern new text: aBlText).
]

{ #category : #'api - accessing' }
BrEditorSearchTextMarkerContext >> text [
	"Return a text in which a pattern is searched for.
	Note that this text is shared with editor, so it can be accessed only from a UI process."

	<return: #BlText>
	^ text ifNil: [ text := self textSource text ]
]

{ #category : #'api - accessing' }
BrEditorSearchTextMarkerContext >> textSource [
	<return: #BrEditorSearchTextSource>
	^ textSource
]

{ #category : #'api - accessing' }
BrEditorSearchTextMarkerContext >> textSource: aTextSource [
	textSource := aTextSource
]

{ #category : #'api - accessing' }
BrEditorSearchTextMarkerContext >> visibleText [
	"Return a visible part of the text in which a pattern is searched for.
	Note that this text is shared with editor, so it can be accessed only from a UI process."

	<return: #BlText>
	^ visibleText ifNil: [ visibleText := self textSource visibleText ]
]
