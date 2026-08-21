Extension { #name : #BlShortcutKeymapRegistry }

{ #category : #'*Brick-Editor' }
BlShortcutKeymapRegistry >> editor [
	<gtKeymapRegistry>
	^ self ensureRegistryCategoryOfType: BrEditorKeymapRegistry
]
