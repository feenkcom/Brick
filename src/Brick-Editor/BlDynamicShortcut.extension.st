Extension { #name : #BlDynamicShortcut }

{ #category : #'*Brick-Editor' }
BlDynamicShortcut >> editorShortcutId: anId [
	self 
		shortcutId: anId inRegistry: BlShortcutKeymapRegistry default editor
]
