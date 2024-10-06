Extension { #name : #BrTextEditorModel }

{ #category : #'*Brick-Editor-Extensions' }
BrTextEditorModel >> gtHistoryFor: aView [
	<gtView>

	^ (self history gtHistoryFor: aView)
		title: 'History';
		priority: 2
]

{ #category : #'*Brick-Editor-Extensions' }
BrTextEditorModel >> gtSegmentsFor: aView [
	<gtView>

	^ (self segmentCollector gtSegmentsFor: aView)
		title: 'Segments';
		priority: 3
]

{ #category : #'*Brick-Editor-Extensions' }
BrTextEditorModel >> gtSelectionTreeFor: aView [
	<gtView>

	^ (selection gtTreeFor: aView)
		priority: 5;
		title: 'Selection'
]

{ #category : #'*Brick-Editor-Extensions' }
BrTextEditorModel >> gtTextFor: aView [
	<gtView>
	^ (self text 
		gtTextFor: aView)
		priority: 1
]
