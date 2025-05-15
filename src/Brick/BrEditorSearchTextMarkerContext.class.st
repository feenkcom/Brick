"
I hold basic input and output information of {{gtMethod:BrEditorSearchTextMarker >> #mark:}} execution.
Input information:
- {{gtMethod:BrEditorSearchTextMarkerContext>>#textSource | label=#selector}} with its {{gtMethod: BrEditorSearchTextMarkerContext>>#text | label=#selector}} and {{gtMethod:BrEditorSearchTextMarkerContext>>#visibleText | label=#selector}}, 
- {{gtMethod:BrEditorSearchTextMarkerContext>>#pattern | label=#selector}}.
Output information:
- {{gtMethod:BrEditorSearchTextMarkerContext>>#patternItems | label=#selector}},
- {{gtMethod: BrEditorSearchTextMarkerContext>>#selectedItem | label=#selector}}, 
- {{gtMethod: BrEditorSearchTextMarkerContext>>#selectedIndex | label=#selector}}, 
- {{gtMethod:BrEditorSearchTextMarkerContext>>#selectedLine | label=#selector}},
- {{gtMethod:BrEditorSearchTextMarkerContext>>#selectedRange | label=#selector}},
- {{gtMethod:BrEditorSearchTextMarkerContext>>#selectedStartPosition | label=#selector}},
- {{gtMethod:BrEditorSearchTextMarkerContext>>#selectedStopPosition | label=#selector}}. 
"
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
		'patternItems',
		'selectedItem'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #'api - result' }
BrEditorSearchTextMarkerContext >> computeNextItem [
	<return: #BrEditorSearchTextItem>
	| aNewIndex aNewItem anIndex aCurrentItem |
	aCurrentItem := self selectedItem.
	aCurrentItem ifNil: [ self ].
	anIndex := self patternItems identityIndexOf: aCurrentItem ifAbsent: [ self ].
	aNewIndex := anIndex + 1.
	aNewIndex > self patternItems size ifTrue: [ aNewIndex := 1 ].
	aNewItem := self patternItems at: aNewIndex.
	aCurrentItem isSelected: false.
	aNewItem isSelected: true.
	selectedItem := aNewItem.
	^ aNewItem
]

{ #category : #'api - result' }
BrEditorSearchTextMarkerContext >> computePreviousItem [
	<return: #BrEditorSearchTextItem>
	| aNewIndex aNewItem anIndex aCurrentItem |
	aCurrentItem := self selectedItem.
	aCurrentItem ifNil: [ self ].
	anIndex := self patternItems identityIndexOf: aCurrentItem ifAbsent: [ self ].
	aNewIndex := anIndex - 1.
	aNewIndex < 1 ifTrue: [ aNewIndex := self patternItems size ].
	aNewItem := self patternItems at: aNewIndex.
	aCurrentItem isSelected: false.
	aNewItem isSelected: true.
	selectedItem := aNewItem.
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

{ #category : #'api - initialization' }
BrEditorSearchTextMarkerContext >> fromText: aText visibleText: aVisibleText [
	textSource := BrEditorSearchTextBasicSource new
			text: aText;
			visibleText: aVisibleText
]

{ #category : #'api - testing' }
BrEditorSearchTextMarkerContext >> hasText [
	^ self textSource hasText
]

{ #category : #'api - testing' }
BrEditorSearchTextMarkerContext >> hasVisibleText [
	^ self textSource hasVisibleText
]

{ #category : #'api - result' }
BrEditorSearchTextMarkerContext >> isSelectedItem: anItem index: anIndex [
	| aSelectedItem |
	aSelectedItem := self selectedItem.
	aSelectedItem ifNil: [ ^ self selectedIndex = anIndex ].

	^ aSelectedItem absoluteStartIndex = anItem absoluteStartIndex
		and: [ aSelectedItem absoluteStopIndex = anItem absoluteStopIndex ]
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

{ #category : #'api - result' }
BrEditorSearchTextMarkerContext >> patternItems [
	<return: #Collection of: #BrEditorSearchTextItem>
	^ patternItems ifNil: [ #() ]
]

{ #category : #'api - result' }
BrEditorSearchTextMarkerContext >> patternItems: aCollection [
	patternItems := aCollection.
	selectedItem := nil.
]

{ #category : #'api - result' }
BrEditorSearchTextMarkerContext >> selectedIndex [
	"Return an index among #patternItems"

	<return: #Integer>
	^ self selectedItem ifNotNil: #index ifNil: [ 1 ]
]

{ #category : #'api - result' }
BrEditorSearchTextMarkerContext >> selectedItem [
	<return: #BrEditorSearchTextItem or: nil>
	self patternItems ifEmpty: [ ^ nil ].
	selectedItem ifNotNil: [ ^ selectedItem ].
	^ self patternItems
		detect: [ :eachItem | eachItem isSelected ]
		ifFound: [ :anItem | selectedItem := anItem ]
		ifNone: [ nil ]
]

{ #category : #'api - result' }
BrEditorSearchTextMarkerContext >> selectedLine [
	"Return line number for a given selected item"

	<return: #Integer>
	^ (self text from: 1 to: self selectedItem absoluteStartIndex) lineCount
]

{ #category : #'api - result' }
BrEditorSearchTextMarkerContext >> selectedRange [
	"Return character start and stop positions for a given selected item"

	<return: #Interval>
	^ self selectedItem absoluteStartIndex to: self selectedItem absoluteStopIndex
]

{ #category : #'api - result' }
BrEditorSearchTextMarkerContext >> selectedStartPosition [
	"Return a character start position for a given selected item"

	<return: #Integer>
	^ self selectedItem absoluteStartIndex
]

{ #category : #'api - result' }
BrEditorSearchTextMarkerContext >> selectedStopPosition [
	"Return a character stop position for a given selected item"

	<return: #Integer>
	^ self selectedItem absoluteStopIndex
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
