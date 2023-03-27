Class {
	#name : #BrTextEditorShortcuts,
	#superclass : #Object,
	#instVars : [
		'shortcuts'
	],
	#category : #'Brick-Editor-Model'
}

{ #category : #'adding / removing' }
BrTextEditorShortcuts >> add: aNewEditorShortcut ifAdded: anAddedBlock ifReplaced: aReplacedBlock [
	"I add a new interaction shortcut or replace an existing one for the same combination and evaluate aReplacedBlock if it was the case"

	shortcuts
		at: aNewEditorShortcut combinationForPlatform
		ifPresent: [ :anExistingEditorShortcut |
			shortcuts at: aNewEditorShortcut combinationForPlatform put: aNewEditorShortcut.
			aReplacedBlock value: anExistingEditorShortcut.
			anAddedBlock value: aNewEditorShortcut ]
		ifAbsent: [
			shortcuts at: aNewEditorShortcut combinationForPlatform put: aNewEditorShortcut.
			anAddedBlock value: aNewEditorShortcut ]
]

{ #category : #enumerating }
BrTextEditorShortcuts >> detectShortcutLike: anEditorShortcut ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ shortcuts
		at: anEditorShortcut combinationForPlatform
		ifPresent: [ :aShortcut | 
			aPresentBlock cull: aShortcut ]
		ifAbsent: [ anAbsentBlock value ]
]

{ #category : #enumerating }
BrTextEditorShortcuts >> do: aBlock [
	shortcuts do: aBlock
]

{ #category : #'gt - extensions' }
BrTextEditorShortcuts >> gtViewShortcutsFor: aView [
	<gtView>
	
	shortcuts ifNil: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Shortcuts';
		items: [ shortcuts associations ];
		column: 'Key Combinatio' text: [ :assoc | assoc key ];
		column: 'Key Combinatio' text: [ :assoc | assoc value ];
		send: [ :assoc | assoc value ]
]

{ #category : #initialization }
BrTextEditorShortcuts >> initialize [
	super initialize.
	
	shortcuts := Dictionary new
]

{ #category : #copying }
BrTextEditorShortcuts >> postCopy [
	shortcuts := shortcuts copy
]

{ #category : #'adding / removing' }
BrTextEditorShortcuts >> remove: anEditorShortcut ifFound: aFoundBlock [
	
	shortcuts
		at: anEditorShortcut combinationForPlatform
		ifPresent: [ :anExistingEditorShortcut |
			anExistingEditorShortcut = anEditorShortcut
				ifTrue: [
					shortcuts removeKey: anEditorShortcut combinationForPlatform.
					aFoundBlock value: anExistingEditorShortcut ] ]
]

{ #category : #'adding / removing' }
BrTextEditorShortcuts >> removeAllShortcutsAndDo: aFoundBlock [
	| theOldShortcuts |
	
	theOldShortcuts := shortcuts.
	shortcuts := Dictionary new.
	theOldShortcuts valuesDo: aFoundBlock
]
