"
# Text attributes 
## How to create a link in a text?
{{gtExample:BrTextAttributesHowToGuide>>#linkInText|previewExpanded}}
## How to create a hide-able markup in a text?
{{gtExample:BrTextAttributesHowToGuide>>#hideMarkupInText|previewExpanded}}

"
Class {
	#name : #BrTextAttributesHowToGuide,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples-! Documentation'
}

{ #category : #examples }
BrTextAttributesHowToGuide >> hideMarkupInText [
	<gtExample>
	<return: #BrEditor>
	| text leftMarker rightMarker |
	text := 'Move the cursor **here** to show the markup' asRopedText
			fontSize: 20.

	(text from: 19 to: 22) bold.

	(text from: 17 to: 18)
		foreground: Color blue;
		attribute: (leftMarker := BrTextInvisibleMarkerAttribute new).

	(text from: 23 to: 24)
		foreground: Color blue;
		attribute: (rightMarker := BrTextInvisibleMarkerAttribute new).

	(text from: 15 to: 26)
		onCursorEnter: [ :aTextEditor :anEvent :aFromIndex :aToIndex | 
			| aSubText |
			(aSubText := aTextEditor text from: aFromIndex to: aToIndex)
				findAttributes: {leftMarker.
						rightMarker}
				indicesDo: [ :aMarkupStart :aMarkupEnd | 
					(aSubText from: aMarkupStart to: aMarkupEnd)
						clearAttributesOfClass: BrTextHideAttribute ] ]
		leave: [ :aTextEditor :anEvent :aFromIndex :aToIndex | 
			| aSubText |
			(aSubText := aTextEditor text from: aFromIndex to: aToIndex)
				findAttributes: {leftMarker.
						rightMarker}
				indicesDo: [ :aMarkupStart :aMarkupEnd | (aSubText from: aMarkupStart to: aMarkupEnd) attribute: BrTextHideAttribute new ] ].

	^ BrEditor new
		aptitude: BrGlamorousEditorAptitude new;
		text: text
]

{ #category : #examples }
BrTextAttributesHowToGuide >> linkInText [
	<gtExample>
	<return: #BlRunRopedText>
	| text |
	text := 'You can click on this.' asRopedText.
	(text from: 9 to: 13)
		foreground: Color blue;
		onClick: [ :aTBrTextEditorTextualPiece :aTarget :aTextEditor :anEvent | 
			anEvent currentTarget phlow
				spawnObject: {aTBrTextEditorTextualPiece.
						aTarget.
						aTextEditor.
						anEvent} ];
		attribute: (BrTextHoverStylableAttribute new
				attribute: (BlTextDecorationAttribute new underline color: Color blue)).
	^ text
]
