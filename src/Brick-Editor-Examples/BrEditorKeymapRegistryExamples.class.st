"
I contain examples for BrEditorKeymapRegistry verifying that all editor keyboard shortcuts are properly registered.
"
Class {
	#name : #BrEditorKeymapRegistryExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples-Shortcuts'
}

{ #category : #examples }
BrEditorKeymapRegistryExamples >> allEntriesHaveShortcutId [
	<gtExample>
	<return: #BrEditorKeymapRegistry>
	"Verifies that every entry in the editor registry has its shortcutId set"
	| registry |
	registry := self editorKeymapRegistry.
	(registry instVarNamed: 'keymaps') keysAndValuesDo: [ :shortcutId :entry |
		self assert: entry shortcutId notNil.
		self assert: entry shortcutId equals: shortcutId ].
	^ registry
]

{ #category : #examples }
BrEditorKeymapRegistryExamples >> carriageReturnCombination [
	<gtExample>
	<return: #BlKeyCombination>
	| registry combination |
	registry := self editorKeymapRegistry.
	combination := registry combinationFor: BrEditorShortcutIds default carriageReturnShortcutId.
	self assert: combination notNil.
	^ combination
]

{ #category : #examples }
BrEditorKeymapRegistryExamples >> copyCombination [
	<gtExample>
	<return: #BlKeyCombination>
	| registry combination |
	registry := self editorKeymapRegistry.
	combination := registry combinationFor: BrEditorShortcutIds default copyShortcutId.
	self assert: combination notNil.
	^ combination
]

{ #category : #examples }
BrEditorKeymapRegistryExamples >> editorKeymapRegistry [
	<gtExample>
	<return: #BrEditorKeymapRegistry>
	| registry |
	registry := BrEditorKeymapRegistry new.
	self assert: registry numberOfKeymaps >= 38.
	^ registry
]

{ #category : #examples }
BrEditorKeymapRegistryExamples >> loseFocusCombination [
	<gtExample>
	<return: #BlKeyCombination>
	| registry combination |
	registry := self editorKeymapRegistry.
	combination := registry combinationFor: BrEditorShortcutIds default loseFocusShortcutId.
	self assert: combination notNil.
	^ combination
]

{ #category : #examples }
BrEditorKeymapRegistryExamples >> macOsOverrideEntryHasShortcutId [
	<gtExample>
	<return: #BlRegistryKeymapEntry>
	"Verifies that entries with macOS overrides have shortcutId set correctly"
	| registry entry shortcutId |
	registry := self editorKeymapRegistry.
	shortcutId := BrEditorShortcutIds default moveCursorToNextWordShortcutId.
	entry := registry keymapFor: shortcutId.
	self assert: entry shortcutId equals: shortcutId.
	self assert: entry combination notNil.
	self assert: entry combinationForMacOS notNil.
	self assert: entry combination ~= entry combinationForMacOS.
	^ entry
]

{ #category : #examples }
BrEditorKeymapRegistryExamples >> macOsOverrideResolves [
	<gtExample>
	<return: #BrEditorShortcut>
	"Verifies that a shortcut with a macOS override resolves differently for macOS"
	| shortcut defaultCombo macOsCombo |
	shortcut := BrEditorShortcut moveCursorToNextWord.
	self assert: shortcut shortcutId notNil.
	defaultCombo := shortcut combination.
	macOsCombo := shortcut combinationForMacOS.
	self assert: defaultCombo notNil.
	self assert: macOsCombo notNil.
	self assert: defaultCombo ~= macOsCombo.
	^ shortcut
]

{ #category : #examples }
BrEditorKeymapRegistryExamples >> moveCursorLeftCombination [
	<gtExample>
	<return: #BlKeyCombination>
	| registry combination |
	registry := self editorKeymapRegistry.
	combination := registry combinationFor: BrEditorShortcutIds default moveCursorLeftShortcutId.
	self assert: combination notNil.
	^ combination
]

{ #category : #examples }
BrEditorKeymapRegistryExamples >> moveCursorToNextWordCombination [
	<gtExample>
	<return: #BlKeyCombination>
	| registry combination macOsCombination |
	registry := self editorKeymapRegistry.
	combination := registry combinationFor: BrEditorShortcutIds default moveCursorToNextWordShortcutId.
	macOsCombination := registry combinationForMacOSFor: BrEditorShortcutIds default moveCursorToNextWordShortcutId.
	self assert: combination notNil.
	self assert: macOsCombination notNil.
	self assert: combination ~= macOsCombination.
	^ combination
]

{ #category : #examples }
BrEditorKeymapRegistryExamples >> newLineCombination [
	<gtExample>
	<return: #BlKeyCombination>
	| registry combination |
	registry := self editorKeymapRegistry.
	combination := registry combinationFor: BrEditorShortcutIds default newLineShortcutId.
	self assert: combination notNil.
	^ combination
]

{ #category : #examples }
BrEditorKeymapRegistryExamples >> selectAllCombination [
	<gtExample>
	<return: #BlKeyCombination>
	| registry combination |
	registry := self editorKeymapRegistry.
	combination := registry combinationFor: BrEditorShortcutIds default selectAllShortcutId.
	self assert: combination notNil.
	^ combination
]

{ #category : #examples }
BrEditorKeymapRegistryExamples >> shortcutResolvesFromRegistry [
	<gtExample>
	<return: #BrEditorShortcut>
	"Verifies that a shortcut constructed via the class-side factory resolves its combination from the registry"
	| shortcut |
	shortcut := BrEditorShortcut selectAll.
	self assert: shortcut shortcutId notNil.
	self assert: shortcut combination notNil.
	self assert: shortcut combinationForPlatform notNil.
	^ shortcut
]

{ #category : #examples }
BrEditorKeymapRegistryExamples >> undoCombination [
	<gtExample>
	<return: #BlKeyCombination>
	| registry combination |
	registry := self editorKeymapRegistry.
	combination := registry combinationFor: BrEditorShortcutIds default undoShortcutId.
	self assert: combination notNil.
	^ combination
]
