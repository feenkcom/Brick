Class {
	#name : #BrGlamorousEllipsesExpanderAptitude,
	#superclass : #BrGlamorousTriangleInCircleAptitude,
	#category : #'Brick-Glamorous-List, Tree'
}

{ #category : #'as yet unclassified' }
BrGlamorousEllipsesExpanderAptitude >> defaultCollapsedStencil [
	^ [BlElement new
		size: 11 @ 11;
		padding: BlInsets empty;
		addChild: (self dotElement relocate: 0 @ 4);
		addChild: (self dotElement relocate: 4 @ 4);
		addChild: (self dotElement relocate: 8 @ 4);
		yourself] asStencil
]

{ #category : #'as yet unclassified' }
BrGlamorousEllipsesExpanderAptitude >> defaultExpandedStencil [
	^ [BlElement new
		size: 11 @ 11;
		padding: BlInsets empty;
		addChild: (self dotElement relocate: 4 @ 0);
		addChild: (self dotElement relocate: 4 @ 4);
		addChild: (self dotElement relocate: 4 @ 8);
		yourself] asStencil
]

{ #category : #'as yet unclassified' }
BrGlamorousEllipsesExpanderAptitude >> dotElement [
	| dot |
	dot := BlElement new.
	dot geometry: BlCircleGeometry new.
	dot background: Color gray.
	dot size: 3 @ 3.
	^ dot
]
