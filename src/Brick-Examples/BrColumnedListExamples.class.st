Class {
	#name : #BrColumnedListExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-List'
}

{ #category : #'examples - model' }
BrColumnedListExamples >> addColorIndexColumn [
	<gtExample>
	<return: #BrSimpleListModel>
	| aListModel aColumnModel |
	aListModel := self columnedListModel.
	aColumnModel := aListModel children first.

	aColumnModel column
		title: 'Index';
		stencil: [ :aRowValue :aRowIndex | BrColumnCellLabelStencil new text: aRowIndex asString ].

	self assert: aColumnModel columns size equals: 1.
	self assert: aColumnModel columns first title equals: 'Index'.

	^ aListModel
]

{ #category : #'examples - model' }
BrColumnedListExamples >> addColorNameColumn [
	<gtExample>
	<return: #BrSimpleListModel>
	| aListModel aColumnModel |
	aListModel := self addColorIndexColumn.
	aColumnModel := aListModel children first.

	aColumnModel column
		title: 'Color';
		stencil: [ :aRowValue :aRowIndex | BrColumnCellLabelStencil new text: aRowValue name asString ].

	self assert: aColumnModel columns size equals: 2.
	self assert: aColumnModel columns second title equals: 'Color'.

	^ aListModel
]

{ #category : #'examples - model' }
BrColumnedListExamples >> addColorValueColumn [
	<gtExample>
	<return: #BrSimpleListModel>
	| aListModel aColumnModel |
	aListModel := self addColorNameColumn.
	aColumnModel := aListModel children first.

	aColumnModel column
		title: 'Hex';
		stencil: [ :aRowValue | 
			| aHexString |
			aHexString := aRowValue asHexString.

			BlElement new
				padding: (BlInsets all: 6);
				margin: (BlInsets
						top: 3
						left: 0
						bottom: 3
						right: 0);
				background: (Color fromHexString: aHexString);
				layout: BlLinearLayout horizontal alignCenter;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical fitContent ];
				aptitude: (BrTextLabelAptitude new
						text: '#' , aHexString;
						thin;
						foreground: (Color fromHexString: aHexString) contrastingBlackAndWhiteColor) ].

	self assert: aColumnModel columns size equals: 3.
	self assert: aColumnModel columns third title equals: 'Hex'.

	^ aListModel
]

{ #category : #'examples - scripting' }
BrColumnedListExamples >> addColumnsAndItemsTo: aList [
	aList column
		title: 'Class';
		weight: 1;
		cellStencil: [ BrLabel new
				aptitude: BrGlamorousLabelAptitude new;
				hMatchParent;
				vFitContent ];
		dataBinder: [ :aCellElement :aClass | aCellElement text: aClass name asString ].
	aList column
		title: 'Package';
		weight: 1;
		cellStencil: [ BrLabel new
				aptitude: BrGlamorousLabelAptitude new;
				hMatchParent;
				vFitContent ];
		dataBinder: [ :aCellElement :aClass | aCellElement text: aClass package name asString ].

	aList items: Smalltalk allClasses
]

{ #category : #'examples - instance creation' }
BrColumnedListExamples >> columnedListElement [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
]

{ #category : #'examples - instance creation' }
BrColumnedListExamples >> columnedListLook [
	<gtExample>
	<return: #BrColumnedListAptitude>
	^ BrColumnedListAptitude new
]

{ #category : #'examples - instance creation' }
BrColumnedListExamples >> columnedListModel [
	<gtExample>
	<return: #BrSimpleListModel>
	| aColumnedListModel |
	aColumnedListModel := BrSimpleListModel new.
	aColumnedListModel add: BrColumnedModel new.

	self assert: aColumnedListModel children first columns isEmpty.

	^ aColumnedListModel
]

{ #category : #'examples - model' }
BrColumnedListExamples >> columnedListModelWithColorAsItems [
	<gtExample>
	<return: #BrSimpleListModel>
	| aColumnedListModel |
	aColumnedListModel := self addColorValueColumn.
	aColumnedListModel
		items: (Color registeredColorNames collect: [ :aColorName | Color named: aColorName ]).

	^ aColumnedListModel
]

{ #category : #'examples - performance' }
BrColumnedListExamples >> columnedListWithItemsBindsOnce [
	"This example makes sure that when the list is displayed for the first time, the items are created and bound just once."

	<gtExample>
	<return: #BlScripter>
	| aList aScripter aCreationAmount aBindingAmount theItemsChangedEvents |
	aCreationAmount := 0.
	aBindingAmount := 0.

	aList := BrColumnedList new.
	aList vExact: 300.
	aList column
		title: 'Class';
		cellStencil: [ aCreationAmount := aCreationAmount + 1.
			BrLabel new
				aptitude: BrGlamorousLabelAptitude new;
				hMatchParent;
				vExact: 50 ];
		dataBinder: [ :aCellElement :aClass | 
			aBindingAmount := aBindingAmount + 1.
			aCellElement text: aClass name asString ].

	theItemsChangedEvents := OrderedCollection new.
	aList
		when: BrItemsProviderItemsChangedEvent
		do: [ :anEvent | theItemsChangedEvents add: anEvent ].

	aScripter := BlScripter new.
	aScripter element: aList.

	aScripter
		doStep: [ :s | s action: [ :anElement | anElement items: Smalltalk allClasses ] ].

	self assert: aCreationAmount equals: 6.
	self assert: aBindingAmount equals: 6.
	self assert: theItemsChangedEvents size equals: 1.
	self assert: theItemsChangedEvents first isSynchronous.

	^ aScripter
]

{ #category : #'examples - list' }
BrColumnedListExamples >> columnedListWithLookAndModelForColors [
	<gtExample>
	<return: #BlElement>
	| aColumnedListElement aColumnedListModel aColumnedListLook |
	aColumnedListElement := self columnedListElement.
	aColumnedListModel := self columnedListModelWithColorAsItems.
	aColumnedListLook := self columnedListLook.

	aColumnedListElement viewModel: aColumnedListModel.
	aColumnedListElement aptitude: aColumnedListLook.

	^ aColumnedListElement
]

{ #category : #'examples - scripting' }
BrColumnedListExamples >> compositeAllClassesAndPackage [
	<gtExample>
	<return: #BrColumnedList>
	| aList |
	aList := BrColumnedList new.
	self addColumnsAndItemsTo: aList.
	^ aList
]

{ #category : #'examples - scripting' }
BrColumnedListExamples >> compositeAllClassesAndPackageMultiSelect [
	<gtExample>
	<return: #BrColumnedList>
	^ self compositeAllClassesAndPackage aptitude: BrColumnedMultiListAptitude new
]

{ #category : #'examples - scripting' }
BrColumnedListExamples >> compositeAllClassesAndPackageWithHeadersAfter [
	<gtExample>
	<return: #BrColumnedList>
	| aList query header |
	aList := BrColumnedList new.
	self addColumnsAndItemsTo: aList.
	aList addAptitude: BrColumnedListHeaderAptitude.
	query := aList query // #'column-header'.
	self assert: query isNotEmpty.
	header := query anyOne.
	self assert: header children size = 2.
	self assert: header children first text asString = 'Class'.
	self assert: header children second text asString = 'Package'.
	^ aList
]

{ #category : #'examples - scripting' }
BrColumnedListExamples >> compositeAllClassesAndPackageWithHeadersBefore [
	<gtExample>
	<return: #BlScripter>
	| query header scripter |
	scripter := BlScripter new.
	scripter
		element: (BrColumnedList new
				addAptitude: BrColumnedListHeaderAptitude;
				yourself).
	scripter doStep: [ :s | s action: [ :list | self addColumnsAndItemsTo: list ] ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Check header exists';
				do: [ :list | 
					query := list query // #'column-header'.
					self assert: query isNotEmpty.
					header := query anyOne.
					self assert: header children size = 2.
					self assert: header children first text asString = 'Class'.
					self assert: header children second text asString = 'Package' ] ].
	^ scripter
]

{ #category : #'examples - scripting' }
BrColumnedListExamples >> compositeAllClassesAndPackageWithIndex [
	<gtExample>
	<return: #BrColumnedList>
	| aList |
	aList := BrColumnedList new.
	aList column
		title: 'Index';
		stencil: [ :aClass :anIndex | 
			BlTextElement new
				width: 30;
				margin: (BlInsets all: 3);
				text: (anIndex asString asRopedText foreground: Color gray) ].
	aList column
		title: 'Class';
		stencil: [ :aClass | (BrColumnCellLabelStencil new text: aClass name asString) asElement width: 200 ].
	aList column
		title: 'Package';
		stencil: [ :aClass | BrColumnCellLabelStencil new text: aClass package name asString ].
	aList items: Smalltalk allClasses.
	^ aList
]

{ #category : #'examples - scripting' }
BrColumnedListExamples >> compositeAllClassesAndPackageWithIndexUsingBuilders [
	<gtExample>
	<return: #BrColumnedList>
	| aList |
	aList := BrColumnedList new.
	aList items: Smalltalk allClasses.
	aList column
		title: 'Index';
		stencil: [ :aClass :anIndex | 
			BlTextElement new
				width: 30;
				margin: (BlInsets all: 3);
				text: (anIndex asString asRopedText foreground: Color gray) ].
	aList column
		title: 'Class';
		stencil: [ :aClass | BrColumnCellLabelStencil new text: aClass name asString ].
	aList column
		title: 'Package';
		stencil: [ :aClass | BrColumnCellLabelStencil new text: aClass package name asString ].
	^ aList
]

{ #category : #'examples - scripting' }
BrColumnedListExamples >> compositeAllClassesSingleColumn [
	<gtExample>
	<return: #BrColumnedList>
	| aList |
	aList := BrColumnedList new.
	aList items: Smalltalk allClasses.
	aList column title: 'Class'.
	^ aList
]

{ #category : #'examples - stencil' }
BrColumnedListExamples >> createColumnedListRowDefault [
	<gtExample>
	<return: #BlElement>
	| aStencilBuilder aRowElement |
	aStencilBuilder := BrColumnedListRowStencilBuilder new.
	aStencilBuilder rowValue: 'Hello'.
	aStencilBuilder rowIndex: 1.

	aRowElement := aStencilBuilder build asElement.

	self assert: (aRowElement layout isKindOf: BlLinearLayout).
	self assert: aRowElement layout isHorizontal.
	self assert: aRowElement hasChildren not.

	^ aRowElement
]

{ #category : #'examples - stencil' }
BrColumnedListExamples >> createColumnedListRowWithBlock [
	<gtExample>
	<return: #BlTextElement>
	| aStencilBuilder aRowElement |
	aStencilBuilder := [ :aRowValue :aRowIndex | BlTextElement text: (aRowValue asString , '-' , aRowIndex asString) asRopedText ]
			asStencil: BrListRowStencilBuilder.
	aStencilBuilder rowValue: 'Hello'.
	aStencilBuilder rowIndex: 1.

	aRowElement := aStencilBuilder build asElement.

	self assert: (aRowElement isKindOf: BlTextElement).
	self assert: aRowElement text asString equals: 'Hello-1'.

	^ aRowElement
]

{ #category : #'examples - column' }
BrColumnedListExamples >> listColumn [
	<gtExample>
	<return: #BrColumn>
	| aListColumn |
	aListColumn := BrColumn new.

	self assert: aListColumn title equals: 'Column'.

	^ aListColumn
]

{ #category : #'examples - column' }
BrColumnedListExamples >> listColumnWithTitle [
	<gtExample>
	<return: #BrColumn>
	| aListColumn |
	aListColumn := self listColumn.
	aListColumn title: 'Custom property'.

	self assert: aListColumn title equals: 'Custom property'.

	^ aListColumn
]

{ #category : #'examples - scripting' }
BrColumnedListExamples >> scripterOnCompositeAllClassesAndPackageMultiSelect [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := BlScripter new
			element: self compositeAllClassesAndPackageMultiSelect.

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check that nothing is selected';
				satisfies: [ :anElement | anElement selectedIndices isEmpty ] ].

	^ aScripter
]

{ #category : #'examples - scripting' }
BrColumnedListExamples >> scripterOnSubclassesOfCollectionMultiSelectSelected [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripterOnCompositeAllClassesAndPackageMultiSelect.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Select items in list';
				id: #scrollable;
				onChildAt: 2 ].


	aScripter
		clickStep: [ :s | 
			s
				label: 'Select items in list';
				id: #scrollable;
				onChildAt: 5;
				modifiers: BlKeyModifiers shift ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check that selection works';
				satisfies: [ :anElement | anElement selectedIndices size = 4 ] ].

	^ aScripter
]

{ #category : #'examples - scripting' }
BrColumnedListExamples >> scripterOnSubclassesOfCollectionMultiSelectSelectedDiscontinuous [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripterOnSubclassesOfCollectionMultiSelectSelected.


	aScripter
		clickStep: [ :s | 
			s
				label: 'Select discontinuous item in list';
				id: #scrollable;
				onChildAt: 7;
				modifiers: BlKeyModifiers primary ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check that discontinuous selection works';
				satisfies: [ :anElement | anElement selectedIndices size = 5 ] ].

	^ aScripter
]
