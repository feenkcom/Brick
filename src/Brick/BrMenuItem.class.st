Class {
	#name : #BrMenuItem,
	#superclass : #Object,
	#instVars : [
		'labelModel',
		'isSelected',
		'parent',
		'group',
		'announcer'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #testing }
BrMenuItem class >> isAbstract [
	^ self name = #BrMenuItem
]

{ #category : #'api - announcer' }
BrMenuItem >> announcer [
	^ announcer
]

{ #category : #'api - converting' }
BrMenuItem >> asElement [
	<return: #BlElement>
	^ self labelModel asElement
]

{ #category : #'api - selection' }
BrMenuItem >> deselect [
	^ self isSelected: false
]

{ #category : #'api - grouping' }
BrMenuItem >> group [
	<return: #BrMenuItemGroupConfiguration>
	^ group
]

{ #category : #'api - grouping' }
BrMenuItem >> group: aBrMenuItemGroupConfiguration [
	group := aBrMenuItemGroupConfiguration
]

{ #category : #'api - grouping' }
BrMenuItem >> groupId: aSymbol priority: aPriority [
	self
		group: (BrMenuItemGroupConfiguration new
				name: aSymbol;
				priority: aPriority)
]

{ #category : #'gt - extensions' }
BrMenuItem >> gtItemChildren [
	^ Array empty
]

{ #category : #'gt - extensions' }
BrMenuItem >> gtItemDepth [
	| aDepth |
	aDepth := 1.
	self parentsDo: [ aDepth := aDepth + 1 ].
	^ aDepth
]

{ #category : #'gt - extensions' }
BrMenuItem >> gtItemLabel [
	^ self labelModel ifNotNil: #gtItemLabel
]

{ #category : #'gt - extensions' }
BrMenuItem >> gtItemSelection [
	^ self isSelected
		ifTrue: [ 'selected' ]
		ifFalse: [ 'no' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
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
	announcer := Announcer new.
	isSelected := false.
	group := BrMenuItemGroupConfiguration new.
]

{ #category : #'api - selection' }
BrMenuItem >> isSelected [
	<return: #Boolean>
	^ isSelected
]

{ #category : #'api - selection' }
BrMenuItem >> isSelected: aBoolean [
	isSelected = aBoolean ifTrue: [ ^ self ].
	isSelected := aBoolean.
	self onSelectionChanged.
	self notifySelectionChanged.
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

{ #category : #accessing }
BrMenuItem >> menuType [
	^ self class
]

{ #category : #'event handling' }
BrMenuItem >> notifySelectionChanged [
	announcer announce: (BrMenuItemSelectionChanged new
		menuItem: self;
		isSelected: self isSelected)
]

{ #category : #'event handling' }
BrMenuItem >> onSelectionChanged [
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

{ #category : #'api - selection' }
BrMenuItem >> select [
	^ self isSelected: true
]
