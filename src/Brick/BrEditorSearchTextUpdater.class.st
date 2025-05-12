Class {
	#name : #BrEditorSearchTextUpdater,
	#superclass : #Object,
	#instVars : [
		'editorModel',
		'styledText'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #accessing }
BrEditorSearchTextUpdater >> editorModel [
	^ editorModel
]

{ #category : #accessing }
BrEditorSearchTextUpdater >> editorModel: anObject [
	editorModel := anObject
]

{ #category : #accessing }
BrEditorSearchTextUpdater >> styledText [
	^ styledText
]

{ #category : #accessing }
BrEditorSearchTextUpdater >> styledText: anObject [
	styledText := anObject
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
