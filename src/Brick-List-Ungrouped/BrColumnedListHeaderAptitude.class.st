"
Adds opt-in column headers to BrColumnedList. Customize title elements with labelStencil:, container identity with headerId:, and resize-control identities with resizerIdStencil:. Brick owns composition, sorting icons, bubbled clicks, spacing and resizers. Configure sortBy: on columns before attaching headers. Manual resizing creates fixed widths; headers observe column width changes weakly. BrColumnedTreeHeaderAptitude adds tree indentation and tree-change handling.
"
Class {
	#name : #BrColumnedListHeaderAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'labelStencil',
		'cellSpacing',
		'headerId',
		'resizerIdentifierStencil'
	],
	#category : #'Brick-List-Ungrouped-Aptitudes'
}

{ #category : #building }
BrColumnedListHeaderAptitude >> buildColumnHeadersInto: headerPane [
	widget viewModel columnsDo: [ :column |
		| title icon header resizer index |
		index := widget columns identityIndexOf: column.
		title := labelStencil value: column.
		title hMatchParent.
		icon := (widget sortState iconElementForColumn: column) id: #columnSortIcon.
		header := BrHorizontalPane new id: ('columnHeader', index asString) asSymbol;
			alignCenterLeft; vFitContent; addChildren: { title. icon }.
		(column isSortable and: [ widget canSortColumns ]) ifTrue: [
			header addEventHandlerOn: BlClickEvent do: [ :event | widget sortByColumn: column ] ].
		resizer := column addResizerTo: header cellSpacing: self cellSpacing.
		resizer id: (resizerIdentifierStencil value: column).
		headerPane addChild: header ]
]

{ #category : #private }
BrColumnedListHeaderAptitude >> cellSpacing [
	^ cellSpacing
]

{ #category : #private }
BrColumnedListHeaderAptitude >> cellSpacing: aNumber [
	cellSpacing := aNumber
]

{ #category : #accessing }
BrColumnedListHeaderAptitude >> headerId: anId [
	headerId := anId
]

{ #category : #building }
BrColumnedListHeaderAptitude >> headerPane [
	| pane |
	pane := BrHorizontalPane new id: headerId;
		cellSpacing: self cellSpacing; padding: (BlInsets top: 5 bottom: 5);
		hMatchParent; vFitContent.
	self buildColumnHeadersInto: pane.
	^ pane
]

{ #category : #initialization }
BrColumnedListHeaderAptitude >> initialize [
	super initialize.
	headerId := #'column-header'.
	resizerIdentifierStencil := [ :column | #columnResizer ].
	self cellSpacing: BrColumn defaultCellSpacing.
	self labelStencil: [ :column | BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: BrGlamorousColors defaultButtonTextColor);
		alignCenterLeft; padding: self newCellPaddingInsets; text: column title ].
	self when: BrColumnsChanged do: [ :event | self rebuildHeadersDueTo: event ].
	self when: BrItemsProviderItemsChangedEvent do: [ :event | self rebuildHeadersDueTo: event ].
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

{ #category : #updating }
BrColumnedListHeaderAptitude >> rebuildHeadersDueTo: event [
	event target enqueueTask: [
		(event target query // headerId) anyOne removeChildren;
			in: [ :header | self buildColumnHeadersInto: header ] ] asBlTask
]

{ #category : #accessing }
BrColumnedListHeaderAptitude >> resizerIdStencil: aBlock [
	resizerIdentifierStencil := aBlock
]
