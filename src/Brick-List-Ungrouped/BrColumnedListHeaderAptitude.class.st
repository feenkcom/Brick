"
Adds an opt-in header row to BrColumnedList. Attach before or after defining columns. Header labels are customizable with labelStencil:. Right-edge resizers convert a column to a fixed width (minimum 20). Headers and body cells observe column width changes using weak subscriptions. Columns configured with sortKey: or sortComparator: toggle ascending/descending order for local sequenceable-collection providers; other providers are not materialized. Configure sorting before building the header.
"
Class {
	#name : #BrColumnedListHeaderAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'labelStencil',
		'cellSpacing'
	],
	#category : #'Brick-List-Ungrouped-Aptitudes'
}

{ #category : #building }
BrColumnedListHeaderAptitude >> buildColumnHeadersInto: headerPane [
	widget viewModel columnsDo: [ :aColumn |
		| titleElement iconElement columnHeader index |
		index := widget columns identityIndexOf: aColumn.
		titleElement := labelStencil value: aColumn.
		titleElement hMatchParent.
		iconElement := widget sortState iconElementForColumn: aColumn.
		iconElement id: #columnSortIcon.
		columnHeader := BrHorizontalPane new
			id: ('columnHeader', index asString) asSymbol;
			alignCenterLeft;
			vFitContent;
			addChildren: { titleElement. iconElement }.
		(aColumn isSortable and: [ widget canSortColumns ]) ifTrue: [
			columnHeader addEventHandlerOn: BlClickEvent do: [ :event | widget sortByColumn: aColumn ] ].
		aColumn addResizerTo: columnHeader cellSpacing: self cellSpacing.
		headerPane addChild: columnHeader ]
]

{ #category : #private }
BrColumnedListHeaderAptitude >> cellSpacing [
	^ cellSpacing
]

{ #category : #private }
BrColumnedListHeaderAptitude >> cellSpacing: aNumber [
	cellSpacing := aNumber
]

{ #category : #private }
BrColumnedListHeaderAptitude >> headerPane [
	| headerPane |
	headerPane := BrHorizontalPane new
			id: #'column-header';
			cellSpacing: self cellSpacing;
			padding: (BlInsets top: 5 bottom: 5);
			hMatchParent;
			vFitContent.
	self buildColumnHeadersInto: headerPane.
	^ headerPane
]

{ #category : #initialization }
BrColumnedListHeaderAptitude >> initialize [
	super initialize.
	self cellSpacing: 10.
	self labelStencil: [ :aColumn |
		BrLabel new
			aptitude: (BrGlamorousLabelAptitude new foreground: BrGlamorousColors defaultButtonTextColor);
			alignCenterLeft;
			padding: self newCellPaddingInsets;
			text: aColumn title ].
	self when: BrColumnsChanged do: [ :evt | self rebuildHeadersDueTo: evt ].
	self when: BrItemsProviderItemsChangedEvent do: [ :evt | self rebuildHeadersDueTo: evt ].
	self addChangeAddChildFirst: #() with: [ self headerPane ]
]

{ #category : #accessing }
BrColumnedListHeaderAptitude >> labelStencil: aBlock [
	labelStencil := aBlock 
]

{ #category : #private }
BrColumnedListHeaderAptitude >> newCellPaddingInsets [
	^ BlInsets empty
]

{ #category : #initialization }
BrColumnedListHeaderAptitude >> rebuildHeadersDueTo: evt [
	evt target
		enqueueTask: [ | header |
			header := (evt target query // #'column-header') anyOne.
			header removeChildren.
			self buildColumnHeadersInto: header ] asBlTask
]
