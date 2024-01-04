"
BrColumnedListHeaderLook adds a header row to a BrColumnedList.

- All columns are assumed to have a title.
- The look must be added after the columns have been defined.
- The header row is constructed as a BrHorizontalPane containing the header labels and inserted as the first child of the columned list.
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
			cellSpacing: self cellSpacing;
			padding: (BlInsets top: 5 bottom: 5);
			hMatchParent;
			vFitContent.
	widget viewModel
		columnsDo: [ :aColumn | headerPane addChild: (labelStencil value: aColumn) ].
	^ headerPane
]

{ #category : #initialization }
BrColumnedListHeaderAptitude >> initialize [
	super initialize.

	self cellSpacing: 0.
	self
		labelStencil: [ :aColumn | 
			| label |
			label := BrLabel new
					aptitude: BrGlamorousLabelAptitude;
					padding: self newCellPaddingInsets;
					text: (aColumn title asRopedText foreground: self theme button defaultTextColor).
			aColumn columnWidth applyOn: label.
			label ].
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
