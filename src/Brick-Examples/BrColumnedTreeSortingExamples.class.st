"
Sorting and resizing columned trees, including sibling ordering, lazy expansion and selected row preservation.
"
Class {
	#name : #BrColumnedTreeSortingExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Brick-Examples-Tree'
}

{ #category : #examples }
BrColumnedTreeSortingExamples >> clickAndResize [
	<gtExample>
	| s |
	s := self headerScripter.
	s clickStep: [ :step | step label: 'Sort tree roots'; id: #columnHeader1 ].
	s assertStep: [ :step | step label: 'Roots ordered ascending'; satisfies: [ :tree | (tree nodeAt: 1) value key = 'Alpha' ] ].
	s substep: 'Resize first tree column' do: [ :step |
		step mouseMoveOver id: #columnHeader1; id: #columnResizer.
		step mouseDown.
		step mouseMove by: -40 @ 0.
		step mouseUp.
		step play ].
	s assertStep: [ :step | step label: 'Width changes without reversing sorting'; satisfies: [ :tree | (tree columns first columnWidth width - 220) abs < 1 and: [ tree sortState isAscending ] ] ].
	^ s
]

{ #category : #examples }
BrColumnedTreeSortingExamples >> customHeaderAndSpacing [
	<gtExample>
	| s |
	s := self scripterWithElement: [
		| tree |
		tree := BrColumnedTree new size: 500 @ 300.
		tree cellSpacing: 18.
		tree column title: 'Name'; width: 260; sortBy: [ :a :b | a key <= b key ]; stencil: [ :item | BrLabel new aptitude: BrGlamorousLabelAptitude; text: item key ].
		tree column title: 'Score'; width: 180; stencil: [ :item | BrLabel new aptitude: BrGlamorousLabelAptitude; text: item value asString ].
		tree items: { 'Beta' -> 20. 'Alpha' -> 10 } lazy: [ :item | #() ].
		tree withHeadersDo: [ :header | header headerId: #customHeader; labelStencil: [ :column | BrLabel new aptitude: BrGlamorousLabelAptitude; text: column title ] ].
		tree ].
	s clickStep: [ :step | step label: 'Sort using customized Brick header'; id: #columnHeader1 ].
	s assertStep: [ :step | step label: 'Custom identity survives rebuilding and spacing aligns'; satisfies: [ :tree |
		| header value |
		header := (tree query // #customHeader) anyOne.
		value := (tree query // BrLabel) all detect: [ :label | label text asString = '20' ].
		(value bounds inSpace asRectangle left - header children second bounds inSpace asRectangle left) abs < 1 ] ].
	^ s
]

{ #category : #examples }
BrColumnedTreeSortingExamples >> headerScripter [
	<gtExample>
	^ self scripterWithElement: [ self tree ]
]

{ #category : #examples }
BrColumnedTreeSortingExamples >> immediateSortingAndRefresh [
	<gtExample>
	| tree |
	tree := self tree.
	tree
		items: { 'Beta' -> 20. 'Alpha' -> 10 }
		immediate: [ :item |
			item key = 'Beta'
				ifTrue: [ { 'Delta' -> 4. 'Charlie' -> 3 } ]
				ifFalse: [ #() ] ].
	tree sortByColumn: tree columns first.
	tree expandAll.
	self assert: ((1 to: tree viewModel itemCount) collect: [ :i | (tree nodeAt: i) value ]) asArray
		equals: { 'Alpha' -> 10. 'Beta' -> 20. 'Charlie' -> 3. 'Delta' -> 4 }.
	tree items: { 'Eve' -> 5. 'Alice' -> 1 } immediate: [ :item | #() ].
	self assert: (tree nodeAt: 1) value equals: 'Alice' -> 1.
	tree beUnsorted.
	self assert: (tree nodeAt: 1) value equals: 'Eve' -> 5.
	^ tree
]

{ #category : #examples }
BrColumnedTreeSortingExamples >> lazyExpansionAfterSorting [
	<gtExample>
	| tree |
	tree := self tree.
	tree sortByColumn: tree columns first.
	self assert: tree viewModel itemCount equals: 2.
	(tree nodeAt: 2) expand.
	self assert: ((1 to: tree viewModel itemCount) collect: [ :i | (tree nodeAt: i) value key ]) asArray equals: #('Alpha' 'Beta' 'Charlie' 'Delta').
	^ tree
]

{ #category : #examples }
BrColumnedTreeSortingExamples >> selectionAfterSorting [
	<gtExample>
	| s selected |
	s := self scripterWithElement: [ self tree
		rowStencil: BrGlamorousColumnedTreeSelectableRowElementStencilBuilder new;
		expandAll;
		yourself ].
	s clickStep: [ :step | step label: 'Select a child row'; // BrLabel; @ [ :label | label text asString = 'Delta' ] ].
	selected := s element selectedItems first.
	s clickStep: [ :step | step label: 'Sort while retaining expanded selected child'; id: #columnHeader1 ].
	s assertStep: [ :step | step label: 'Model retains selected child identity'; satisfies: [ :tree | tree selectedItems size = 1 and: [ tree selectedItems first == selected ] ] ].
	s assertStep: [ :step | step label: 'Selected child is visually highlighted'; // BrLabel; @ [ :label | label text asString = 'Delta' ]; satisfies: [ :label |
		| row |
		row := label parent parent.
		row states isSelected and: [ row background paint color = row theme item selectedColor ] ] ].
	s assertStep: [ :step | step label: 'Selectable rows align score text with its header at all depths'; satisfies: [ :tree |
		| header labels |
		header := (tree query // #columnHeader2) anyOne.
		labels := (tree query // BrLabel) all.
		#('20' '4' '3' '10') allSatisfy: [ :value |
			| label |
			label := labels detect: [ :each | each text asString = value ].
			(label bounds inSpace asRectangle left - header bounds inSpace asRectangle left) abs < 1 ] ] ].
	^ s
]

{ #category : #examples }
BrColumnedTreeSortingExamples >> shrinkAndAlignColumns [
	<gtExample>
	| s |
	s := self scripterWithElement: [ self tree expandAll; yourself ].
	s substep: 'Narrow first column' do: [ :step |
		step mouseMoveOver id: #columnHeader1; id: #columnResizer.
		step mouseDown.
		step mouseMove by: -210 @ 0.
		step mouseUp.
		step play ].
	s assertStep: [ :step | step label: 'First column clips and score text aligns at every depth'; satisfies: [ :tree |
		| header labels |
		header := (tree query // #columnHeader2) anyOne.
		labels := (tree query // BrLabel) all.
		(#('Beta' 'Delta' 'Charlie' 'Alpha') allSatisfy: [ :name |
			| label cell |
			label := labels detect: [ :each | each text asString = name ].
			cell := label parent.
			cell clipChildren and: [ (cell width - 50) abs < 1 and: [ label width <= 50 ] ] ])
		and: [ #('20' '4' '3' '10') allSatisfy: [ :value |
			| label |
			label := labels detect: [ :each | each text asString = value ].
			(label bounds inSpace asRectangle left - header bounds inSpace asRectangle left) abs < 1 ] ] ] ].
	^ s
]

{ #category : #examples }
BrColumnedTreeSortingExamples >> sortSiblings [
	<gtExample>
	| tree selected |
	tree := self tree.
	tree expandAll.
	selected := (tree nodeAt: 2) value.
	tree selectOne: 2.
	tree sortByColumn: tree columns first.
	self assert: ((1 to: tree viewModel itemCount) collect: [ :i | (tree nodeAt: i) value key ]) asArray equals: #('Alpha' 'Beta' 'Charlie' 'Delta').
	self assert: tree selectedItems first == selected.
	self assert: (tree nodeAt: 2) isExpanded.
	tree sortByColumn: tree columns first.
	self assert: ((1 to: tree viewModel itemCount) collect: [ :i | (tree nodeAt: i) value key ]) asArray equals: #('Beta' 'Delta' 'Charlie' 'Alpha').
	^ tree
]

{ #category : #examples }
BrColumnedTreeSortingExamples >> tree [
	<gtExample>
	| tree |
	tree := BrColumnedTree new size: 500 @ 350.
	tree column
		title: 'Name';
		width: 260;
		sortBy: [ :a :b | a key <= b key ];
		stencil: [ :item | 
			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: item key ].
	tree column
		title: 'Score';
		width: 180;
		sortBy: [ :a :b | a value <= b value ];
		stencil: [ :item | 
			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: item value asString ].
	tree
		items: {'Beta' -> 20.
				'Alpha' -> 10}
		lazy: [ :item | 
			item key = 'Beta'
				ifTrue: [ {'Delta' -> 4.
						'Charlie' -> 3} ]
				ifFalse: [ #() ] ].
	tree withHeaders.
	^ tree
]

{ #category : #examples }
BrColumnedTreeSortingExamples >> unsortedAssignmentUsesNormalTreePath [
	<gtExample>
	| tree root childCalls |
	tree := BrColumnedTree new.
	childCalls := 0.
	tree items: #(2 1) lazy: [ :item | childCalls := childCalls + 1. #() ].
	self assert: childCalls equals: 0.
	self assert: (tree nodeAt: 1) value equals: 2.
	root := tree viewModel root.
	tree beUnsorted.
	self assert: tree viewModel root == root.
	self assert: childCalls equals: 0.
	tree items: #(3 1) immediate: [ :item | childCalls := childCalls + 1. #() ].
	self assert: childCalls > 0.
	self assert: (tree nodeAt: 1) value equals: 3.
	root := tree viewModel root.
	tree beUnsorted.
	self assert: tree viewModel root == root.
	^ tree
]
