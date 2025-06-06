Class {
	#name : #BrTextEditorOperatorExamples,
	#superclass : #Object,
	#traits : 'TBrTextEditorFixedMeasurerExamples',
	#classTraits : 'TBrTextEditorFixedMeasurerExamples classTrait',
	#category : #'Brick-Editor-Examples-Operators'
}

{ #category : #'instance creation' }
BrTextEditorOperatorExamples >> crlfText [
	<gtExample>
	<return: #BlRunRopedText>
	^ ('12' , String crlf , '34') asRopedText
]

{ #category : #'instance creation' }
BrTextEditorOperatorExamples >> delimiterText [
	^'He said, "Hello, world", (really, he did). ((nesting should work, also) (really)), ''single quotes also'', [brackets too], and {also braces}' asRopedText 
]

{ #category : #'focus - examples' }
BrTextEditorOperatorExamples >> editorCreatesOneCursorOnFocus [
	<gtExample>
	<return: #BrEditor>
	| anEditor aSpace |
	anEditor := self editorHasNoFocusByDefault.

	aSpace := BlSpace new.
	aSpace host: BlHeadlessHost new.
	aSpace addChild: anEditor.

	self assert: anEditor cursors isEmpty.

	anEditor requestFocus.
	aSpace pulse.

	self assert: anEditor isFocused.
	self assert: anEditor hasFocus.
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: 0}.

	aSpace removeChild: anEditor.

	^ anEditor
]

{ #category : #'focus - examples' }
BrTextEditorOperatorExamples >> editorHasNoFocusByDefault [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := BrEditor new.
	self assert: anEditor isFocused not.
	self assert: anEditor hasFocus not.

	^ anEditor
]

{ #category : #'instance creation' }
BrTextEditorOperatorExamples >> editorOnCrlfText [
	<gtExample>
	<return: #BrEditor>
	| anEditor anEditorElement |
	anEditorElement := self editorFor: self crlfText.
	anEditor := anEditorElement editor.

	self assert: anEditor cursors isEmpty.
	self assert: anEditor selection isEmpty.

	^ anEditorElement
]

{ #category : #'instance creation' }
BrTextEditorOperatorExamples >> editorOnEmptyText [
	<gtExample>
	<return: #BrEditor>
	| anEditor anEditorElement |
	anEditorElement := self editorFor: '' asRopedText.
	anEditor := anEditorElement editor.

	self assert: anEditor cursors isEmpty.
	self assert: anEditor selection isEmpty.

	^ anEditorElement
]

{ #category : #'instance creation' }
BrTextEditorOperatorExamples >> editorOnFoldedText [
	<gtExample>
	<return: #BrEditor>
	| anEditor anEditorElement |
	anEditorElement := self editorFor: self foldedMultilineText.
	anEditor := anEditorElement editor.

	self assert: anEditor cursors isEmpty.
	self assert: anEditor selection isEmpty.

	^ anEditorElement
]

{ #category : #'instance creation' }
BrTextEditorOperatorExamples >> editorOnMultilineFoldedText [
	<gtExample>
	<return: #BrEditor>
	| anEditor anEditorElement |
	anEditorElement := self editorFor: self multilineFoldedText.
	anEditor := anEditorElement editor.

	self assert: anEditor cursors isEmpty.
	self assert: anEditor selection isEmpty.

	^ anEditorElement
]

{ #category : #'instance creation' }
BrTextEditorOperatorExamples >> editorOnMultilineText [
	<gtExample>
	<return: #BrEditor>
	| anEditor anEditorElement |
	anEditorElement := self editorFor: self multilineText.
	anEditor := anEditorElement editor.

	self assert: anEditor cursors isEmpty.
	self assert: anEditor selection isEmpty.

	^ anEditorElement
]

{ #category : #'examples - showroom' }
BrTextEditorOperatorExamples >> editorOnSomeThing [

	^ self editorFor: 'SomeThing'
]

{ #category : #'instance creation' }
BrTextEditorOperatorExamples >> editorOnTextWithDelimiters [
	<gtExample>
	<return: #BrEditor>
	| anEditor anEditorElement |
	anEditorElement := self editorFor: self delimiterText.
	anEditor := anEditorElement editor.

	self assert: anEditor cursors isEmpty.
	self assert: anEditor selection isEmpty.

	^ anEditorElement
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceInEmptyAt_0 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := '' asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 0.

	self assert: whitespace = ''.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_Hello_at_0 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := 'Hello' asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 0.

	self assert: whitespace = ''.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_Hello_at_1 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := 'Hello' asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 1.

	self assert: whitespace = ''.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_Hello_at_2 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := 'Hello' asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 2.

	self assert: whitespace = ''.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_Hello_at_3 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := 'Hello' asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 3.

	self assert: whitespace = ''.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_Hello_at_4 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := 'Hello' asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 4.

	self assert: whitespace = ''.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_Hello_at_5 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := 'Hello' asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 5.

	self assert: whitespace = ''.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_Hello_cr_World_at_6 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := ('Hello' , String cr , 'World') asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 6.

	self assert: whitespace = ''.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_Hello_cr_World_at_7 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := ('Hello' , String cr , 'World') asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 7.

	self assert: whitespace = ''.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_Hello_cr_World_at_8 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := ('Hello' , String cr , 'World') asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 8.

	self assert: whitespace = ''.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_Hello_cr_space_World_at_6 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := ('Hello' , String cr , ' World') asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 6.

	self assert: whitespace = ''.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_Hello_cr_space_World_at_7 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := ('Hello' , String cr , ' World') asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 7.

	self assert: whitespace = ' '.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_Hello_cr_space_World_at_8 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := ('Hello' , String cr , ' World') asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 8.

	self assert: whitespace = ' '.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_space_Hello_at_0 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := ' Hello' asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 0.

	self assert: whitespace = ''.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_space_Hello_at_1 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := ' Hello' asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 1.

	self assert: whitespace = ' '.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_space_Hello_at_2 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := ' Hello' asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 2.

	self assert: whitespace = ' '.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_space_at_0 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := ' ' asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 0.

	self assert: whitespace = ''.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_space_at_1 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := ' ' asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 1.

	self assert: whitespace = ' '.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_space_space_at_0 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := '  ' asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 0.

	self assert: whitespace = ''.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_space_space_at_1 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := '  ' asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 1.

	self assert: whitespace = ' '.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_space_space_at_2 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := '  ' asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 2.

	self assert: whitespace = '  '.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_space_tab_at_0 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := (' ' , String tab) asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 0.

	self assert: whitespace = ''.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_space_tab_at_1 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := (' ' , String tab) asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 1.

	self assert: whitespace = ' '.

	^ whitespace
]

{ #category : #'utility - examples' }
BrTextEditorOperatorExamples >> findWhitespaceIn_space_tab_at_2 [
	<gtExample>
	<return: #ByteString>
	| text editor whitespace |
	text := (' ' , String tab) asRopedText.
	editor := BrTextEditorModel new text: text.
	whitespace := editor inserter findWhitespaceOfLineBefore: 2.

	self assert: whitespace = (' ' , String tab).

	^ whitespace
]

{ #category : #'as yet unclassified' }
BrTextEditorOperatorExamples >> foldedMultilineText [
	| text string openIndex closeIndex |
	string := '(foo
bar
{ 
	quux
	bletch
}
baz)'.
	text := string asRopedText.
	openIndex := string indexOf: $(.
	closeIndex := string indexOf: $).

	text
		attribute: BrTextFoldAttribute new
		from: openIndex + 1
		to: closeIndex - 1.

	^ text
]

{ #category : #'instance creation' }
BrTextEditorOperatorExamples >> multilineFoldedText [
	| text |
	text := 'segment: anEditorSegment
	segment == anEditorSegment
		ifTrue:
			[ BlFrameTelemetry time: [ ''Update segment at {1}'' format: {anEditorSegment index} ] during: [ self updateSegment ] ]
		ifFalse:
			[ BlFrameTelemetry
				time: [ ''Build segment at {1}'' format: {anEditorSegment index} ]
				during: [ self buildSegment: anEditorSegment ] ]' asRopedText.
	text attribute: BrTextFoldAttribute new from: 68 to: 160.
		text attribute: BrTextFoldAttribute new from: 180 to: 181.
	^ text
]

{ #category : #'instance creation' }
BrTextEditorOperatorExamples >> multilineText [
	<gtExample>
	<return: #BlRunRopedText>
	^ 'A summer river being crossed
how pleasing
with sandals in my hands!

Light of the moon
Moves west, flowers'' shadows
Creep eastward.

In the moonlight,
The color and scent of the wisteria
Seems far away.' asRopedText
]

{ #category : #'private - utility' }
BrTextEditorOperatorExamples >> piecesWithCursorIn: anEditorElement [
	^ anEditorElement withAllChildrenBreadthFirst
		select: [ :eachChild | eachChild isKindOf: BrCursorElement ]
		thenCollect: [ :eachCursor | eachCursor parent ]
]

{ #category : #'private - events' }
BrTextEditorOperatorExamples >> subscribe: anEventClass do: aBlock for: anElement [
	anElement when: anEventClass do: aBlock
]

{ #category : #'private - events' }
BrTextEditorOperatorExamples >> unsubscribe: anEventClass from: anElement [
	anElement removeEventHandlersSuchThat: [ :anEventHandler | (anEventHandler isKindOf: BlEventHandler) and: [ anEventHandler eventClass = anEventClass ] ]
]
