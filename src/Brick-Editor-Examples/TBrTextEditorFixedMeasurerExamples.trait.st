"
I add utility methods related to fixed text measurer
"
Trait {
	#name : #TBrTextEditorFixedMeasurerExamples,
	#category : #'Brick-Editor-Examples'
}

{ #category : #'private - font metrics' }
TBrTextEditorFixedMeasurerExamples >> ascent [
	^ -20
]

{ #category : #'private - font metrics' }
TBrTextEditorFixedMeasurerExamples >> descent [
	^ 20
]

{ #category : #'instance creation' }
TBrTextEditorFixedMeasurerExamples >> editorFor: aText [
	<return: #BrEditor>
	| anEditor aRopedText |

	aRopedText := aText asRopedText lineSpacing: self lineSpacing; paragraphMargin: self paragraphMargin; wordPadding: self wordPadding.

	anEditor := BrEditor new.
	anEditor aptitude: BrEditorAptitude new.
	anEditor padding: BlInsets empty.
	anEditor fitContent.
	anEditor text: aRopedText.
	
	BlDevCrossover on: anEditor.
	
	anEditor editor segmentBuilder
		wordStencil: [ :aTBrTextEditorTextualPiece |
			| aTextElement |
			aTextElement := BrTextEditableWordPieceStencilBuilder new
				segmentPiece: aTBrTextEditorTextualPiece;
				asElement.
			aTextElement measurer: self fixedMeasurer.
			aTextElement measurer textOffset: aTBrTextEditorTextualPiece textStart.
			aTextElement ].
	
	anEditor requestFocus.
	anEditor forceLayout.

	^ anEditor
]

{ #category : #'private - instance creation' }
TBrTextEditorFixedMeasurerExamples >> fixedMeasurer [
	^ BlTextElementMockedMeasurer new
		ascent: self ascent;
		descent: self descent;
		glyphWidth: self glyphWidth;
		glyphHeight: self glyphHeight
]

{ #category : #'private - font metrics' }
TBrTextEditorFixedMeasurerExamples >> glyphHeight [
	^ self ascent abs + self descent
]

{ #category : #'private - font metrics' }
TBrTextEditorFixedMeasurerExamples >> glyphWidth [
	^ 10
]

{ #category : #'private - font metrics' }
TBrTextEditorFixedMeasurerExamples >> lineSpacing [
	^ 5
]

{ #category : #'private - font metrics' }
TBrTextEditorFixedMeasurerExamples >> paragraphMargin [
	^ BlInsets all: 15
]

{ #category : #'private - font metrics' }
TBrTextEditorFixedMeasurerExamples >> wordPadding [
	^ BlInsets top: 3 bottom: 3
]
