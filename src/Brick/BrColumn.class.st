"
I represent a column within a columned model. A column has associated title, width resizer and a cell stencil builder.

Cell stencil builder builds a stencil or an element for each cell within a columned list taking row value, row index and current column index into account.

[[[
| aColumn |

aColumn := BrColumn new.
aColumn title: 'Column'.
aColumn stencil: [ :aRowValue :aRowIndex :aColumnIndex | BrLabel new aptitude: BrLabelAptitude text: aRowValue asString ].
aColumn

]]]
"
Class {
	#name : #BrColumn,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'announcer',
		'title',
		'cellStencil',
		'dataBinder',
		'columnWidth'
	],
	#category : #'Brick-Column - Model'
}

{ #category : #accessing }
BrColumn >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
BrColumn >> cellStencil [
	<return: #BrColumnCellStencilBuilder>

	^ cellStencil
]

{ #category : #accessing }
BrColumn >> cellStencil: aStencil [
	"A cell element stencil can be a #value-able of the form [ :anItemType :aBrColumn :anItemIndex | ]"
	
	cellStencil := aStencil asStencilBuilder: BrColumnCellStencilBuilder
]

{ #category : #accessing }
BrColumn >> cellWidth: aBrColumnWidth [
	self 
		assert: [ aBrColumnWidth isNotNil ]
		description: [ 'Cell width must be non-nil' ].
	columnWidth := aBrColumnWidth
]

{ #category : #'api - column width' }
BrColumn >> columnWidth [
	<return: #BrColumnWidth>

	^ columnWidth
]

{ #category : #'api - column width' }
BrColumn >> columnWidth: aColumnWidth [
	columnWidth = aColumnWidth
		ifTrue: [ ^ self ].

	columnWidth := aColumnWidth.
	self announcer announce: (BrColumnWidthChanged new column: self; columnWidth: aColumnWidth)
]

{ #category : #accessing }
BrColumn >> dataBinder [
	^ dataBinder
]

{ #category : #accessing }
BrColumn >> dataBinder: aStencil [
	"A cell data binder stencil can be a #value-able of the form 
	[ :anItemElement :anItemObject :anItemIndex :aRowHolder :aColumnIndex | ]"
	
	dataBinder := aStencil asStencilBuilder: BrColumnCellDataBinder
]

{ #category : #initialization }
BrColumn >> initialize [
	super initialize.

	title := 'Column'.
	
	cellStencil := BrColumnCellStencilBuilder new.
	dataBinder := BrColumnCellDataBinder new.
	
	columnWidth := BrColumnUndefinedWidth new
]

{ #category : #'api - column width' }
BrColumn >> matchParent [
	"Make a column match parent with a given proportion as a number (usually between 0 and 1)"

	self weight: 1
]

{ #category : #accessing }
BrColumn >> stencil: aStencil [
	"aStencil is a BlockClosure of type [ :aRowObject :aRowIndex :aCellIndex ]"

	self cellStencil: [
		| aCellWrapper |
		aCellWrapper := BlElement new
			layout: BlFrameLayout new;
			constraintsDo: [ :c |
				c vertical fitContent.
				c horizontal matchParent ].
		aCellWrapper ].
	self dataBinder: [ :_ :aRowObject :aRowIndex :aRowHolder :aColumnIndex |
		| aCellChild |
		aCellChild := (aStencil cull: aRowObject cull: aRowIndex cull: aColumnIndex) asElement.
		columnWidth applyOn: aCellChild.
		
		(aRowHolder columnElements at: aColumnIndex)
			removeChildren
			addChild: aCellChild ]
]

{ #category : #accessing }
BrColumn >> title [
	<return: #String>

	^ title
]

{ #category : #accessing }
BrColumn >> title: aStringOrText [
	title := aStringOrText
]

{ #category : #'api - column width' }
BrColumn >> weight: aNumber [
	"Make a column match parent with a given proportion as a number (usually between 0 and 1)"

	self columnWidth: (BrColumnProportionalWidth new weight: aNumber)
]

{ #category : #'api - column width' }
BrColumn >> width [
	<return: #BrColumnWidth>

	self
		deprecated: 'Please use #columnWidth instead'
		transformWith: '`@receiver width' -> '`@receiver columnWidth'.

	^ self columnWidth
]

{ #category : #'api - column width' }
BrColumn >> width: aNumber [
	"Make column occupy a fixed space defined by aNumber"

	self columnWidth: (BrColumnFixedWidth new width: aNumber)
]
