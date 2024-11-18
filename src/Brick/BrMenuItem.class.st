Class {
	#name : #BrMenuItem,
	#superclass : #Object,
	#instVars : [
		'labelModel',
		'isSelected',
		'parent'
	],
	#category : #'Brick-Menu'
}

{ #category : #'gt - extensions' }
BrMenuItem >> gtItemChildren [
	^ Array empty
]

{ #category : #'gt - extensions' }
BrMenuItem >> gtItemLabel [
	^ self labelModel ifNotNil: #gtItemLabel
]

{ #category : #'gt - extensions' }
BrMenuItem >> gtParentsFor: aView [
	<gtView>
	self parent ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Parents';
		items: [ Array
				streamContents: [ :aStream | self parentsDo: [ :aParent | aStream nextPut: aParent ] ] ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 40;
		column: 'Parent' text: #gtItemLabel
]

{ #category : #initialization }
BrMenuItem >> initialize [
	super initialize.
	isSelected := false
]

{ #category : #accessing }
BrMenuItem >> isSelected [
	<return: #Boolean>
	^ isSelected
]

{ #category : #accessing }
BrMenuItem >> isSelected: aBoolean [
	isSelected := aBoolean
]

{ #category : #'api - label model' }
BrMenuItem >> label: aLabelString [
	self labelModel: (BrMenuTextLabelModel new text: aLabelString)
]

{ #category : #'api - label model' }
BrMenuItem >> label: aLabelString preview: aPreviewString [
	self
		labelModel: (BrMenuTextLabelModel new
				text: aLabelString;
				preview: aPreviewString)
]

{ #category : #'api - label model' }
BrMenuItem >> label: aLabelString preview: aPreviewString shortcut: aShortcutString [
	self
		labelModel: (BrMenuTextLabelModel new
				text: aLabelString;
				preview: aPreviewString;
				shortcut: aShortcutString)
]

{ #category : #'api - label model' }
BrMenuItem >> label: aLabelString shortcut: aShortcutString [
	self
		labelModel: (BrMenuTextLabelModel new
				text: aLabelString;
				shortcut: aShortcutString)
]

{ #category : #'api - label model' }
BrMenuItem >> labelModel [
	^ labelModel
]

{ #category : #'api - label model' }
BrMenuItem >> labelModel: aLabelModel [
	labelModel := aLabelModel
]

{ #category : #'api - parent' }
BrMenuItem >> parent [
	<return: #BrMenuItem or: nil>
	^ parent
]

{ #category : #'api - parent' }
BrMenuItem >> parent: aMenuItem [
	parent := aMenuItem
]

{ #category : #'api - parent' }
BrMenuItem >> parentsDo: aBlock [
	parent ifNotNil: [ :aParent |
		aBlock cull: aParent.
		aParent parentsDo: aBlock ]
]
