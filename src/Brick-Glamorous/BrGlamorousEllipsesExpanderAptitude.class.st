Class {
	#name : #BrGlamorousEllipsesExpanderAptitude,
	#superclass : #BrGlamorousTriangleInCircleExpanderAptitude,
	#category : #'Brick-Glamorous-List, Tree'
}

{ #category : #defaults }
BrGlamorousEllipsesExpanderAptitude >> defaultCollapsedStencil [
	^ [BlElement new
		size: 11 @ 11;
		padding: BlInsets empty;
		addChild: (self dotElement relocate: 0 @ 4);
		addChild: (self dotElement relocate: 4 @ 4);
		addChild: (self dotElement relocate: 8 @ 4);
		yourself] asStencil
]

{ #category : #defaults }
BrGlamorousEllipsesExpanderAptitude >> defaultExpandedStencil [
	^ [BlElement new
		size: 11 @ 11;
		padding: BlInsets empty;
		addChild: (self dotElement relocate: 4 @ 0);
		addChild: (self dotElement relocate: 4 @ 4);
		addChild: (self dotElement relocate: 4 @ 8);
		yourself] asStencil
]

{ #category : #defaults }
BrGlamorousEllipsesExpanderAptitude >> dotElement [
	| dot |
	dot := BlElement new.
	dot geometry: BlCircleGeometry new.
	dot background: Color gray.
	dot size: 3 @ 3.
	^ dot
]
