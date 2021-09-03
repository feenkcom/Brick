Extension { #name : 'BrTextEditorHistory' }

{ #category : '*Brick-Editor-Extensions' }
BrTextEditorHistory >> gtHistoryFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'History';
		priority: 1;
		items: [
			(redoCommands reversed collect: [ :eachCommand | eachCommand -> #Redo ]),
			(undoCommands reversed collect: [ :eachCommand | eachCommand -> #Undo ]) ];
		column: 'Type' text: [ :eachCommandAndType |
			eachCommandAndType value = #Redo
				ifTrue: [ eachCommandAndType value gtDisplayText foreground: Color gray ]
				ifFalse: [ eachCommandAndType value gtDisplayText ] ] width: 100;
		column: 'Command' text: [ :eachCommandAndType |
			eachCommandAndType value = #Redo
				ifTrue: [ eachCommandAndType key gtDisplayText foreground: Color gray ]
				ifFalse: [ eachCommandAndType key gtDisplayText ] ]
]
