Class {
	#name : #BrEditorShortcutIds,
	#superclass : #BlShortcutIds,
	#instVars : [
		'newLineShortcutId',
		'loseFocusShortcutId'
	],
	#category : #'Brick-Editor-Shortcuts'
}

{ #category : #initialization }
BrEditorShortcutIds >> initialize [ 
	super initialize.
	
	newLineShortcutId := BlShortcutId  identifier: #NewLine.
	loseFocusShortcutId := BlShortcutId  identifier: #LoseFocus.
	
]

{ #category : #'as yet unclassified' }
BrEditorShortcutIds >> loseFocusShortcutId [
	^ loseFocusShortcutId
]

{ #category : #'as yet unclassified' }
BrEditorShortcutIds >> newLineShortcutId [
	^ newLineShortcutId
]
