Class {
	#name : #BrAnchoredExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Anchored'
}

{ #category : #accessing }
BrAnchoredExamples >> contextMenu [
	<gtExample>
	| handleSize handle content container anchor anchorContainer |
	handleSize := 8 @ 8.
	handle := [ BlElement new
		size: handleSize;
		yourself ] asStencil.
	content := [ (BrLabel new
		aptitude:
			(BrGlamorousLabelAptitude new
				glamorousRegularFontAndSize;
				yourself);
		padding: (BlInsets all: handleSize x);
		text: 'look at me!';
		yourself) asScrollableElement
		alignCenter;
		yourself ] asStencil.
	container := BlElement new
		background: Color gray muchLighter;
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		transformDo: [ :t | 
			t
				origin: BlAffineTransformationTopLeftOrigin new;
				rotateBy: 30;
				translateBy: 400 @ 100;
				scaleBy: 0.5 ];
		yourself.
	anchor := BlElement new
		aptitude: (BrGlamorousWithContextMenuAptitude handle: handle content: content);
		background: Color red;
		size: 40 @ 80;
		addEventHandler: BlPullHandler new;
		yourself.
	anchorContainer := BlElement new
		background: Color red muchLighter;
		relocate: 200 @ 250;
		size: 400 @ 200;
		constraintsDo: [ :c | c ignoreByLayout ];
		clipChildren: false;
		addChild: anchor;
		yourself.
	^ container
		addChild: anchorContainer;
		yourself
]

{ #category : #accessing }
BrAnchoredExamples >> dropdown [
	<gtExample>
	| handleSize handle content container anchor anchorContainer |
	handleSize := 50 @ 50.
	handle := [ BlElement new
		size: handleSize;
		yourself ] asStencil.
	content := [ (BrLabel new
		aptitude:
			(BrGlamorousLabelAptitude new
				glamorousRegularFontAndSize;
				yourself);
		padding: (BlInsets all: handleSize x);
		text: 'look at me!';
		yourself) asScrollableElement
		alignCenter;
		yourself ] asStencil.
	container := BlElement new
		background: Color gray muchLighter;
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		transformDo: [ :t | 
			t
				origin: BlAffineTransformationTopLeftOrigin new;
				rotateBy: 30;
				translateBy: 400 @ 100;
				scaleBy: 0.5 ];
		yourself.
	anchor := BlElement new
		aptitude:
			((BrGlamorousWithDropdownAptitude handle: handle content: content)
				root: container;
				yourself);
		background: Color red;
		size: 40 @ 80;
		addEventHandler: BlPullHandler new;
		yourself.
	anchorContainer := BlElement new
		background: Color red muchLighter;
		relocate: 200 @ 250;
		size: 400 @ 200;
		constraintsDo: [ :c | c ignoreByLayout ];
		clipChildren: false;
		addChild: anchor;
		yourself.
	^ container
		addChild: anchorContainer;
		yourself
]

{ #category : #accessing }
BrAnchoredExamples >> tooltip [
	<gtExample>
	| tip |
	tip := [ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularFontAndSize);
		padding: (BlInsets all: 20);
		text: 'no transformation affects me!';
		alignCenter ] asStencil.
	^ BlElement new
		aptitude: (BrGlamorousWithTooltipAptitude content: tip);
		background: Color red;
		size: 80 @ 100;
		addEventHandler: BlPullHandler new.
]

{ #category : #accessing }
BrAnchoredExamples >> tooltipStaysLevel [
	<gtExample>
	| container anchorContainer |
	container := BlElement new
		background: Color gray muchLighter;
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		transformDo: [ :t | t 
				origin: BlAffineTransformationTopLeftOrigin new;
				rotateBy: 30;
				translateBy: 500 @ 100;
				scaleBy: 0.5 ].

	anchorContainer := BlElement new
		background: Color paleRed;
		relocate: 100 @ 150;
		size: 400 @ 200;
		constraintsDo: [ :c | c ignoreByLayout ];
		addChild: self tooltip.
	^ container addChild: anchorContainer
]
