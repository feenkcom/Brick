Class {
	#name : #BrAnchoredByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Brick-Examples-Anchored'
}

{ #category : #'examples - context menu' }
BrAnchoredByScripterExamples >> dropdownBottomRight [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithElement: [ self elementWithDropdown ].

	aScripter do
		label: 'Set space extent';
		block: [ :aSpace | aSpace extent: 650 @ 600 ];
		onSpace;
		play.

	aScripter click
		label: 'Open dropdown';
		id: #dropdownAnchor;
		play.
		
	aScripter assert
		label: 'Assert dropdown extent';
		value: [ :aContentElement | aContentElement extent ]
			equals: [ :aContentElement | 
				| aChild |
				aChild := (aContentElement childWithId: #labelContent).
				aChild extent + aChild margin extent ];
		onSpaceRoot;
		onBreadthFirstChildOfClass: BrAnchoredOuterContainer;
		onChildOfClass: BrAnchoredElement;
		id: #content;
		play.


	^ aScripter
]

{ #category : #'examples - context menu' }
BrAnchoredByScripterExamples >> elementWithDropdown [
	<gtExample>
	| handleSize handle content container anchor anchorContainer |
	handleSize := 50 @ 50.
	handle := [ BlElement new
		size: handleSize;
		yourself ] asStencil.
	content := [ (BrLabel new
		id: #labelContent;
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
		yourself.
	anchor := BlElement new
		id: #dropdownAnchor;
		aptitude:
			((BrGlamorousWithDropdownAptitude handle: handle content: content)
				root: container;
				yourself);
		background: Color red;
		size: 40 @ 80;
		addEventHandler: BlPullHandler new;
		yourself.
	anchorContainer := BlElement new
		id: #contextMenuAnchor;
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

{ #category : #'examples - context menu' }
BrAnchoredByScripterExamples >> elementWithLongContextMenu [
	<gtExample>
	| handleSize handle content container anchor anchorContainer |
	handleSize := 8 @ 8.
	handle := [ BlElement new
			size: handleSize;
			yourself ] asStencil.
	content := [ (BrVerticalPane new fitContent
			id: #itemsContainer;
			in: [ :thePane | 
				1
					to: 12
					do: [ :anIndex | 
						thePane
							addChild: (BrLabel new
									aptitude: (BrGlamorousLabelAptitude new
											glamorousRegularFontAndSize;
											yourself);
									padding: (BlInsets all: handleSize x);
									text: 'item ' , anIndex asString;
									yourself) ] ];
			yourself) asScrollableElement
			alignCenter;
			id: #itemsScrollableContainer;
			yourself ] asStencil.
	container := BlElement new
			background: Color gray muchLighter;
			layout: BlLinearLayout vertical alignCenter;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			yourself.
	anchor := BlElement new
			aptitude: (BrGlamorousWithContextMenuAptitude handle: handle content: content);
			id: #contextMenuAnchor;
			background: Color red;
			size: 40 @ 80;
			addEventHandler: BlPullHandler new;
			yourself.
	anchorContainer := BlElement new
			background: Color red muchLighter;
			size: 400 @ 200;
			clipChildren: false;
			addChild: anchor;
			yourself.
	^ container
		addChild: anchorContainer;
		yourself
]

{ #category : #'examples - context menu' }
BrAnchoredByScripterExamples >> longContextMenuTheLeft [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithElement: [ self elementWithLongContextMenu ].

	aScripter do
		label: 'Set space extent';
		block: [ :aSpace | aSpace extent: 300 @ 500 ];
		onSpace;
		play.
		
	aScripter do 
		label: 'Relocate anchor';
		block: [ :anAnchor | anAnchor relocate: 300@0 ];
		id: #contextMenuAnchor;
		play.

	aScripter secondaryClick
		label: 'Open context menu';
		id: #contextMenuAnchor;
		play.

	aScripter assert
		label: 'Assert context menu height';
		value: [ :aPane | aPane height ]
			equals: [ :aPane | 
				| aChild |
				aChild := (aPane childWithId: #itemsContainer).
				aChild height + aChild margin height ];
		onSpaceRoot;
		id: #itemsScrollableContainer;
		play.

	^ aScripter
]

{ #category : #'examples - context menu' }
BrAnchoredByScripterExamples >> longContextMenuTheRight [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithElement: [ self elementWithLongContextMenu ].

	aScripter do
		label: 'Set space extent';
		block: [ :aSpace | aSpace extent: 650 @ 500 ];
		onSpace;
		play.

	aScripter secondaryClick
		label: 'Open context menu';
		id: #contextMenuAnchor;
		play.

	aScripter assert
		label: 'Assert context menu height';
		value: [ :aPane | aPane height ]
			equals: [ :aPane | 
				| aChild |
				aChild := (aPane childWithId: #itemsContainer).
				aChild height + aChild margin height ];
		onSpaceRoot;
		id: #itemsScrollableContainer;
		play.

	^ aScripter
]
