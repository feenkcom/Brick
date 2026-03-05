Class {
	#name : #BrEditorWithScripterExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Editor'
}

{ #category : #asserting }
BrEditorWithScripterExamples >> assert: aScripter scrollbarIsVisible: aBoolean [
	| aScrollbar |
	aScrollbar := (aScripter element query
			// #verticalScrollbar;
			/ #scrollbar) anyOne.
	self
		assert: aScrollbar visibility
		equals: (aBoolean ifTrue: [ BlVisibility visible ] ifFalse: [ BlVisibility hidden ])
]

{ #category : #'examples - support' }
BrEditorWithScripterExamples >> editorWithScrollbar [
	<gtExample>
	| aPane anEditor aBorder aContainer aScrollbarAptitude |
	anEditor := BrEditor new
			aptitude: (BrGlamorousRegularEditorAptitude new
					defaultFontName: 'Source Sans Pro';
					defaultFontSize: 12);
			addAptitude: BrGlamorousEditorSpacingAptitude;
			text: 'one';
			hMatchParent;
			vFitContentLimited.

	aPane := BrVerticalPane new
			hMatchParent;
			vFitContentLimited;
			addChild: anEditor as: #myEditor;
			addAptitude: (aScrollbarAptitude := BrGlamorousWithVerticalScrollbarAptitude new
						scrollableName: #myEditor);
			addAptitude: (BrLayoutResizerAptitude new common: anEditor).

	aBorder := BrFrame new
			hMatchParent;
			vFitContentLimited;
			addAptitude: (BrLayoutResizerAptitude new common: aPane);
			padding: (BlInsets all: 10);
			background: (Color lightBlue alpha: 0.5);
			addChild: aPane.

	aContainer := BrFrame new
			exact: 200 @ 100;
			border: Color black;
			addChild: aBorder.

	^ aContainer
]

{ #category : #'examples - short lines' }
BrEditorWithScripterExamples >> fiveShortLines [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithText: ('one{1}two{1}three{1}four{1}five' format: {String crlf}).
	self assert: aScripter scrollbarIsVisible: true.
	
	^ aScripter
]

{ #category : #'examples - short lines' }
BrEditorWithScripterExamples >> fourShortLines [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithText: ('one{1}two{1}three{1}four' format: {String crlf}).
	self assert: aScripter scrollbarIsVisible: false.
	
	^ aScripter
]

{ #category : #'examples - short lines' }
BrEditorWithScripterExamples >> fourShortLines_addTwoLines [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithText: ('one{1}two{1}three{1}four' format: {String crlf}).
	self assert: aScripter scrollbarIsVisible: false.

	aScripter editor
		// #myEditor;
		requestFocus;
		assertHasFocus;
		moveDown;
		moveDown;
		moveDown;
		moveToEnd;
		pressReturn;
		typeText: 'five';
		pressReturn;
		typeText: 'six';
		play.

	self assert: aScripter scrollbarIsVisible: true.

	^ aScripter
]

{ #category : #'examples - long lines' }
BrEditorWithScripterExamples >> oneLongLineWrappedInTwoLines [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithText: 'one two three four five six seven eight nine ten'.
	self assert: aScripter scrollbarIsVisible: false.

	^ aScripter
]

{ #category : #'examples - short lines' }
BrEditorWithScripterExamples >> oneShortLine [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithText: 'one'.
	self assert: aScripter scrollbarIsVisible: false.

	^ aScripter
]

{ #category : #'examples - support' }
BrEditorWithScripterExamples >> scripterWithText: aText [
	| anElement aScripter |
	anElement := self editorWithScrollbar.
	(anElement childWithId: #myEditor) text: aText.
	aScripter := BlScripter new.
	aScripter extent: 200 @ 100.
	aScripter element: anElement.
	aScripter root border: Color black.

	^ aScripter
]

{ #category : #'examples - long lines' }
BrEditorWithScripterExamples >> threeLongLinesWrappedInTwoLinesEach [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithText: ('one two three four five six seven eight nine ten{1}one two three four five six seven eight nine ten{1}one two three four five six seven eight nine ten'
					format: {String crlf}).
	self assert: aScripter scrollbarIsVisible: true.

	^ aScripter
]

{ #category : #'examples - short lines' }
BrEditorWithScripterExamples >> threeShortLines [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithText: ('one{1}two{1}three' format: {String crlf}).
	self assert: aScripter scrollbarIsVisible: false.
	
	^ aScripter
]

{ #category : #'examples - long lines' }
BrEditorWithScripterExamples >> twoLongLinesWrappedInTwoLinesEach [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithText: ('one two three four five six seven eight nine ten{1}one two three four five six seven eight nine ten'
					format: {String crlf}).
	self assert: aScripter scrollbarIsVisible: false.

	^ aScripter
]

{ #category : #'examples - short lines' }
BrEditorWithScripterExamples >> twoShortLines [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithText: ('one{1}two' format: {String crlf}).
	self assert: aScripter scrollbarIsVisible: false.
	
	^ aScripter
]
