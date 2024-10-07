Class {
	#name : #BrGlamorousEllipsesExpanderAptitude,
	#superclass : #BrGlamorousTriangleInCircleAptitude,
	#category : #'Brick-Glamorous-List, Tree'
}

{ #category : #'as yet unclassified' }
BrGlamorousEllipsesExpanderAptitude >> defaultCollapsedStencil [
	^ BlElement new
		size: 11 @ 11;
		padding: BlInsets empty;
		background: Color lightGray twiceLighter;
		addChild: (self dotElement relocate: 2 @ 5);
		addChild: (self dotElement relocate: 5 @ 5);
		addChild: (self dotElement relocate: 8 @ 5);
		yourself
]

{ #category : #'as yet unclassified' }
BrGlamorousEllipsesExpanderAptitude >> defaultExpandedStencil [
	^ BlElement new
		size: 11 @ 11;
		padding: BlInsets empty;
		background: Color lightGray twiceLighter;
		addChild: (self dotElement relocate: 5 @ 2);
		addChild: (self dotElement relocate: 5 @ 5);
		addChild: (self dotElement relocate: 5 @ 8);
		yourself
]

{ #category : #'as yet unclassified' }
BrGlamorousEllipsesExpanderAptitude >> dotElement [
	| dot |
	dot := BlElement new.
	dot background: Color lightGray.
	dot size: 2 @ 2.
	^ dot
]
