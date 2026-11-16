"
Examples for columned header colors, hover affordances and theme changes.
"
Class {
	#name : #BrColumnedListThemeExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-List'
}

{ #category : #helpers }
BrColumnedListThemeExamples >> assertHeader: anId background: aColor in: aScripter [
	aScripter
		assertStep: [ :aStep | 
			aStep
				label: 'Check the header background';
				id: anId;
				value: [ :aHeader | aHeader background paint color blocResolveColorForTheme: aHeader theme ]
					equals: [ aColor ] ]
]

{ #category : #helpers }
BrColumnedListThemeExamples >> headerScripterFor: aWidget [
	aWidget
		size: 400 @ 250;
		theme: BrGlamorousLightTheme new.
	aWidget column
		title: 'Sortable';
		width: 180;
		sortBy: [ :a :b | a <= b ];
		stencil: [ :each | 
			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: each asString ].
	aWidget column
		title: 'Plain';
		width: 180;
		stencil: [ :each | 
			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: each asString ].
	aWidget withHeaders.
	^ BlScripter new element: aWidget
]

{ #category : #examples }
BrColumnedListThemeExamples >> sortableHeaderHover [
	<gtExample>
	| scripter |
	scripter := self headerScripterFor: (BrColumnedList new items: #(10 2 30)).
	scripter mouseMoveOver
		id: #columnHeader1;
		play.
	self
		assertHeader: #columnHeader1
		background: BrAntColors gray2
		in: scripter.
	scripter mouseMoveOver
		id: #columnHeader2;
		play.
	self
		assertHeader: #columnHeader1
		background: Color transparent
		in: scripter.
	scripter
		assertStep: [ :aStep | 
			aStep
				label: 'The non-sortable header has no hover highlight';
				id: #columnHeader2;
				satisfies: [ :aHeader | aHeader background isTransparent ] ].
	scripter mouseMoveOver
		id: #columnHeader1;
		play.
	scripter
		doStep: [ :aStep | 
			aStep
				label: 'Switch the hovered header to the dark theme';
				block: [ :aList | aList theme: BrGlamorousDarkTheme new ] ].
	self
		assertHeader: #columnHeader1
		background: BrAntColors gray9
		in: scripter.
	scripter
		doStep: [ :aStep | 
			aStep
				label: 'Modify the active hover palette';
				block: [ :aList | 
					aList theme columnedList sortableHeaderHoveredBackgroundColor: Color magenta.
					aList theme themeModified ] ].
	self
		assertHeader: #columnHeader1
		background: Color magenta
		in: scripter.
	^ scripter
]

{ #category : #examples }
BrColumnedListThemeExamples >> sortableTreeHeaderHover [
	<gtExample>
	| tree scripter |
	tree := BrColumnedTree new.
	tree
		items: #(20 10)
		lazy: [ :each | each = 20 ifTrue: [ #(4 3) ] ifFalse: [ #() ] ].
	scripter := self headerScripterFor: tree.
	scripter mouseMoveOver
		id: #columnHeader1;
		play.
	self
		assertHeader: #columnHeader1
		background: BrAntColors gray2
		in: scripter.
	scripter mouseMoveOver
		id: #columnHeader2;
		play.
	self
		assertHeader: #columnHeader1
		background: Color transparent
		in: scripter.
	^ scripter
]

{ #category : #examples }
BrColumnedListThemeExamples >> streamHeaderDoesNotHighlight [
	<gtExample>
	| list scripter |
	list := BrColumnedList new
			itemsProvider: #(10 2 30) asAsyncStream asBrItemsProvider.
	scripter := self headerScripterFor: list.
	scripter mouseMoveOver
		id: #columnHeader1;
		play.
	scripter
		assertStep: [ :aStep | 
			aStep
				label: 'The stream header has no sorting hover affordance';
				id: #columnHeader1;
				satisfies: [ :aHeader | aHeader background isTransparent ] ].
	scripter
		assertStep: [ :aStep | 
			aStep
				label: 'The column has a comparator but the stream cannot sort';
				satisfies: [ :aList | aList columns first isSortable and: [ aList canSortColumns not ] ] ].
	^ scripter
]

{ #category : #examples }
BrColumnedListThemeExamples >> themeableHeaderColors [
	<gtExample>
	| light dark color |
	light := BrGlamorousLightTheme new.
	dark := BrGlamorousDarkTheme new.
	self assert: light subThemes isEmpty.
	self assert: light columnedList class equals: BrColumnedListLightTheme.
	self assert: light columnedList theme == light.
	self assert: light columnedList == light columnedList.
	self assert: dark columnedList class equals: BrColumnedListDarkTheme.
	color := light columnedList sortableHeaderHoveredBackgroundColor.
	self assert: (color blocResolveColorForTheme: light) equals: BrAntColors gray2.
	self assert: (color blocResolveColorForTheme: dark) equals: BrAntColors gray9.
	dark columnedList sortableHeaderHoveredBackgroundColor: Color magenta.
	dark themeModified.
	self assert: (color blocResolveColorForTheme: dark) equals: Color magenta.
	self assert: (color blocResolveColorForTheme: light) equals: BrAntColors gray2.
	dark columnedList: (BrColumnedListDarkTheme theme: dark).
	self assert: (color blocResolveColorForTheme: dark) equals: BrAntColors gray9.
	^ color
]
