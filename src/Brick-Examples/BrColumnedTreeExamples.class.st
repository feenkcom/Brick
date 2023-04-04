Class {
	#name : #BrColumnedTreeExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Tree'
}

{ #category : #examples }
BrColumnedTreeExamples >> scripterOnSubclassesOfCollectionMultiSelect [
	<gtExample>
	| aScripter |
	aScripter := BlScripter new element: self subclassesOfCollectionMultiSelect fitContent.
	
	aScripter check
		label: 'Check that nothing is selected';
		satisfies: [:anElement | anElement selectedIndices isEmpty ];
		play.
	
	^ aScripter
]

{ #category : #examples }
BrColumnedTreeExamples >> scripterOnSubclassesOfCollectionMultiSelectExpanded [
	<gtExample>
	| aScripter |
	aScripter := self scripterOnSubclassesOfCollectionMultiSelect.

	aScripter click
		label: 'Expand tree';
		onChildAt: 1;
		onChildAt: 1;
		id: #toggle;
		play.

	aScripter check
		label: 'Check that expansion works';
		satisfies: [ :anElement | anElement viewModel root isExpanded ];
		play.

	^ aScripter
]

{ #category : #examples }
BrColumnedTreeExamples >> scripterOnSubclassesOfCollectionMultiSelectSelected [
	<gtExample>
	| aScripter |
	aScripter := self scripterOnSubclassesOfCollectionMultiSelectExpanded.

	aScripter click
		label: 'Select items in tree';
		id: #scrollable;
		onChildAt: 2;
		play.


	aScripter click
		label: 'Select items in tree';
		id: #scrollable;
		onChildAt: 5;
		modifiers: BlKeyModifiers shift;
		play.

	aScripter check
		label: 'Check that selection works';
		satisfies: [ :anElement | anElement selectedIndices size = 4 ];
		play.

	^ aScripter
]

{ #category : #examples }
BrColumnedTreeExamples >> scripterOnSubclassesOfCollectionMultiSelectSelectedDiscontinuous [
	<gtExample>
	| aScripter |
	aScripter := self scripterOnSubclassesOfCollectionMultiSelectSelected.


	aScripter click
		label: 'Select items in tree';
		id: #scrollable;
		onChildAt: 7;
		modifiers: BlKeyModifiers primary;
		play.

	aScripter check
		label: 'Check that selection works';
		satisfies: [ :anElement | anElement selectedIndices size = 5 ];
		play.

	^ aScripter
]

{ #category : #examples }
BrColumnedTreeExamples >> subclassesOfCollection [
	<gtExample>
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
		dataBinder:
				[ :aCellElement :aClass | aCellElement text: aClass package name asString ].
	aTree items: {Collection} lazy: [ :eachClass | eachClass subclasses ].
	^ aTree
]

{ #category : #examples }
BrColumnedTreeExamples >> subclassesOfCollectionMultiSelect [
	<gtExample>
	^ self subclassesOfCollection
		rowStencil: BrGlamorousColumnedTreeSelectableRowElementStencilBuilder new;
		aptitude: BrColumnedMultiTreeAptitude
]

{ #category : #examples }
BrColumnedTreeExamples >> subropesTree [
	<gtExample>
	| aRope aTree |
	aRope := BlConcatenationRopeExamples new small_from_1_to_2.
	
	aTree := BrColumnedTree new.
	aTree column
		title: 'Text';
		width: 150;
		cellStencil: [ 
			BrLabel new 
				aptitude: BrGlamorousLabelAptitude new ];
		dataBinder: [ :eachLabel :eachRope | eachLabel text: eachRope ].
		
	aTree column
		title: 'Length';
		weight: 2;
		cellStencil: [ 
			BrLabel new 
				aptitude: BrGlamorousLabelAptitude new ];
		dataBinder: [ :eachLabel :eachRope | eachLabel text: eachRope size asString ].
		
	aTree 
		items: {aRope} 
		lazy: [ :eachRope | eachRope children ].
	
	^ aTree
]
