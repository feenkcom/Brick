Extension { #name : #BrTextEditorModel }

{ #category : #'*Brick-Editor-LineBased' }
BrTextEditorModel >> beLineBased [
	segmentBuilder := BrTextEditorLineSegmentBuilder new
			splitter: (BrTextEditorSplitter new
					segmentClass: BrTextEditorLineSegment;
					yourself)
]
