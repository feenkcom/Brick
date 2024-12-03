Trait {
	#name : #TBrMenuWithTextLabelModel,
	#instVars : [
		'labelModel'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #initialization }
TBrMenuWithTextLabelModel >> initializeLabelModel [
	labelModel := BrMenuTextLabelModel new
]

{ #category : #'api - label model' }
TBrMenuWithTextLabelModel >> label: aLabelString [
	self labelModel text: aLabelString
]

{ #category : #'api - label model' }
TBrMenuWithTextLabelModel >> label: aLabelString preview: aPreviewString [
	self labelModel
		text: aLabelString;
		preview: aPreviewString
]

{ #category : #'api - label model' }
TBrMenuWithTextLabelModel >> label: aLabelString preview: aPreviewString shortcut: aShortcutString [
	self labelModel
		text: aLabelString;
		preview: aPreviewString;
		shortcut: aShortcutString
]

{ #category : #'api - label model' }
TBrMenuWithTextLabelModel >> label: aLabelString shortcut: aShortcutString [
	self labelModel
		text: aLabelString;
		shortcut: aShortcutString
]

{ #category : #'api - label model' }
TBrMenuWithTextLabelModel >> labelModel [
	^ labelModel ifNil: [ labelModel := BrMenuTextLabelModel new ]
]
