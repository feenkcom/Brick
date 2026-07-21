Class {
	#name : #BrEditorKeymapRegistry,
	#superclass : #BlKeymapRegistryCategory,
	#category : #'Brick-Editor-Shortcuts'
}

{ #category : #accessing }
BrEditorKeymapRegistry class >> registryLabel [
	^'Editor'
]

{ #category : #'accessing - defaults' }
BrEditorKeymapRegistry >> defaultLoseFocusShortcutIdCombination [
	^BlKeyCombination escape
]

{ #category : #'accessing - defaults' }
BrEditorKeymapRegistry >> defaultNewLineShortcutIdShortcutCombination [
	^BlKeyCombination return
]

{ #category : #initialize }
BrEditorKeymapRegistry >> initializeBasicCombinations [
	super initializeBasicCombinations.
	
	self 
		initializeShortcut: BrEditorShortcutIds default newLineShortcutId 
		with: self defaultNewLineShortcutIdShortcutCombination   .
	self 
		initializeShortcut: BrEditorShortcutIds default loseFocusShortcutId 
		with: self defaultLoseFocusShortcutIdCombination   
]
