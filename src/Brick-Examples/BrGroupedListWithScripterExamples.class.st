Class {
	#name : #BrGroupedListWithScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Brick-Examples'
}

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> emptyMultiSelection [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithElement: [ BrGroupedListExamples new emptyMultiSelection ].

	self waitForDisplayedItems: aScripter.

	aScripter assert
		label: 'Assert no selection';
		value: [ :aList | aList selectedItems size ] equals: 0;
		play.

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> emptyMultiSelection_selectFirst [
	<gtExample>
	| aScripter |
	aScripter := self emptyMultiSelection.
	aScripter
		substeps: 'Select first'
		do: [ :anotherStep | 
			anotherStep do
				label: 'Select first';
				block: [ :aList | aList selectFirst ];
				play.

			anotherStep assert
				label: 'Assert nothing selected';
				value: [ :aList | aList selectedItems sort: [ :a :b | a < b ] ] equals: #();
				play ].

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> emptyMultiSelection_selectLast [
	<gtExample>
	| aScripter |
	aScripter := self emptyMultiSelection.
	aScripter
		substeps: 'Select last'
		do: [ :anotherStep | 
			anotherStep do
				label: 'Select last';
				block: [ :aList | aList selectLast ];
				play.

			anotherStep assert
				label: 'Assert nothing selected';
				value: [ :aList | aList selectedItems sort: [ :a :b | a < b ] ] equals: #();
				play ].

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithElement: [ BrGroupedListExamples new multiSelection ].

	self waitForDisplayedItems: aScripter.
			
	aScripter assert
		label: 'Assert no selection';
		value: [ :aList | aList selectedItems size ] equals: 0;
		play.

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelectionWithEmptyGroup [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithElement: [ BrGroupedListExamples new multiSelectionWithEmptyGroup ].

	self waitForDisplayedItems: aScripter.

	aScripter assert
		label: 'Assert no selection';
		value: [ :aList | aList selectedItems size ] equals: 0;
		play.

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelectionWithEmptyGroup_selectAll [
	<gtExample>
	| aScripter |
	aScripter := self multiSelectionWithEmptyGroup.
	aScripter
		substeps: 'Select all'
		do: [ :anotherStep | 
			anotherStep do
				label: 'Select all';
				block: [ :aList | aList selectAll ];
				play.

			anotherStep assert
				label: 'Assert all items selected';
				value: [ :aList | aList selectedItems sort: [ :a :b | a < b ] ]
					equals: (1 to: 20) asArray;
				play ].

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelectionWithEmptyGroup_selectLast [
	<gtExample>
	| aScripter |
	aScripter := self multiSelectionWithEmptyGroup.
	aScripter
		substeps: 'Select last'
		do: [ :anotherStep | 
			anotherStep do
				label: 'Select last';
				block: [ :aList | aList selectLast ];
				play.

			anotherStep assert
				label: 'Assert 19 selected';
				value: [ :aList | aList selectedItems sort: [ :a :b | a < b ] ]
					equals: #(19);
				play ].

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection_select1 [
	<gtExample>
	| aScripter |
	aScripter := self multiSelection.
	self step: aScripter selectNumber: 1.

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection_select18 [
	<gtExample>
	| aScripter |
	aScripter := self multiSelection.
	self step: aScripter selectNumber: 18.

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection_select18to3 [
	<gtExample>
	| aScripter |
	aScripter := self multiSelection_select18.
	
	aScripter click
		label: 'Primary+click on label 3';
		modifiers: (BlKeyModifiers primary shift: true);
		// #scrollable;
		onChildFromBlock: [ :anInfiniteList | 
			anInfiniteList children
				detect: [ :eachLabel | eachLabel text asString asInteger = 3 ] ];
		play.

	aScripter assert
		label: 'Assert selected items are 18, 20, 1, and 3';
		satisfies: [ :aList | 
			| allItems |
			allItems := aList selectedItems.
			allItems size = 4 and: [ allItems = #(18 20 1 3) ] ];
		play.

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection_select19 [
	<gtExample>
	| aScripter |
	aScripter := self multiSelection.
	self step: aScripter selectNumber: 19.

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection_select19_selectNext [
	<gtExample>
	| aScripter |
	aScripter := self multiSelection_select19.

	aScripter keyPress
		label: 'Select next item';
		key: BlKeyboardKey arrowDown;
		play.

	aScripter assert
		label: 'Assert selected items is 19';
		value: [ :aList | aList selectedItems ] equals: [ :aList | #(19) ];
		play.

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection_select1To14DueTo [
	<gtExample>
	| aScripter |
	aScripter := self multiSelection.
	aScripter
		substeps: 'Select 1 to 14 indexes'
		do: [ :anotherStep | 
			anotherStep do
				label: 'Select one at 1';
				block: [ :aList | 
					aList
						select: 1
						to: 14
						dueTo: nil ];
				play.

			anotherStep assert
				label: 'Assert even items, 1, and 3 items selected';
				value: [ :aList | aList selectedItems sort: [ :a :b | a < b ] ]
					equals: #(1 2 3 4 6 8 10 12 14 16 18 20);
				play ].

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection_select1_selectPrevious [
	<gtExample>
	| aScripter |
	aScripter := self multiSelection_select1.

	aScripter keyPress
		label: 'Select previous item';
		key: BlKeyboardKey arrowUp;
		play.

	aScripter assert
		label: 'Assert selected items is 20';
		value: [ :aList | aList selectedItems ] equals: [ :aList | #(20) ];
		play.

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection_select2 [
	<gtExample>
	| aScripter |
	aScripter := self multiSelection.
	self step: aScripter selectNumber: 2.

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection_select20 [
	<gtExample>
	| aScripter |
	aScripter := self multiSelection.
	self step: aScripter selectNumber: 20.

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection_select20_selectNext [
	<gtExample>
	| aScripter |
	aScripter := self multiSelection_select20.

	aScripter keyPress
		label: 'Select next item';
		key: BlKeyboardKey arrowDown;
		play.

	aScripter assert
		label: 'Assert selected items is 1';
		value: [ :aList | aList selectedItems ] equals: [ :aList | #(1) ];
		play.

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection_select2_selectPrevious [
	<gtExample>
	| aScripter |
	aScripter := self multiSelection_select2.

	aScripter keyPress
		label: 'Select previous item';
		key: BlKeyboardKey arrowUp;
		play.

	aScripter assert
		label: 'Assert selected items is 2';
		value: [ :aList | aList selectedItems ] equals: [ :aList | #(2) ];
		play.

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection_selectAll [
	<gtExample>
	| aScripter |
	aScripter := self multiSelection.
	aScripter
		substeps: 'Select all'
		do: [ :anotherStep | 
			anotherStep do
				label: 'Select all';
				block: [ :aList | aList selectAll ];
				play.

			anotherStep assert
				label: 'Assert all items selected';
				value: [ :aList | aList selectedItems sort: [ :a :b | a < b ] ]
					equals: (1 to: 20) asArray;
				play ].

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection_selectFirst [
	<gtExample>
	| aScripter |
	aScripter := self multiSelection.
	aScripter
		substeps: 'Select first'
		do: [ :anotherStep | 
			anotherStep do
				label: 'Select first';
				block: [ :aList | aList selectFirst ];
				play.

			anotherStep assert
				label: 'Assert 2 selected';
				value: [ :aList | aList selectedItems sort: [ :a :b | a < b ] ]
					equals: #(2);
				play ].

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection_selectLast [
	<gtExample>
	| aScripter |
	aScripter := self multiSelection.
	aScripter
		substeps: 'Select last'
		do: [ :anotherStep | 
			anotherStep do
				label: 'Select last';
				block: [ :aList | aList selectLast ];
				play.

			anotherStep assert
				label: 'Assert 19 selected';
				value: [ :aList | aList selectedItems sort: [ :a :b | a < b ] ]
					equals: #(19);
				play ].

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection_selectOne1 [
	<gtExample>
	| aScripter |
	aScripter := self multiSelection.
	aScripter
		substeps: 'Select one at 1'
		do: [ :anotherStep | 
			anotherStep do
				label: 'Select one at 1';
				block: [ :aList | aList selectOne: 1 ];
				play.

			anotherStep assert
				label: 'Assert nothing selected';
				value: [ :aList | aList selectedItems sort: [ :a :b | a < b ] ] equals: #();
				play ].

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection_selectOne1DueTo [
	<gtExample>
	| aScripter |
	aScripter := self multiSelection.
	aScripter
		substeps: 'Select one at 1'
		do: [ :anotherStep | 
			anotherStep do
				label: 'Select one at 1';
				block: [ :aList | aList selectOne: 1 dueTo: nil ];
				play.

			anotherStep assert
				label: 'Assert nothing selected';
				value: [ :aList | aList selectedItems sort: [ :a :b | a < b ] ] equals: #();
				play ].

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection_selectOne2 [
	<gtExample>
	| aScripter |
	aScripter := self multiSelection.
	aScripter
		substeps: 'Select one at 2'
		do: [ :anotherStep | 
			anotherStep do
				label: 'Select one at 2';
				block: [ :aList | aList selectOne: 2 ];
				play.

			anotherStep assert
				label: 'Assert nothing selected';
				value: [ :aList | aList selectedItems sort: [ :a :b | a < b ] ]
					equals: #(2);
				play ].

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection_selectOne2DueTo [
	<gtExample>
	| aScripter |
	aScripter := self multiSelection.
	aScripter
		substeps: 'Select one at 2'
		do: [ :anotherStep | 
			anotherStep do
				label: 'Select one at 2';
				block: [ :aList | aList selectOne: 2 dueTo: nil ];
				play.

			anotherStep assert
				label: 'Assert nothing selected';
				value: [ :aList | aList selectedItems sort: [ :a :b | a < b ] ]
					equals: #(2);
				play ].

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> step: aStepOrScripter selectNumber: anInteger [
	<gtExample>
	^ aStepOrScripter
		substeps: ('Select number {1}' format: {anInteger})
		do: [ :anotherStep | 
			anotherStep wait
				forElementCondition: [ :anInfiniteList | 
						anInfiniteList children
							detect: [ :eachLabel | eachLabel text asString asInteger = anInteger ]
							ifFound: [ :anElement | true ]
							ifNone: [ false ] ]
					timeout: 3 seconds;
				// #scrollable;
				play.

			anotherStep click
				label: ('Click on label {1}' format: {anInteger});
				// #scrollable;
				onChildFromBlock: [ :anInfiniteList | 
					anInfiniteList children
						detect: [ :eachLabel | eachLabel text asString asInteger = anInteger ] ];
				play.

			anotherStep assert
				label: ('Assert item {1} is selected' format: {anInteger});
				value: [ :aList | aList selectedItems ] equals: {anInteger};
				play ]
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> waitForDisplayedItems: anotherStep [
	anotherStep wait
		forElementCondition: [ :anInfiniteList | 
				anInfiniteList children
					detect: [ :eachLabel | eachLabel text asString asInteger = 19 ]
					ifFound: [ :anElement | true ]
					ifNone: [ false ] ]
			timeout: 3 seconds;
		// #scrollable;
		play
]
