Class {
	#name : #BrEditorSearchTextWithScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Brick-Examples-Editor - Search'
}

{ #category : #support }
BrEditorSearchTextWithScripterExamples >> allMarksFromScripter: aScripter [
	| allPreviousMarks |
	aScripter do
		label: 'Get all marks with positions';
		block: [ allPreviousMarks := self allMarksInText: aScripter element text ];
		play.
	^ allPreviousMarks
]

{ #category : #support }
BrEditorSearchTextWithScripterExamples >> allMarksInText: aText [
	^ Array
		streamContents: [ :aStream | 
			aText
				findAttributesSuchThat: [ :eachAttribute | eachAttribute class = BrEditorSearchTextMark ]
				indicesDo: [ :aStart :aStop :anAttribute  | aStream nextPut: { aStart. aStop. anAttribute } ] ]
]

{ #category : #'examples - marker' }
BrEditorSearchTextWithScripterExamples >> basicMarker [
	<gtExample>
	| aMarker |
	aMarker := BrEditorSearchTextMarker new
			computation: BrEditorSearchTextAsyncFutureComputation newDefault.

	^ aMarker
]

{ #category : #'examples - editor' }
BrEditorSearchTextWithScripterExamples >> editor [
	<gtExample>
	| anEditor aScripter |
	anEditor := BrEditor new
			border: (BlBorder paint: Color gray);
			aptitude: BrGlamorousCodeEditorAptitude new;
			text: self simple500Lines;
			requestFocus.

	aScripter := BlScripter new element: anEditor.

	aScripter do
		label: 'Scroll text';
		block: [ :anElement | anElement scrollToPosition: 50 ];
		play.

	aScripter assert
		label: 'Visible text begins with "41."';
		satisfies: [ :anElement | anElement visibleText asString trimLeft beginsWith: '41.' ]
			description: [ :anElement | 'The text begins with: "{1}"' format: {anElement visibleText asString first: 50} ];
		play.

	^ aScripter
]

{ #category : #'examples - editor' }
BrEditorSearchTextWithScripterExamples >> editorElementWithSearchTextAptitude [
	<gtExample>
	^ BrEditor new
		border: (BlBorder paint: Color gray);
		aptitude: BrGlamorousCodeEditorAptitude new;
		text: self simple500Lines;
		addAptitude: BrGlamorousEditorSearchTextAptitude new;
		requestFocus
]

{ #category : #'examples - editor' }
BrEditorSearchTextWithScripterExamples >> editorOpenSearchDialog [
	<gtExample>
	| aScripter |
	aScripter := self editorWithSearchTextAptitude.

	aScripter shortcut
		label: 'Open search text dialog';
		combination: BlKeyCombination primaryF;
		play.

	aScripter menuStep
		assertMenuContainerExist;
		assertMenuContainerHasFocus;
		onPopover;
		play.
		
	aScripter assert
		label: 'Search text element exists';
		exists;
		onPopover;
		// BrEditorSearchTextElement;
		play.
		
	aScripter assert
		label: 'Search text element input editor is focused';
		satisfies: [ :aBrEditor | aBrEditor isFocused ];
		onPopover;
		// BrEditorSearchTextElement;
		// BrEditor;
		play.

	^ aScripter
]

{ #category : #'examples - editor' }
BrEditorSearchTextWithScripterExamples >> editorSearchAB [
	<gtExample>
	| aScripter allMarks allSelectedMarks |
	aScripter := self editorOpenSearchDialog.

	aScripter type
		label: 'Search "a b"';
		text: 'a b';
		play.

	aScripter menuStep
		assertMenuContainerExist;
		assertMenuContainerHasFocus;
		onPopover;
		play.

	aScripter assert
		label: 'Search text element exists';
		exists;
		onPopover;
		// BrEditorSearchTextElement;
		play.

	allMarks := self allMarksFromScripter: aScripter.
	self assert: allMarks size equals: 2000.

	allSelectedMarks := allMarks
			select: [ :anArray | anArray third isSelected ]
			thenCollect: #third.
	self assert: allSelectedMarks size equals: 1.
	self assert: allSelectedMarks first index equals: 161.

	^ aScripter
]

{ #category : #'examples - editor' }
BrEditorSearchTextWithScripterExamples >> editorSearchNextAB [
	<gtExample>
	| aScripter allPreviousMarks aPreviousMark allMarks allSelectedMarks |
	aScripter := self editorSearchAB.
	allPreviousMarks := self allMarksFromScripter: aScripter.
	aPreviousMark := (allPreviousMarks
			detect: [ :anArray | anArray third isSelected ]) third.

	aScripter shortcut
		label: 'Search previous "a b"';
		combination: BlKeyCombination return;
		onPopover;
		// BrEditorSearchTextElement;
		// BrEditor;
		play.

	aScripter assert
		label: 'Search text element exists';
		exists;
		onPopover;
		// BrEditorSearchTextElement;
		play.

	allMarks := self allMarksFromScripter: aScripter.
	self assert: allMarks size equals: 2000.

	allSelectedMarks := allMarks
			select: [ :anArray | anArray third isSelected ]
			thenCollect: #third.
	self assert: allSelectedMarks size equals: 1.
	self assert: allSelectedMarks first index equals: 162.

	^ aScripter
]

{ #category : #'examples - editor' }
BrEditorSearchTextWithScripterExamples >> editorSearchPreviousAB [
	<gtExample>
	| aScripter allPreviousMarks aPreviousMark allMarks allSelectedMarks |
	aScripter := self editorSearchAB.
	allPreviousMarks := self allMarksFromScripter: aScripter.
	aPreviousMark := allPreviousMarks
			detect: [ :anArray | anArray third isSelected ].

	aScripter shortcut
		label: 'Search previous "a b"';
		combination: BlKeyCombination primaryReturn;
		onPopover;
		// BrEditorSearchTextElement;
		// BrEditor;
		play.

	aScripter menuStep
		assertMenuContainerExist;
		assertMenuContainerHasFocus;
		onPopover;
		play.

	aScripter assert
		label: 'Search text element exists';
		exists;
		onPopover;
		// BrEditorSearchTextElement;
		play.

	allMarks := self allMarksFromScripter: aScripter.
	self assert: allMarks size equals: 2000.

	allSelectedMarks := allMarks
			select: [ :anArray | anArray third isSelected ]
			thenCollect: #third.
	self assert: allSelectedMarks size equals: 1.
	self assert: allSelectedMarks first index equals: 160.

	^ aScripter
]

{ #category : #'examples - editor' }
BrEditorSearchTextWithScripterExamples >> editorSearchPreviousAB_endByEscape [
	<gtExample>
	| aScripter allMarks aMarkArray |
	aScripter := self editorSearchPreviousAB.
	allMarks := self allMarksFromScripter: aScripter.
	aMarkArray := allMarks detect: [ :anArray | anArray third isSelected ].

	aScripter shortcut
		label: 'End search';
		combination: BlKeyCombination escape;
		onPopover;
		// BrEditorSearchTextElement;
		// BrEditor;
		play.

	aScripter menuStep
		assertClosedMenuContainer;
		play.

	aScripter assert
		label: 'Search text element does not exist';
		notExists;
		onPopover;
		// BrEditorSearchTextElement;
		play.

	aScripter assert
		label: 'Editor has focus';
		satisfies: [ :aBrEditor | aBrEditor isFocused ];
		play.

	aScripter assert
		label: 'Editor has selection';
		satisfies: [ :aBrEditor | 
			(aBrEditor selection containsIndex: aMarkArray first)
				and: [ aBrEditor selection containsIndex: aMarkArray second ] ];
		play.


	^ aScripter
]

{ #category : #'examples - editor' }
BrEditorSearchTextWithScripterExamples >> editorSearchPreviousAB_endByEscape_openAgain [
	<gtExample>
	| aScripter allMarks allSelectedMarks |
	aScripter := self editorSearchPreviousAB_endByEscape.

	aScripter shortcut
		label: 'Open search text dialog';
		combination: BlKeyCombination primaryF;
		play.

	aScripter menuStep
		assertMenuContainerExist;
		assertMenuContainerHasFocus;
		onPopover;
		play.

	aScripter assert
		label: 'Search text element exists';
		exists;
		onPopover;
		// BrEditorSearchTextElement;
		play.

	aScripter assert
		label: 'Search text element input editor is focused';
		satisfies: [ :aBrEditor | aBrEditor isFocused ];
		onPopover;
		// BrEditorSearchTextElement;
		// BrEditor;
		play.

	aScripter assert
		label: 'Search text element input editor has "a b"';
		value: [ :aBrEditor | aBrEditor text asString ] equals: 'a b';
		onPopover;
		// BrEditorSearchTextElement;
		// BrEditor;
		play.
		
	allMarks := self allMarksFromScripter: aScripter.
	self assert: allMarks size equals: 2000.

	allSelectedMarks := allMarks
			select: [ :anArray | anArray third isSelected ]
			thenCollect: #third.
	self assert: allSelectedMarks size equals: 1.
	self assert: allSelectedMarks first index equals: 157.

	^ aScripter
]

{ #category : #'examples - editor' }
BrEditorSearchTextWithScripterExamples >> editorWithSearchTextAptitude [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithElement: [ self editorElementWithSearchTextAptitude ].

	aScripter do
		label: 'Scroll text';
		block: [ :anElement | anElement scrollToPosition: 50 ];
		play.

	aScripter assert
		label: 'Assert first visible segment';
		satisfies: [ :anElement | anElement firstVisibleSegment index > 30 ]
			description: [ :anElement | 
				'Editor first visible segment index must be > 30, but is {1}'
					format: {anElement firstVisibleSegment index > 30} ];
		play.

	^ aScripter
]

{ #category : #'examples - marker' }
BrEditorSearchTextWithScripterExamples >> markAB [
	<gtExample>
	| aMarker aContext aScripter allMarks |
	aMarker := self basicMarker.
	aScripter := self editor.

	aContext := BrEditorSearchTextMarkerContext new
			fromEditor: aScripter element;
			subtext: 'a b' asRopedText.

	aScripter do
		label: 'Mark "a b"';
		block: [ aMarker mark: aContext ];
		play.

	self assert: aContext selectedItem isNotNil.
	self assert: aContext selectedItem isSelected.
	
	self assert: aContext selectedItem index equals: 161.
	self assert: aContext selectedItem startIndex equals: 8516.
	self
		assert: aContext selectedItem stopIndex = (aContext selectedItem startIndex + 2).
	self assert: aContext selectedIndex isNotNil.
	self assert: aContext selectedIndex equals: 161.

	allMarks := self allMarksFromScripter: aScripter.
	self assert: allMarks size equals: 2000.

	aScripter userData
		at: #markerResult
		put: (BrEditorSearchTextExampleResult new
				marker: aMarker;
				context: aContext).
	
	^ aScripter
]

{ #category : #'examples - marker' }
BrEditorSearchTextWithScripterExamples >> markNextAB [
	<gtExample>
	| aMarker aContext aScripter allMarks aResult |
	aScripter := self markAB.
	aResult := aScripter userData at: #markerResult.
	aMarker := aResult marker.
	aContext := aResult context.

	aScripter do
		label: 'Mark next "a b"';
		block: [ aMarker markNext: aContext ];
		play.

	self assert: aResult selectedItem isSelected not.
	self assert: aContext selectedItem index equals: 162.
	self assert: aContext selectedItem ~= aResult selectedItem.
	self assert: aContext selectedItem isSelected.
	self assert: aContext selectedItem startIndex >= aResult selectedItem stopIndex.
	self
		assert: aContext selectedItem stopIndex
		equals: aContext selectedItem startIndex + 2.
	self assert: aContext selectedIndex isNotNil.
	self assert: aContext selectedIndex equals: 162.

	allMarks := self allMarksFromScripter: aScripter.
	self assert: allMarks size equals: 2000.

	^ aScripter
]

{ #category : #'examples - marker' }
BrEditorSearchTextWithScripterExamples >> markPreviousAB [
	<gtExample>
	| aMarker aContext aScripter allMarks aResult |
	aScripter := self markAB.
	aResult := aScripter userData at: #markerResult.
	aMarker := aResult marker.
	aContext := aResult context.

	aScripter do
		label: 'Mark previous "a b"';
		block: [ aMarker markPrevious: aContext ];
		play.

	self assert: aResult selectedItem isSelected not.
	self assert: aContext selectedItem ~= aResult selectedItem.
	self assert: aContext selectedItem isSelected.
	self assert: aContext selectedItem stopIndex <= aResult selectedItem stopIndex.
	self
		assert: aContext selectedItem startIndex = (aContext selectedItem stopIndex - 2).
	self assert: aContext selectedItem index equals: 160.
	self assert: aContext selectedIndex isNotNil.
	self assert: aContext selectedIndex equals: 160.

	allMarks := self allMarksFromScripter: aScripter.
	self assert: allMarks size equals: 2000.

	^ aScripter
]

{ #category : #support }
BrEditorSearchTextWithScripterExamples >> simple500Lines [
	^ BrEditorSearchTextExamples new simple500Lines
]
