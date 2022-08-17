Class {
	#name : #BrTextEditorLineBasedNavigatorExamples,
	#superclass : #BrTextEditorNavigatorExamples,
	#category : #'Brick-Editor-Examples-Operators'
}

{ #category : #accessing }
BrTextEditorLineBasedNavigatorExamples >> editorFor: aText [
	<return: #BrEditor>
	| anEditor aRopedText |

	aRopedText := aText asRopedText lineSpacing: self lineSpacing; paragraphMargin: self paragraphMargin; wordPadding: self wordPadding.

	anEditor := BrEditor new.
	anEditor editor beLineBased.
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
