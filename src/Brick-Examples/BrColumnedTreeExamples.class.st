Class {
	#name : #BrColumnedTreeExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Tree'
}

{ #category : #examples }
BrColumnedTreeExamples >> scripterOnSubclassesOfCollectionMultiSelect [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := BlScripter new
			element: self subclassesOfCollectionMultiSelect fitContent.

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check that nothing is selected';
				satisfies: [ :anElement | anElement selectedIndices isEmpty ] ].

	^ aScripter
]

{ #category : #examples }
BrColumnedTreeExamples >> scripterOnSubclassesOfCollectionMultiSelectExpanded [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripterOnSubclassesOfCollectionMultiSelect.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Expand tree';
				onChildAt: 1;
				onChildAt: 1;
				id: #toggle ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check that expansion works';
				satisfies: [ :anElement | anElement viewModel root isExpanded ] ].

	^ aScripter
]

{ #category : #examples }
BrColumnedTreeExamples >> scripterOnSubclassesOfCollectionMultiSelectSelected [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripterOnSubclassesOfCollectionMultiSelectExpanded.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Select items in tree';
				id: #scrollable;
				onChildAt: 2 ].


	aScripter
		clickStep: [ :s | 
			s
				label: 'Select items in tree';
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

{ #category : #examples }
BrColumnedTreeExamples >> scripterOnSubclassesOfCollectionMultiSelectSelectedDiscontinuous [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripterOnSubclassesOfCollectionMultiSelectSelected.


	aScripter
		clickStep: [ :s | 
			s
				label: 'Select items in tree';
				id: #scrollable;
				onChildAt: 7;
				modifiers: BlKeyModifiers primary ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check that selection works';
				satisfies: [ :anElement | anElement selectedIndices size = 5 ] ].

	^ aScripter
]

{ #category : #examples }
BrColumnedTreeExamples >> subclassesOfCollection [
	<gtExample>
	<return: #BrColumnedTree>
	| aTree |
	aTree := BrColumnedTree new.
	aTree column
		title: 'Class';
		cellStencil: [ BrLabel new
				aptitude: BrGlamorousLabelAptitude new;
				hMatchParent;
				vFitContent ];
		dataBinder: [ :aCellElement :aClass | aCellElement text: aClass name asString ].
	aTree column
		title: 'Package';
		cellStencil: [ BrLabel new
				aptitude: BrGlamorousLabelAptitude new;
				hMatchParent;
				vFitContent ];
		dataBinder: [ :aCellElement :aClass | aCellElement text: aClass package name asString ].
	aTree items: {Collection} lazy: [ :eachClass | eachClass subclasses ].
	^ aTree
]

{ #category : #examples }
BrColumnedTreeExamples >> subclassesOfCollectionMultiSelect [
	<gtExample>
	<return: #BrColumnedTree>
	^ self subclassesOfCollection
		rowStencil: BrGlamorousColumnedTreeSelectableRowElementStencilBuilder new;
		aptitude: BrColumnedMultiTreeAptitude
]

{ #category : #examples }
BrColumnedTreeExamples >> subropesTree [
	<gtExample>
	<return: #BrColumnedTree>
	| aRope aTree |
	aRope := BlConcatenationRopeExamples new small_from_1_to_2.

	aTree := BrColumnedTree new.
	aTree column
		title: 'Text';
		width: 150;
		cellStencil: [ BrLabel new aptitude: BrGlamorousLabelAptitude new ];
		dataBinder: [ :eachLabel :eachRope | eachLabel text: eachRope ].

	aTree column
		title: 'Length';
		weight: 2;
		cellStencil: [ BrLabel new aptitude: BrGlamorousLabelAptitude new ];
		dataBinder: [ :eachLabel :eachRope | eachLabel text: eachRope size asString ].

	aTree items: {aRope} lazy: [ :eachRope | eachRope children ].

	^ aTree
]
