Class {
	#name : #BrGroupedListWithScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Brick-Examples'
}

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithElement: [ BrGroupedListExamples new multiSelection ].

	aScripter assert
		label: 'Assert no selection';
		value: [ :aList | aList selectedItems size ] equals: 0;
		play.

	^ aScripter
]

{ #category : #'examples - list' }
BrGroupedListWithScripterExamples >> multiSelection_select18 [
	<gtExample>
	| aScripter |
	aScripter := self multiSelection.

	aScripter click
		label: 'Click on label 18';
		// #scrollable;
		onChildFromBlock: [ :anInfiniteList | 
			anInfiniteList children
				detect: [ :eachLabel | eachLabel text asString asInteger = 18 ] ];
		play.

	aScripter assert
		label: 'Assert item 18 is selected';
		satisfies: [ :aList | 
			| allItems |
			allItems := aList selectedItems.
			allItems size = 1 and: [ allItems anyOne = 18 ] ];
		play.

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
