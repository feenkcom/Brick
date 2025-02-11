"
I am a text attribute that adds a small expand button that when clicked may apply further attributes on the text
"
Class {
	#name : #BrGlamorousTriangleExpanderTextAttribute,
	#superclass : #BrTextExpandButtonAttribute,
	#category : #'Brick-Glamorous'
}

{ #category : #accessing }
BrGlamorousTriangleExpanderTextAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| aToggle |
	aToggle := BrInlineExpanderElement new
			id: self id;
			aptitude: BrGlamorousTriangleInCircleExpanderAptitude;
			expanded: self isExpanded;
			padding: (BlInsets all: 2);
			margin: (BlInsets top: 2);
			mouseCursor: BlCursor default;
			toggleAction: [ self toggleExpandedOrCollapsedAttributesOn: aTBrTextEditorTextualPiece ].

	self applyExpandedOrCollapsedAttributesOnText: aTBrTextEditorTextualPiece text.

	^ aToggle
]
