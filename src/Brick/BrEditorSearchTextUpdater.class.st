"
I update existing {{gtMethod:BrEditorModel >> #text}} styling using a new {{gtMethod:BrEditorSearchTextUpdater>>#styledText | label=#selector}}. 
Inspired by {{gtMethod:BrTextEditorModel>>#onTextStyled:}}. 
The difference is that {{gtMethod:BrEditorSearchTextUpdater>>#update | label=#selector}} does not trigger a new style text request when an editor's text changed in the meantime.

"
Class {
	#name : #BrEditorSearchTextUpdater,
	#superclass : #Object,
	#instVars : [
		'editorModel',
		'styledText'
	],
	#category : #'Brick-Editor - Search Support'
}

{ #category : #accessing }
BrEditorSearchTextUpdater >> editorModel [
	<return: #BrTextEditorModel>
	^ editorModel
]

{ #category : #accessing }
BrEditorSearchTextUpdater >> editorModel: aBrTextEditorModel [
	editorModel := aBrTextEditorModel
]

{ #category : #accessing }
BrEditorSearchTextUpdater >> styledText [
	<return: #BlGenerationText>
	^ styledText
]

{ #category : #accessing }
BrEditorSearchTextUpdater >> styledText: aBlGenerationText [
	styledText := aBlGenerationText
]

{ #category : #'api - updating' }
BrEditorSearchTextUpdater >> update [
	"Update editor model's text, integrating new styling.
	Return true if the integration happened, false otherwise.
	
	Note: Influenced by `BrTextEditorModel>>#onTextStyled:`"
	
	<return: #Boolean>
	editorModel assertUIProcess.
	
	(styledText isNextGenerationOf: editorModel text)
		ifFalse: [ ^ false ].

	(editorModel segmentBuilder
		requiresResplittingFrom: editorModel text
		to: styledText)
			ifTrue: [
				"It is possible that the segment structure has changed"
				editorModel segmentBuilder resetSegmentCacheAndNotify: editorModel ].

	editorModel text updateFrom: styledText text.

	editorModel notifyTextStyled: editorModel text.

	editorModel processCursorEnterEvents.

	editorModel updater
		all;
		update.
		
	^ true
]
