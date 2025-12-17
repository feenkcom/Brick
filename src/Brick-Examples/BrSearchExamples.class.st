Class {
	#name : #BrSearchExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Search'
}

{ #category : #examples }
BrSearchExamples >> simpleListWithLabelItem [
	<gtExample>
	| simpleListSearchDialog simpleList |
	simpleListSearchDialog := BrSearchTextElement new.
	simpleList := BrSimpleList new
			itemStencil: [ :anItemType :aListWidget | 
				BrLabel new
					hMatchParent;
					aptitude: GtCoderNavigationTreeLabelAptitude;
					addAptitude: BrGlamorousListItemAptitude;
					addAptitude: BrSearchMarkableLabelAptitude ];
			itemDataBinder: [ :anItemElement :anItemObject :anItemIndex | 
				anItemElement dispatchEvent: (BrSearchItemIdWish new itemId: anItemObject).
				anItemElement text: anItemObject selector ];
			items: (BrSearchDummyOneObject methods sort: GtMethodsSortFunction new).
	simpleList
		addAptitude: (BrSearchTextProvidedInputAptitude new
				searchSource: (BrSearchListElementSource new 
					listElement: simpleList;
					itemText: [ :anItemObject | anItemObject selector ]);
				searchElement: simpleListSearchDialog).
	^ BrVerticalPane new
		border: (BlTheme default default darkBorderColor);
		cellSpacing: 5;
		padding: (BlInsets all: 10);
		matchParent;
		addChild: simpleListSearchDialog as: #search;
		addChild: simpleList as: #methods
]

{ #category : #examples }
BrSearchExamples >> simpleListWithLabelItem_01_searchT [
	<gtExample>
	| element scripter |
	element := self simpleListWithLabelItem.
	scripter := BlScripter new element: element.

	scripter editor
		label: 'Search t character';
		click;
		typeText: 't';
		// #pattern;
		play.

	scripter assert
		value: [ :aLabel | aLabel text asString ] equals: '36+';
		// #index;
		play.

	^ scripter
]

{ #category : #examples }
BrSearchExamples >> simpleListWithLabelItem_02_scrollDown [
	<gtExample>
	<noTest>
	| scripter |
	self flag: #todo.
	scripter := self simpleListWithLabelItem_01_searchT.

	scripter mouseWheel
		downBy: 50;
		// #methods;
		play.

	scripter assert
		value: [ :aLabel | 
				| allMarks |
				allMarks := OrderedCollection new.
				aLabel text attributesFinder
					findAttributesSuchThat: [ :eachAttribute | 
						eachAttribute class = BrSearchTextMarkAttribute ]
					indicesDo: [ :eachStart :eachEnd :eachAttribute | 
						allMarks
							add: {eachStart.
									eachEnd} ].
				allMarks asArray ]
			equals: #(#(10 10) #(14 14) #(23 23) #(25 25));
		/ #methods;
		// BrLabel;
		@ [ :aLabel | aLabel text asString = #hasPropertiesToPropagateToChildren ];
		play.

	^ scripter
]
