Extension { #name : #BrTextEditorSegmentCollector }

{ #category : #'*Brick-Editor-Extensions' }
BrTextEditorSegmentCollector >> gtSegmentsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Segments';
		items: [ self segments ];
		priority: 1;
		column: 'Index' text: [ :each | '{1} ({2}-{3} | {4})' format: { each index . each textStart . each textEnd . each textEndDelimited } ];
		column: 'Text' text: [ :each | each ]
]
