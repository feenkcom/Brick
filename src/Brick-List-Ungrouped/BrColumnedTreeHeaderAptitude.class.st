"
Columned tree headers reuse the columned list header composition, icons and resizers. Rebuild on tree data changes.
"
Class {
	#name : #BrColumnedTreeHeaderAptitude,
	#superclass : #BrColumnedListHeaderAptitude,
	#instVars : [
		'headerElementId',
		'resizerIdStencil'
	],
	#category : #'Brick-List-Ungrouped-Aptitudes'
}

{ #category : #building }
BrColumnedTreeHeaderAptitude >> buildColumnHeadersInto: header [
	super buildColumnHeadersInto: header.
	header children ifNotEmpty: [ header children first padding: (BlInsets left: BrColumnedTreeRowDataBinder expanderInset) ]
]

{ #category : #initialization }
BrColumnedTreeHeaderAptitude >> initialize [
	super initialize.
	self when: BrTreeChildrenChanged do: [ :event | self rebuildHeadersDueTo: event ]
]
