Class {
	#name : #BrTextEditorHistory,
	#superclass : #Object,
	#instVars : [
		'undoCommands',
		'redoCommands',
		'isEnabled',
		'shouldGroup',
		'currentGroup'
	],
	#category : #'Brick-Editor-History'
}

{ #category : #private }
BrTextEditorHistory >> addCommand: aCommand [
	isEnabled
		ifFalse: [ ^ self ].
		
	shouldGroup
		ifTrue: [ currentGroup addCommand: aCommand ]
		ifFalse: [ undoCommands add: aCommand ].
	redoCommands removeAll
]

{ #category : #'api - history' }
BrTextEditorHistory >> cursorsMovedFrom: aCollectionOfFromIndices to: aCollectionOfToIndices [
	self addCommand: (BrTextEditorHistoryCursorMovementCommand new
		fromIndices: aCollectionOfFromIndices;
		toIndices: aCollectionOfToIndices)
]

{ #category : #'api - history' }
BrTextEditorHistory >> deletedTexts: aCollectionOfTexts undo: aCollectionOfUndoIndices redo: aCollectionOfRedoIndices [
	| deleteCommand |
	self addCommand: (deleteCommand := BrTextEditorHistoryDeletionCommand new
		texts: aCollectionOfTexts;
		undoIndices: aCollectionOfUndoIndices;
		redoIndices: aCollectionOfRedoIndices).
	^ deleteCommand
]

{ #category : #'api - history' }
BrTextEditorHistory >> disableDuring: aBlock [
	| wasEnabled |
	
	wasEnabled := isEnabled.
	isEnabled := false.
	
	aBlock ensure: [ isEnabled := wasEnabled ]
]

{ #category : #'api - history' }
BrTextEditorHistory >> groupDuring: aBlock [
	| wasGrouped |
	
	wasGrouped := shouldGroup.
	wasGrouped
		ifFalse: [
			currentGroup := BrTextEditorHistoryCompositeCommand new.
			undoCommands add: currentGroup ].
	
	shouldGroup := true.
	aBlock ensure: [
		shouldGroup := wasGrouped.
		shouldGroup ifFalse: [
			currentGroup commands
				ifEmpty: [ undoCommands remove: currentGroup ]
				ifNotEmpty: [ :theCommands |
					theCommands size = 1
						ifTrue: [
							undoCommands remove: currentGroup.
							undoCommands addAll: theCommands ] ] ] ]
]

{ #category : #initialization }
BrTextEditorHistory >> initialize [
	super initialize.
	
	undoCommands := OrderedCollection new.
	redoCommands := OrderedCollection new.

	isEnabled := true.
	
	"when set to false all commands are added individually, otherwise they end up in a composite group"
	shouldGroup := false.
	currentGroup := BrTextEditorHistoryCompositeCommand new
]

{ #category : #'api - history' }
BrTextEditorHistory >> insertedStrings: aCollectionOfStrings undo: aCollectionOfUndoIndices redo: aCollectionOfRedoIndices [
	| insertCommand |
	self addCommand: (insertCommand := BrTextEditorHistoryInsertionCommand new
		strings: aCollectionOfStrings;
		undoIndices: aCollectionOfUndoIndices;
		redoIndices: aCollectionOfRedoIndices).
	^ insertCommand
]

{ #category : #testing }
BrTextEditorHistory >> isEnabled [
	^ isEnabled
]

{ #category : #accessing }
BrTextEditorHistory >> redoCommands [
	^ redoCommands
]

{ #category : #'api - undo/redo' }
BrTextEditorHistory >> redoOn: aBrTextEditor [
	redoCommands ifNotEmpty: [ :theCommands |
		self disableDuring: [ undoCommands add: (theCommands removeLast redoOn: aBrTextEditor) ] ]
]

{ #category : #'api - history' }
BrTextEditorHistory >> replaceText: newText oldText: oldText [
	self
		addCommand: (BrTextEditorHistoryReplaceTextCommand new
				newText: newText;
				oldText: oldText)
]

{ #category : #testing }
BrTextEditorHistory >> shouldGroup [
	^ shouldGroup
]

{ #category : #accessing }
BrTextEditorHistory >> undoCommands [
	^ undoCommands
]

{ #category : #'api - undo/redo' }
BrTextEditorHistory >> undoOn: aBrTextEditor [
	undoCommands ifNotEmpty: [ :theCommands |
		self disableDuring: [ redoCommands add: (theCommands removeLast undoOn: aBrTextEditor) ] ]
]
