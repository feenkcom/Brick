Class {
	#name : #BrSimpleTreeExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Tree'
}

{ #category : #examples }
BrSimpleTreeExamples >> scripterOnSubclassesOfCollectionMultiSelect [
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
BrSimpleTreeExamples >> scripterOnSubclassesOfCollectionMultiSelectExpanded [
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
BrSimpleTreeExamples >> scripterOnSubclassesOfCollectionMultiSelectSelected [
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
BrSimpleTreeExamples >> scripterOnSubclassesOfCollectionMultiSelectSelectedDiscontinuous [
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
BrSimpleTreeExamples >> subclassesOfCollection [
	<gtExample>
	| aTree |
	aTree := BrSimpleTree new
		nodeStencil: [ BrLabel new aptitude: BrGlamorousLabelAptitude ];
		nodeDataBinder: [ :aNodeElement :aClass | aNodeElement text: aClass name ];
		items: {Collection} lazy: [ :eachClass | eachClass subclasses ].
	^ aTree
]

{ #category : #examples }
BrSimpleTreeExamples >> subclassesOfCollectionMultiSelect [
	<gtExample>
	 ^ self subclassesOfCollection
		rowStencil: BrGlamorousSimpleTreeSelectableRowElementStencilBuilder new;
		aptitude: BrMultiTreeAptitude
]

{ #category : #examples }
BrSimpleTreeExamples >> subclassesOfCollection_InefficientUse [
	<gtExample>
	| aTree |
	aTree := BrSimpleTree new
		stencil: [ :eachClass :eachIndex | 
			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: eachClass name;
				fitContent ];
		items: {Collection} lazy: [ :eachClass | eachClass subclasses ].
	^ aTree
]

{ #category : #examples }
BrSimpleTreeExamples >> subclassesOfCollection_immediate [
	<gtExample>
	| aTree |

	aTree := BrSimpleTree new.
	aTree
		nodeStencil: [
			BrHorizontalPane new
				vFitContent;
				hMatchParent;
				alignCenterLeft;
				cellSpacing: 5;
				addChild: (BrLabel new aptitude: BrGlamorousLabelAptitude) as: #label;
				addChild: (BrButton new beTiny; aptitude: BrGlamorousButtonWithLabelAptitude new; label: 'Add child') as: #add;
				addChild: (BrButton new beTiny; aptitude: BrGlamorousButtonWithLabelAptitude new; label: 'Delete') as: #delete ];
		nodeDataBinder: [ :aNodeElement :aClass :aTreeNode |
			(aNodeElement childNamed: #label) text: aClass printString.
			(aNodeElement childNamed: #delete)
				action: [ aTreeNode removeFromParent ].
			(aNodeElement childNamed: #add)
				action: [
					aTreeNode
						insert: Smalltalk allClasses atRandom
						atChildIndex: 1.
					aTreeNode expand ] ];
		items: { Collection }
			immediate: [ :eachClass | eachClass subclasses ].

	^ aTree
]

{ #category : #examples }
BrSimpleTreeExamples >> subropesTree [
	<gtExample>
	| aRope aTree |
	aRope := BlConcatenationRopeExamples new small_from_1_to_2.
	
	aTree := BrSimpleTree new
		nodeStencil: [ 
			BrLabel new 
			aptitude: BrGlamorousLabelAptitude ];
		nodeDataBinder: [ :aNodeElement :eachaRope | aNodeElement text: eachaRope ].
		
	aTree 
		items: {aRope} 
		lazy: [ :eachRope | eachRope children ].
	^ aTree
]
