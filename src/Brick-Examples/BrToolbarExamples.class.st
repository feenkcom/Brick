Class {
	#name : #BrToolbarExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Toolbar'
}

{ #category : #accessing }
BrToolbarExamples >> addItemsOnButtonClick [
	<gtExample>
	<label: 'Add toolbar items on a button click'>
	<return: #BrToolbar>
	| aToolbar |
	aToolbar := BrToolbar new.
	aToolbar aptitude: BrMaterialToolbarAptitude.

	aToolbar
		addItem: (BrButton new
				aptitude: BrMaterialToggleLabelledAptitude;
				label: 'Add';
				action: [ | aSize |
					aSize := aToolbar numberOfItems.
					aToolbar
						addItem: (BrButton new
								aptitude: BrMaterialToggleLabelledAptitude;
								label: aToolbar numberOfItems asString;
								action: [ :aWidget | self inform: 'Click on button ' , aWidget label asString ]).
					self assert: aToolbar numberOfItems equals: aSize + 1 ]).
	self assert: aToolbar numberOfItems equals: 1.
	^ aToolbar
]

{ #category : #accessing }
BrToolbarExamples >> addItemsOnButtonClickVertically [
	<gtExample>
	<label: 'Add toolbar items on a button click'>
	<return: #BrToolbar>
	| aToolbar |
	aToolbar := BrToolbar new.
	aToolbar aptitude: BrMaterialToolbarAptitude.

	aToolbar
		addItem: (BrButton new
				aptitude: BrMaterialToggleLabelledAptitude;
				label: 'Add';
				action: [ | aSize |
					aSize := aToolbar numberOfItems.
					aToolbar
						addItem: (BrButton new
								aptitude: BrMaterialToggleLabelledAptitude;
								label: aToolbar numberOfItems asString;
								action: [ :aWidget | self inform: 'Click on button ' , aWidget label asString ]).
					self assert: aToolbar numberOfItems equals: aSize + 1 ]).
	self assert: aToolbar numberOfItems equals: 1.
	^ aToolbar
]

{ #category : #accessing }
BrToolbarExamples >> removeItemsOnButtonClick [
	<gtExample>
	<label: 'Add toolbar items on a button click'>
	<return: #BrToolbar>
	| aToolbar |
	aToolbar := self addItemsOnButtonClick.

	aToolbar
		addItem: (BrButton new
				aptitude: BrMaterialToggleLabelledAptitude;
				label: 'Remove';
				action: [ | aSize anIndex |
					aSize := aToolbar numberOfItems.
					anIndex := (aSize - 3 max: 0) atRandom + 3.
					anIndex <= aSize
						ifTrue: [ aToolbar removeItemAt: anIndex.
							self assert: aToolbar numberOfItems equals: aSize - 1 ] ]).
	self assert: aToolbar numberOfItems equals: 2.
	^ aToolbar
]

{ #category : #accessing }
BrToolbarExamples >> removeItemsOnButtonClickVertically [
	<gtExample>
	<label: 'Add toolbar items on a button click'>
	<return: #BrToolbar>
	| aToolbar |
	aToolbar := self addItemsOnButtonClickVertically.
	aToolbar
		addItem: (BrButton new
				aptitude: BrMaterialToggleLabelledAptitude;
				label: 'Remove';
				action: [ | aSize anIndex |
					aSize := aToolbar numberOfItems.
					anIndex := (aSize - 3 max: 0) atRandom + 3.
					anIndex <= aSize
						ifTrue: [ aToolbar removeItemAt: anIndex.
							self assert: aToolbar numberOfItems equals: aSize - 1 ] ]).
	self assert: aToolbar numberOfItems equals: 2.
	^ aToolbar
]

{ #category : #accessing }
BrToolbarExamples >> toolbar [
	<gtExample>
	<return: #BrToolbar>
	| aToolbar |
	aToolbar := BrToolbar new.
	aToolbar aptitude: BrMaterialToolbarAptitude.
	aToolbar addItem: self toolbarItemHello.
	aToolbar addItem: self toolbarItemGToolkit.
	self assert: aToolbar numberOfItems equals: 2.
	^ aToolbar
]

{ #category : #accessing }
BrToolbarExamples >> toolbarInAContainer [
	<gtExample>
	<return: #BlElement>
	| aContainer |
	aContainer := BlElement new.
	aContainer layout: BlLinearLayout horizontal.
	aContainer
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].
	aContainer addChild: self removeItemsOnButtonClickVertically as: #toolbar.
	^ aContainer
]

{ #category : #accessing }
BrToolbarExamples >> toolbarItemGToolkit [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrMaterialToggleLabelledAptitude;
		label: 'GToolkit';
		action: [ self inform: 'Click on GToolkit' ]
]

{ #category : #accessing }
BrToolbarExamples >> toolbarItemHello [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrMaterialToggleLabelledAptitude;
		label: 'Hello';
		action: [ self inform: 'Click on Hello' ]
]

{ #category : #accessing }
BrToolbarExamples >> verticalToolbar [
	<gtExample>
	<return: #BrToolbar>
	| aToolbar |
	aToolbar := BrToolbar new.
	aToolbar aptitude: BrMaterialToolbarAptitude.
	aToolbar addItem: self toolbarItemHello.
	aToolbar addItem: self toolbarItemGToolkit.
	self assert: aToolbar numberOfItems equals: 2.
	^ aToolbar
]
