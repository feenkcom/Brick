Class {
	#name : #BrFolderCreateWidget,
	#superclass : #BrWidgetContainer,
	#traits : 'TBrLayoutAlignable',
	#classTraits : 'TBrLayoutAlignable classTrait',
	#instVars : [
		'folder',
		'container',
		'label',
		'button',
		'onFolderCreated'
	],
	#category : #Brick
}

{ #category : #accessing }
BrFolderCreateWidget >> createButton [
	^ BrButton new
				icon: BrGlamorousIcons accept;
				aptitude: (BrGlamorousButtonRectangularAptitude new + BrGlamorousButtonIconAptitude new+BrGlamorousButtonExteriorAptitude new);
				disable
]

{ #category : #accessing }
BrFolderCreateWidget >> createLabel [
	^ BrEditableLabel new
		aptitude: BrGlamorousEditableLabelAptitude new glamorousRegularFontAndSize;
		switchToEditor;
		addShortcut: (BlShortcutWithAction new
				name: 'Accept';
				description: 'Accepts the current edition.';
				combination: BlKeyCombination enter;
				action: [ :anEvent | anEvent target acceptEdition ]);
		text: 'Double click me'
]

{ #category : #accessing }
BrFolderCreateWidget >> defaultFolderName: anObject [ 
	label text: anObject.
	(folder / anObject) exists ifFalse: [button enable]; ifTrue:[button disable].
]

{ #category : #accessing }
BrFolderCreateWidget >> folder: aFolderReference [
	folder := aFolderReference
]

{ #category : #accessing }
BrFolderCreateWidget >> initialize [
	super initialize.
	
	self viewModel: BrWidgetModel new.
	self layout: BlLinearLayout horizontal.
	self aptitude: BrLayoutAlignmentStatelessAptitude new.

	self hMatchParent.
	self vFitContent.
	self alignCenter.

	label := self createLabel.
	button := self createButton.
	self addChild: label.
	self addChild: button.
	label editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | 
			(folder / anEvent text asString) exists
				ifTrue: [ button disable ];
				ifFalse: [ button enable ] ].
	button
		action: [ (folder / label text asString) ensureCreateDirectory.
			button disable.
			onFolderCreated
				ifNotNil: [ onFolderCreated cull: folder / label text asString ] ]
]

{ #category : #accessing }
BrFolderCreateWidget >> label [
	^ label
]

{ #category : #accessing }
BrFolderCreateWidget >> label: anObject [
	label := anObject
]

{ #category : #accessing }
BrFolderCreateWidget >> onFolderCreated: aBlock [
	onFolderCreated := aBlock.
]

{ #category : #accessing }
BrFolderCreateWidget >> requestLabelFocus [
	label requestFocus.
]
