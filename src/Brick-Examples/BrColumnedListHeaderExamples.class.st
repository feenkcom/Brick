"
Executable interaction examples for opt-in column headers and local sorting.
"
Class {
	#name : #BrColumnedListHeaderExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Brick-Examples-List'
}

{ #category : #assertions }
BrColumnedListHeaderExamples >> assertSelection: selectedItem at: expectedIndex in: aScripter [
	aScripter assertStep: [ :step |
		step label: 'Selection model retains the same domain object at its new index';
			satisfies: [ :list |
				list selectedIndices asArray = { expectedIndex }
					and: [ list selectedItems size = 1 and: [ list selectedItems first == selectedItem ] ] ] ].
	aScripter assertStep: [ :step |
		step label: 'Only the selected domain row has selected state and highlight';
			satisfies: [ :list |
				list items allSatisfy: [ :item |
					| label row shouldSelect |
					label := (list query // BrLabel) all detect: [ :each | each text asString = item key ].
					row := label parent parent.
					shouldSelect := item == selectedItem.
					(row states isSelected = shouldSelect) and: [
						row background paint color = (shouldSelect
							ifTrue: [ row theme item selectedColor ]
							ifFalse: [ row theme item deselectedColor ]) ] ] ] ]
]

{ #category : #examples }
BrColumnedListHeaderExamples >> clickHeaderContent [
	<gtExample>
	| s |
	s := self scripterWithElement: [
		| list |
		list := BrColumnedList new size: 400 @ 300; matchParent.
		list column title: 'Number'; width: 200; sortBy: [ :a :b | a <= b ].
		list items: #(10 2 30).
		list addAptitude: (BrColumnedListHeaderAptitude new labelStencil: [ :column |
			BrHorizontalPane new height: 30; addChild: (BrLabel new
				id: #headerContent;
				aptitude: BrGlamorousLabelAptitude;
				text: column title) ]).
		list ].
	s clickStep: [ :step | step label: 'Click nested header label'; id: #headerContent ].
	s assertStep: [ :step | step label: 'Nested content sorts ascending'; value: [ :list | list items asArray ] equals: [ #(2 10 30) ] ].
	s clickStep: [ :step | step label: 'Click header empty area'; id: #columnHeader1 ].
	s assertStep: [ :step | step label: 'Whole header toggles descending'; value: [ :list | list items asArray ] equals: [ #(30 10 2) ] ].
	^ s
]

{ #category : #examples }
BrColumnedListHeaderExamples >> clickNonSortableColumn [
	<gtExample>
	"A real header click must neither raise an exception nor change the list."
	| s |
	s := self scripterWithElement: [
		| list |
		list := BrColumnedList new size: 400 @ 300.
		list column
			title: 'Number';
			width: 200;
			stencil: [ :each | BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: each asString ].
		list items: #(10 2 30 2).
		list withHeaders.
		list ].
	s clickStep: [ :step | step label: 'Click non-sortable column header'; id: #columnHeader1 ].
	s assertStep: [ :step |
		step label: 'Non-sortable header preserves item order';
			value: [ :list | list items asArray ] equals: [ #(10 2 30 2) ] ].
	s assertStep: [ :step |
		step label: 'No sort is activated';
			satisfies: [ :list | list columns first isSortable not and: [ list sortedColumn isNil ] ] ].
	^ s
]

{ #category : #examples }
BrColumnedListHeaderExamples >> clickResizerDoesNotSort [
	<gtExample>
	| s |
	s := self twoSortableColumnsScripter.
	s clickStep: [ :step | step label: 'Click resizer without dragging'; id: #columnHeader1; id: #columnResizer ].
	s assertStep: [ :step | step label: 'Resizer consumes click without sorting'; satisfies: [ :list |
		list sortedColumn isNil and: [ (list items collect: #key) asArray = #('Charlie' 'Alice' 'Diana' 'Bob' 'Eve') ] ] ].
	^ s
]

{ #category : #examples }
BrColumnedListHeaderExamples >> columnWhitespace [
	<gtExample>
	| s |
	s := self shrinkFirstColumn.
	s assertStep: [ :step | step label: 'Header and body retain inter-column whitespace after shrinking'; satisfies: [ :list |
		| firstHeader secondHeader name score firstCell secondCell |
		firstHeader := (list query // #columnHeader1) anyOne.
		secondHeader := (list query // #columnHeader2) anyOne.
		name := (list query // BrLabel) all detect: [ :label | label text asString = 'Charlie' ].
		score := (list query // BrLabel) all detect: [ :label | label text asString = '30' ].
		firstCell := name parent.
		secondCell := score parent.
		((secondHeader bounds inSpace asRectangle left - firstHeader bounds inSpace asRectangle right - 10) abs < 1)
			and: [ (secondCell bounds inSpace asRectangle left - firstCell bounds inSpace asRectangle right - 10) abs < 1
				and: [ (secondHeader bounds inSpace asRectangle left - secondCell bounds inSpace asRectangle left) abs < 1 ] ] ] ].
	^ s
]

{ #category : #examples }
BrColumnedListHeaderExamples >> customHeaderAndSpacing [
	<gtExample>
	| s |
	s := self scripterWithElement: [
		| list |
		list := BrColumnedList new size: 450 @ 300.
		list cellSpacing: 18.
		list column title: 'Number'; width: 160; sortBy: [ :a :b | a <= b ]; stencil: [ :item | BrLabel new aptitude: BrGlamorousLabelAptitude; text: item asString ].
		list column title: 'Squared'; width: 180; stencil: [ :item | BrLabel new aptitude: BrGlamorousLabelAptitude; text: (item * item) asString ].
		list items: #(3 2).
		list withHeadersDo: [ :header | header headerId: #customHeader;
			labelStencil: [ :column | BrLabel new aptitude: BrGlamorousLabelAptitude; text: column title ];
			resizerIdStencil: [ :column | (column title asString, '-resize') asSymbol ] ].
		list ].
	s clickStep: [ :step | step label: 'Sort with custom header'; id: #columnHeader1 ].
	s assertStep: [ :step | step label: 'Custom header survives sorting and stays aligned'; satisfies: [ :list |
		| header value |
		header := (list query // #customHeader) anyOne.
		value := (list query // BrLabel) all detect: [ :label | label text asString = '9' ].
		list sortState isAscending and: [ (value bounds inSpace asRectangle left - header children second bounds inSpace asRectangle left) abs < 1 ] ] ].
	s assertStep: [ :step | step label: 'Custom resizer identity retained'; exists; id: #'Number-resize' ].
	^ s
]

{ #category : #examples }
BrColumnedListHeaderExamples >> headerScripter [
	<gtExample>
	^ self scripterWithElement: [ self list ]
]

{ #category : #examples }
BrColumnedListHeaderExamples >> headerTitleAndSortIcon [
	<gtExample>
	| s |
	s := self sortAscending.
	s assertStep: [ :step |
		step label: 'Title remains unchanged and sort icon is a separate element';
			id: #columnHeader1;
			satisfies: [ :header |
				(header isKindOf: BrHorizontalPane) and: [
					((header query // BrLabel) anyOne text asString = 'Number') and: [
						(header query // #columnSortIcon) anyOne width > 0 ] ] ] ].
	s clickStep: [ :step | step label: 'Click separate sort icon'; id: #columnHeader1; id: #columnSortIcon ].
	s assertStep: [ :step | step label: 'Icon click toggles sorting'; satisfies: [ :list | list sortState isDescending ] ].
	^ s
]

{ #category : #examples }
BrColumnedListHeaderExamples >> list [
	<gtExample>
	| list |
	list := BrColumnedList new size: 400 @ 300.
	list column title: 'Number'; width: 150; sortBy: [ :a :b | a <= b ]; stencil: [ :each | BrLabel new aptitude: BrGlamorousLabelAptitude; text: each asString ].
	list items: #(10 2 30 2).
	list withHeaders.
	^ list
]

{ #category : #examples }
BrColumnedListHeaderExamples >> nonSortableColumn [
	<gtExample>
	| list |
	list := self list.
	list columns first sortBy: nil.
	list sortByColumn: list columns first.
	self assert: list items asArray equals: #(10 2 30 2).
	self assert: list sortedColumn isNil.
	^ list
]

{ #category : #examples }
BrColumnedListHeaderExamples >> programmaticWidthChange [
	<gtExample>
	| s |
	s := self headerScripter.
	s doStep: [ :step | step label: 'Change width through model'; block: [ :list | list columns first width: 210 ] ].
	s assertStep: [ :step | step label: 'Header follows column model'; id: #columnHeader1; satisfies: [ :header | (header width - 210) abs < 1 ] ].
	^ s
]

{ #category : #examples }
BrColumnedListHeaderExamples >> resize [
	<gtExample>
	| s |
	s := self headerScripter.
	s substep: 'Drag column right edge' do: [ :step |
		step mouseMoveOver id: #columnResizer.
		step mouseDown.
		step mouseMove by: 40 @ 0.
		step mouseUp.
		step play ].
	s assertStep: [ :step | step label: 'Resize updates column without sorting'; satisfies: [ :list | list columns first columnWidth width > 150 and: [ list sortedColumn isNil ] ] ].
	^ s
]

{ #category : #examples }
BrColumnedListHeaderExamples >> resizeAndScroll [
	<gtExample>
	| s |
	s := self resize.
	s doStep: [ :step | step label: 'Replace items and realize later rows'; block: [ :list | list items: (1 to: 200). list scrollToIndex: 200 ] ].
	s assertStep: [ :step | step label: 'Header keeps fixed resized width'; id: #columnHeader1; satisfies: [ :header | (header width - 190) abs < 1 ] ].
	s assertStep: [ :step |
		step label: 'Newly realized cell wrapper uses resized width and clips its content';
			// BrLabel;
			@ [ :label | label text asString = '200' ];
			satisfies: [ :label | (label parent width - 190) abs < 1 and: [ label parent clipChildren ] ] ].
	^ s
]

{ #category : #examples }
BrColumnedListHeaderExamples >> resizerCenteredInWhitespace [
	<gtExample>
	| s |
	s := self columnWhitespace.
	s assertStep: [ :step | step label: 'Resize handle is centered in column whitespace'; satisfies: [ :list |
		| left right resizer midpoint |
		left := (list query // #columnHeader1) anyOne.
		right := (list query // #columnHeader2) anyOne.
		resizer := (left query // #columnResizer) anyOne.
		midpoint := (left bounds inSpace asRectangle right + right bounds inSpace asRectangle left) / 2.
		(resizer bounds inSpace center x - midpoint) abs < 1 ] ].
	^ s
]

{ #category : #examples }
BrColumnedListHeaderExamples >> selectedRowBeforeSorting [
	<gtExample>
	| s selected |
	s := self scripterWithElement: [
		self twoSortableColumns
			rowStencil: (BrGlamorousColumnedListSelectableRowElementStencilBuilder new cellSpacing: 10);
			yourself ].
	selected := s element items first.
	s clickStep: [ :step | step label: 'Select Charlie by clicking the visible row'; // BrLabel; @ [ :label | label text asString = 'Charlie' ] ].
	self assertSelection: selected at: 1 in: s.
	^ s
]

{ #category : #examples }
BrColumnedListHeaderExamples >> selectionAfterSortingAscending [
	<gtExample>
	| s selected |
	s := self selectedRowBeforeSorting.
	selected := s element selectedItems first.
	s clickStep: [ :step | step label: 'Sort names ascending with Charlie selected'; id: #columnHeader1 ].
	self assertSelection: selected at: 3 in: s.
	^ s
]

{ #category : #examples }
BrColumnedListHeaderExamples >> selectionAfterSortingDescending [
	<gtExample>
	| s selected |
	s := self selectionAfterSortingAscending.
	selected := s element selectedItems first.
	s clickStep: [ :step | step label: 'Reverse name sorting while retaining selection'; id: #columnHeader1 ].
	self assertSelection: selected at: 3 in: s.
	^ s
]

{ #category : #examples }
BrColumnedListHeaderExamples >> selectionAfterSwitchingSortColumn [
	<gtExample>
	| s selected |
	s := self selectionAfterSortingDescending.
	selected := s element selectedItems first.
	s clickStep: [ :step | step label: 'Switch to ascending scores while retaining selection'; id: #columnHeader2 ].
	self assertSelection: selected at: 5 in: s.
	s clickStep: [ :step | step label: 'Reverse scores while retaining selection'; id: #columnHeader2 ].
	self assertSelection: selected at: 1 in: s.
	^ s
]

{ #category : #examples }
BrColumnedListHeaderExamples >> selectionAndRefresh [
	<gtExample>
	| list |
	list := self list.
	list selectOne: 1.
	list sortByColumn: list columns first.
	self assert: list selectedItems asArray equals: #(10).
	list items: #(5 10 1).
	self assert: list items asArray equals: #(1 5 10).
	self assert: list selectedItems asArray equals: #(10).
	list items: #().
	self assert: list selectedItems isEmpty.
	^ list
]

{ #category : #examples }
BrColumnedListHeaderExamples >> shrinkFirstColumn [
	<gtExample>
	| s |
	s := self twoSortableColumnsScripter.
	s substep: 'Shrink name column to clip its text' do: [ :step |
		step mouseMoveOver id: #columnHeader1; id: #columnResizer.
		step mouseDown.
		step mouseMove by: -220 @ 0.
		step mouseUp.
		step play ].
	s assertStep: [ :step |
		step label: 'Narrowed cell clips overflowing content';
			// BrLabel;
			@ [ :label | label text asString = 'Charlie' ];
			satisfies: [ :label |
				(label parent width - 40) abs < 1
					and: [ label parent clipChildren and: [ label width > label parent width ] ] ] ].
	^ s
]

{ #category : #examples }
BrColumnedListHeaderExamples >> sortAndResizeTwoColumns [
	<gtExample>
	| s |
	s := self twoSortableColumnsScripter.
	s clickStep: [ :step | step label: 'Sort names ascending'; id: #columnHeader1 ].
	s assertStep: [ :step | step label: 'Alphabetical names'; value: [ :list | (list items collect: #key) asArray ] equals: [ #('Alice' 'Bob' 'Charlie' 'Diana' 'Eve') ] ].
	s clickStep: [ :step | step label: 'Switch to numeric scores'; id: #columnHeader2 ].
	s assertStep: [ :step | step label: 'Ascending scores'; value: [ :list | (list items collect: #value) asArray ] equals: [ #(2 10 10 25 30) ] ].
	s clickStep: [ :step | step label: 'Reverse scores'; id: #columnHeader2 ].
	s assertStep: [ :step | step label: 'Descending scores'; value: [ :list | (list items collect: #value) asArray ] equals: [ #(30 25 10 10 2) ] ].
	s substep: 'Resize score column' do: [ :step |
		step mouseMoveOver id: #columnHeader2; id: #columnResizer.
		step mouseDown.
		step mouseMove by: 30 @ 0.
		step mouseUp.
		step play ].
	s assertStep: [ :step | step label: 'Only score width changes and sorting stays descending'; satisfies: [ :list |
		(list columns first columnWidth width = 260)
			and: [ (list columns second columnWidth width - 210) abs < 1
				and: [ list sortedColumn == list columns second and: [ list isSortAscending not ] ] ] ] ].
	^ s
]

{ #category : #examples }
BrColumnedListHeaderExamples >> sortAscending [
	<gtExample>
	| s |
	s := self headerScripter.
	s clickStep: [ :step | step label: 'Sort numeric column ascending'; id: #columnHeader1 ].
	s assertStep: [ :step | step label: 'Numeric order'; value: [ :list | list items asArray ] equals: [ #(2 2 10 30) ] ].
	^ s
]

{ #category : #examples }
BrColumnedListHeaderExamples >> sortDescending [
	<gtExample>
	| s |
	s := self sortAscending.
	s clickStep: [ :step | step label: 'Toggle descending'; id: #columnHeader1 ].
	s assertStep: [ :step | step label: 'Descending order'; value: [ :list | list items asArray ] equals: [ #(30 10 2 2) ] ].
	^ s
]

{ #category : #examples }
BrColumnedListHeaderExamples >> stableSortAndColumnSwitch [
	<gtExample>
	| list source |
	source := { 2 -> 'a'. 1 -> 'b'. 2 -> 'c' }.
	list := BrColumnedList new.
	list column title: 'Same'; sortBy: [ :a :b | a key <= b key ].
	list column title: 'Same'; sortBy: [ :a :b | a value <= b value ].
	list items: source.
	list sortByColumn: list columns first.
	self assert: (list items collect: #value) asArray equals: #('b' 'a' 'c').
	list sortByColumn: list columns first.
	self assert: (list items collect: #value) asArray equals: #('a' 'c' 'b').
	list sortByColumn: list columns second.
	self assert: (list items collect: #value) asArray equals: #('a' 'b' 'c').
	self assert: (source collect: #value) equals: #('a' 'b' 'c').
	^ list
]

{ #category : #examples }
BrColumnedListHeaderExamples >> twoSortableColumns [
	<gtExample>
	"Click either header to sort; drag its right edge to resize."
	| list |
	list := BrColumnedList new size: 500 @ 320.
	list column
		title: 'Name';
		width: 260;
		sortBy: [ :a :b | a key <= b key ];
		stencil: [ :each | BrLabel new
			aptitude: BrGlamorousLabelAptitude;
			text: each key ].
	list column
		title: 'Score';
		width: 180;
		sortBy: [ :a :b | a value <= b value ];
		stencil: [ :each | BrLabel new
			aptitude: BrGlamorousLabelAptitude;
			text: each value asString ].
	list items: { 'Charlie' -> 30. 'Alice' -> 10. 'Diana' -> 2. 'Bob' -> 10. 'Eve' -> 25 }.
	list withHeaders.
	self assert: list columns size equals: 2.
	^ list
]

{ #category : #examples }
BrColumnedListHeaderExamples >> twoSortableColumnsScripter [
	<gtExample>
	^ self scripterWithElement: [ self twoSortableColumns ]
]

{ #category : #examples }
BrColumnedListHeaderExamples >> unsupportedProvider [
	<gtExample>
	| list |
	list := BrColumnedList new.
	list column sortBy: [ :a :b | a <= b ].
	list sortByColumn: list columns first.
	self assert: list canSortColumns not.
	self assert: list sortedColumn isNil.
	^ list
]
