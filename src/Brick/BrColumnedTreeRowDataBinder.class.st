"
Keeps tree indentation inside the first column's allocated width instead of shifting all subsequent columns.
"
Class {
	#name : #BrColumnedTreeRowDataBinder,
	#superclass : #BrDefaultTreeRowDataBinder,
	#category : #'Brick-Tree - Stencil'
}

{ #category : #layout }
BrColumnedTreeRowDataBinder class >> expanderInset [
	"Space for the expander and the gap before first-column content. Shared by rows and headers."
	^ 20
]

{ #category : #building }
BrColumnedTreeRowDataBinder >> buildDefault [
	super buildDefault.
	self rowElement children size > 1 ifTrue: [
		self rowElement children first padding: (BlInsets left: self itemNode depth * 15 + self class expanderInset) ]
]
