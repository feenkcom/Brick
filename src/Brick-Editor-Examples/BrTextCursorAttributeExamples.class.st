Class {
	#name : #BrTextCursorAttributeExamples,
	#superclass : #BrTextEditorAdornmentsExamples,
	#category : #'Brick-Editor-Examples-! Documentation'
}

{ #category : #public }
BrTextCursorAttributeExamples >> changingForeground [
	<gtExample>
	<return: #BlRunRopedText>
	| text |
	text := 'Hello World
- place the cursor here
- second item' asRopedText fontSize: 20.

	(text from: 14 to: 35)
		foreground: Color blue;
		onCursorEnter: [ :aTextEditor :anEvent :aFromIndex :aToIndex | (aTextEditor text from: aFromIndex to: aToIndex) foreground: Color red ]
			leave: [ :aTextEditor :anEvent :aFromIndex :aToIndex | (aTextEditor text from: aFromIndex to: aToIndex) foreground: Color blue ].

	^ text
]
