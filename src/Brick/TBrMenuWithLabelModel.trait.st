Trait {
	#name : #TBrMenuWithLabelModel,
	#instVars : [
		'labelModel'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #initialization }
TBrMenuWithLabelModel >> defaultLabelModel [
	^ BrMenuTextLabelModel new
]

{ #category : #initialization }
TBrMenuWithLabelModel >> ensureIconTextLabelModel [
	labelModel class = BrMenuIconTextLabelModel
		ifFalse: [ labelModel := BrMenuIconTextLabelModel new ].

	^ labelModel
]

{ #category : #initialization }
TBrMenuWithLabelModel >> ensureTextLabelModel [
	labelModel class = BrMenuTextLabelModel
		ifFalse: [ labelModel := BrMenuTextLabelModel new ].

	^ labelModel
]

{ #category : #'api - label model' }
TBrMenuWithLabelModel >> icon: anIconStencil label: aLabelString [
	self ensureIconTextLabelModel
		icon: anIconStencil;
		text: aLabelString
]

{ #category : #'api - label model' }
TBrMenuWithLabelModel >> icon: anIconStencil label: aLabelString preview: aPreviewString [
	self ensureIconTextLabelModel
		icon: anIconStencil;
		text: aLabelString;
		preview: aPreviewString
]

{ #category : #'api - label model' }
TBrMenuWithLabelModel >> icon: anIconStencil label: aLabelString preview: aPreviewString shortcut: aShortcutString [
	self ensureIconTextLabelModel
		icon: anIconStencil;
		text: aLabelString;
		preview: aPreviewString;
		shortcut: aShortcutString
]

{ #category : #'api - label model' }
TBrMenuWithLabelModel >> icon: anIconStencil label: aLabelString shortcut: aShortcutString [
	self ensureIconTextLabelModel
		icon: anIconStencil;
		text: aLabelString;
		shortcut: aShortcutString
]

{ #category : #initialization }
TBrMenuWithLabelModel >> initializeLabelModel [
	labelModel := self defaultLabelModel
]

{ #category : #'api - label model' }
TBrMenuWithLabelModel >> label: aLabelString [
	self ensureTextLabelModel text: aLabelString
]

{ #category : #'api - label model' }
TBrMenuWithLabelModel >> label: aLabelString preview: aPreviewString [
	self ensureTextLabelModel
		text: aLabelString;
		preview: aPreviewString
]

{ #category : #'api - label model' }
TBrMenuWithLabelModel >> label: aLabelString preview: aPreviewString shortcut: aShortcutString [
	self ensureTextLabelModel
		text: aLabelString;
		preview: aPreviewString;
		shortcut: aShortcutString
]

{ #category : #'api - label model' }
TBrMenuWithLabelModel >> label: aLabelString shortcut: aShortcutString [
	self ensureTextLabelModel
		text: aLabelString;
		shortcut: aShortcutString
]

{ #category : #'api - label model' }
TBrMenuWithLabelModel >> labelModel [
	^ labelModel ifNil: [ labelModel := self defaultLabelModel ]
]

{ #category : #'api - label model' }
TBrMenuWithLabelModel >> labelModel: aLabelModel [
	labelModel := aLabelModel
]
