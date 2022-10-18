Extension { #name : #BrTextEditorSegment }

{ #category : #'*Brick-Editor-Extensions' }
BrTextEditorSegment >> gtInfoFor: aView [
	<gtView>

	^ ({
		#index -> index.
		#text -> self text.
		#textStart -> self textStart.
		#textEnd -> self textEnd.
		#textEndDelimited -> self textEndDelimited.
		#lineSpacing -> self lineSpacing.
		#wordPadding -> self wordPadding.
		#paragraphMargin -> self paragraphMargin.
	 } asOrderedDictionary gtItemsFor: aView)
			title: 'Info';
			priority: 2
]

{ #category : #'*Brick-Editor-Extensions' }
BrTextEditorSegment >> gtInspectorTextIn: composite [
	<gtInspectorPresentationOrder: 5>  
	 composite text
		title: 'Text';
		format: self text asString
]

{ #category : #'*Brick-Editor-Extensions' }
BrTextEditorSegment >> gtPiecesFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Pieces';
		items: [ self pieces ];
		priority: 5;
		column: 'Interval' text: [ :each | (each textStart to: each textEnd) asString ];
		column: 'Text' text: [ :each | each ]
]
