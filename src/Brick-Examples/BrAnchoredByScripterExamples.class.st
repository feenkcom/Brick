Class {
	#name : #BrAnchoredByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Brick-Examples-Anchored'
}

{ #category : #'examples - dropdown' }
BrAnchoredByScripterExamples >> assertDropdown: aScripter [
	aScripter assert
		label: 'Assert dropdown extent';
		value: [ :aContentElement | aContentElement extent ]
			equals: [ :aContentElement | 
				| aChild |
				aChild := aContentElement childWithId: #labelContent.
				aChild extent + aChild margin extent ];
		onSpaceRoot;
		// BrAnchoredOuterContainer;
		// BrAnchoredElement;
		/ #content asBlocElementId;
		play.

	aScripter assert
		label: 'Assert dropdown bounds';
		satisfies: [ :aContentElement | 
			| aParentQuery |
			aParentQuery := aContentElement topMostParent query // #placementArea.
			self assert: aParentQuery result size equals: 1.

			aParentQuery result first bounds inSpace asRectangle
				containsRect: aContentElement bounds inSpace asRectangle ];
		onSpaceRoot;
		// BrAnchoredOuterContainer;
		// BrAnchoredElement;
		/ #content asBlocElementId;
		play
]

{ #category : #'examples - tooltip' }
BrAnchoredByScripterExamples >> assertTooltip: aScripter [
	aScripter assert
		label: 'Assert tooltip extent';
		value: [ :aContentElement | aContentElement extent ]
			equals: [ :aContentElement | 
				| aQuery aChild |
				aQuery := aContentElement query // BrLabel.
				self assert: aQuery result size equals: 1.
				
				aChild := aQuery result first.
				aChild extent + aChild margin extent ];
		onSpaceRoot;
		// BrAnchoredOuterContainer;
		// BrAnchoredElement;
		/ #content asBlocElementId;
		play.

	aScripter assert
		label: 'Assert tooltip bounds';
		satisfies: [ :aContentElement | 
			| aParentQuery |
			aParentQuery := aContentElement topMostParent query // #placementArea.
			self assert: aParentQuery result size equals: 1.

			aParentQuery result first bounds inSpace asRectangle
				containsRect: aContentElement bounds inSpace asRectangle ];
		onSpaceRoot;
		// BrAnchoredOuterContainer;
		// BrAnchoredElement;
		/ #content asBlocElementId;
		play
]

{ #category : #'examples - dropdown' }
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
		id: #anchorElement;
		play.
		
	aScripter do
		label: 'Setup dropdown overview';
		block: [ :aButton :aUserData | 
			aUserData at: BrAnchoredVisualAnalysis put: (
				BrAnchoredVisualAnalysis new
					elementWithDropdown: aButton) ];
		id: #anchorElement;
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

{ #category : #'examples - dropdown' }
BrAnchoredByScripterExamples >> dropdownBottomRight_AnchorMoreToTheRight [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithElement: [ self elementWithDropdown ].

	aScripter do
		label: 'Set space extent';
		block: [ :aSpace | aSpace extent: 650 @ 600 ];
		onSpace;
		play.
		
	aScripter do 
		label: 'Relocate anchor';
		block: [ :anAnchor | anAnchor relocate: 250@0 ];
		id: #anchorElement;
		play.

	aScripter click
		label: 'Open dropdown';
		id: #anchorElement;
		play.
		
	aScripter do
		label: 'Setup dropdown overview';
		block: [ :aButton :aUserData | 
			aUserData at: BrAnchoredVisualAnalysis put: (
				BrAnchoredVisualAnalysis new
					elementWithDropdown: aButton) ];
		id: #anchorElement;
		play.
		
	self assertDropdown: aScripter.

	^ aScripter
]

{ #category : #'examples - dropdown' }
BrAnchoredByScripterExamples >> dropdownBottomRight_AnchorMoreToTheRight_ByOnePixel [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithElement: [ self elementWithDropdown ].
	
	aScripter do
		label: 'Set space extent';
		block: [ :aSpace | aSpace extent: 650 @ 600 ];
		onSpace;
		play.
		
	aScripter do
		label: 'Relocate anchor';
		block: [ :anAnchor | anAnchor relocate: 251 @ 0 ];
		id: #anchorElement;
		play.
		
	aScripter click
		label: 'Open dropdown';
		id: #anchorElement;
		play.
		
	aScripter do
		label: 'Setup dropdown overview';
		block: [ :aButton :aUserData | 
			aUserData at: BrAnchoredVisualAnalysis put: (
				BrAnchoredVisualAnalysis new
					elementWithDropdown: aButton) ];
		id: #anchorElement;
		play.
		
	self assertDropdown: aScripter.
	
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
		id: #placementArea;
		background: Color gray muchLighter;
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.
	anchor := BlElement new
		id: #anchorElement;
		aptitude:
			((BrGlamorousWithDropdownAptitude handle: handle content: content)
				root: container;
				yourself);
		background: Color red;
		size: 40 @ 80;
		addEventHandler: BlPullHandler new;
		yourself.
	anchorContainer := BlElement new
		id: #anchorContainer;
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
									text: anIndex asString, ' - item with some extra text';
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
			id: #anchorElement;
			background: Color red;
			size: 40 @ 80;
			addEventHandler: BlPullHandler new;
			yourself.
	anchorContainer := BlElement new
			id: #anchorContainer;
			background: Color red muchLighter;
			size: 400 @ 200;
			clipChildren: false;
			addChild: anchor;
			yourself.
	^ container
		addChild: anchorContainer;
		yourself
]

{ #category : #'examples - tooltip' }
BrAnchoredByScripterExamples >> elementWithLongLabelTooltip [
	<gtExample>
	| container anchor anchorContainer |

	container := BlElement new
		id: #placementArea;
		background: Color gray muchLighter;
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.
	anchor := BlElement new
		id: #anchorElement;
		aptitude:
			(BrGlamorousWithLabelTooltipAptitude new
				text: 'I am a very loooooooong label tooltip';
				root: container;
				yourself);
		background: Color red;
		size: 40 @ 80;
		addEventHandler: BlPullHandler new;
		yourself.
	anchorContainer := BlElement new
		id: #anchorContainer;
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

{ #category : #'examples - tooltip' }
BrAnchoredByScripterExamples >> elementWithShortLabelTooltip [
	<gtExample>
	| container anchor anchorContainer |

	container := BlElement new
		id: #placementArea;
		background: Color gray muchLighter;
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		yourself.
	anchor := BlElement new
		id: #anchorElement;
		aptitude:
			(BrGlamorousWithLabelTooltipAptitude new
				text: 'I am a tooltip';
				root: container;
				yourself);
		background: Color red;
		size: 40 @ 80;
		addEventHandler: BlPullHandler new;
		yourself.
	anchorContainer := BlElement new
		id: #anchorContainer;
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
		block: [ :anAnchor | anAnchor relocate: 300 @ 0 ];
		id: #anchorElement;
		play.

	aScripter secondaryClick
		label: 'Open context menu';
		id: #anchorElement;
		play.

	aScripter assert
		label: 'Assert context menu extent';
		value: [ :aPane | aPane extent ]
			equals: [ :aPane | 
				| aChild |
				aChild := aPane childWithId: #itemsContainer.
				aChild extent + aChild margin extent ];
		onSpaceRoot;
		id: #itemsScrollableContainer;
		play.

	aScripter assert
		label: 'Assert anchored element height';
		value: [ :anInnerContainer | anInnerContainer height ]
			equals: [ :anInnerContainer | 
				| aChild |
				aChild := anInnerContainer childWithId: #itemsScrollableContainer.
				aChild height + aChild margin height ];
		onSpaceRoot;
		// BrAnchoredElement;
		play.

	^ aScripter
]

{ #category : #'examples - context menu' }
BrAnchoredByScripterExamples >> longContextMenuTheLeft_AnchorMoreToTheRight [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithElement: [ self elementWithLongContextMenu ].

	aScripter do
		label: 'Set space extent';
		block: [ :aSpace | aSpace extent: 650 @ 500 ];
		onSpace;
		play.
		
	aScripter do 
		label: 'Relocate anchor';
		block: [ :anAnchor | anAnchor relocate: 310@0 ];
		id: #anchorElement;
		play.

	aScripter secondaryClick
		label: 'Open context menu';
		id: #anchorElement;
		play.

	aScripter assert
		label: 'Assert context menu extent';
		value: [ :aPane | aPane extent ]
			equals: [ :aPane | 
				| aChild |
				aChild := (aPane childWithId: #itemsContainer).
				aChild extent + aChild margin extent ];
		onSpaceRoot;
		id: #itemsScrollableContainer;
		play.
		
	aScripter assert
		label: 'Assert anchored element height';
		value: [ :anInnerContainer | anInnerContainer height ]
			equals: [ :anInnerContainer | 
				| aChild |
				aChild := (anInnerContainer childWithId: #itemsScrollableContainer).
				aChild height + aChild margin height ];
		onSpaceRoot;
		// BrAnchoredElement;
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
		id: #anchorElement;
		play.

	aScripter assert
		label: 'Assert context menu extent';
		value: [ :aPane | aPane extent ]
			equals: [ :aPane | 
				| aChild |
				aChild := (aPane childWithId: #itemsContainer).
				aChild extent + aChild margin extent ];
		onSpaceRoot;
		id: #itemsScrollableContainer;
		play.
		
	aScripter assert
		label: 'Assert anchored element height';
		value: [ :anInnerContainer | anInnerContainer height ]
			equals: [ :anInnerContainer | 
				| aChild |
				aChild := (anInnerContainer childWithId: #itemsScrollableContainer).
				aChild height + aChild margin height ];
		onSpaceRoot;
		// BrAnchoredElement;
		play.

	^ aScripter
]

{ #category : #'examples - context menu' }
BrAnchoredByScripterExamples >> longContextMenuTheRight_AnchorMoreToTheRight [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithElement: [ self elementWithLongContextMenu ].

	aScripter do
		label: 'Set space extent';
		block: [ :aSpace | aSpace extent: 650 @ 500 ];
		onSpace;
		play.
		
	aScripter do 
		label: 'Relocate anchor';
		block: [ :anAnchor | anAnchor relocate: 309@0 ];
		id: #anchorElement;
		play.

	aScripter secondaryClick
		label: 'Open context menu';
		id: #anchorElement;
		play.
		
	aScripter do
		label: 'Setup dropdown overview';
		block: [ :aButton :aUserData | 
			aUserData at: BrAnchoredVisualAnalysis put: (
				BrAnchoredVisualAnalysis new
					elementWithDropdown: aButton) ];
		id: #anchorElement;
		play.

	aScripter assert
		label: 'Assert context menu extent';
		value: [ :aPane | aPane extent ]
			equals: [ :aPane | 
				| aChild |
				aChild := (aPane childWithId: #itemsContainer).
				aChild extent + aChild margin extent ];
		onSpaceRoot;
		id: #itemsScrollableContainer;
		play.
		
	aScripter assert
		label: 'Assert anchored element height';
		value: [ :anInnerContainer | anInnerContainer height ]
			equals: [ :anInnerContainer | 
				| aChild |
				aChild := (anInnerContainer childWithId: #itemsScrollableContainer).
				aChild height + aChild margin height ];
		onSpaceRoot;
		// BrAnchoredElement;
		play.

	^ aScripter
]

{ #category : #'examples - tooltip' }
BrAnchoredByScripterExamples >> tooltipLongLabelCenterLeft_AnchorMoreToTheRight [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithElement: [ self elementWithLongLabelTooltip ].

	aScripter do
		label: 'Set space extent';
		block: [ :aSpace | aSpace extent: 650 @ 600 ];
		onSpace;
		play.

	aScripter mouseMoveOver
		label: 'Open tooltip';
		id: #anchorElement;
		play.
		
	aScripter do 
		label: 'Relocate anchor';
		block: [ :anAnchor | anAnchor relocate: 330@0 ];
		id: #anchorElement;
		play.
		
	aScripter do
		label: 'Setup tooltip overview';
		block: [ :aButton :aUserData | 
			aUserData at: BrAnchoredVisualAnalysis put: (
				BrAnchoredVisualAnalysis new
					elementWithTooltip: aButton) ];
		id: #anchorElement;
		play.
		
	self assertTooltip: aScripter.

	^ aScripter
]

{ #category : #'examples - tooltip' }
BrAnchoredByScripterExamples >> tooltipShortLabelBottomCenter [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithElement: [ self elementWithShortLabelTooltip ].

	aScripter do
		label: 'Set space extent';
		block: [ :aSpace | aSpace extent: 650 @ 600 ];
		onSpace;
		play.

	aScripter mouseMoveOver
		label: 'Open tooltip';
		id: #anchorElement;
		play.
		
	aScripter do
		label: 'Setup tooltip overview';
		block: [ :aButton :aUserData | 
			aUserData at: BrAnchoredVisualAnalysis put: (
				BrAnchoredVisualAnalysis new
					elementWithTooltip: aButton) ];
		id: #anchorElement;
		play.

	self assertTooltip: aScripter.

	^ aScripter
]

{ #category : #'examples - tooltip' }
BrAnchoredByScripterExamples >> tooltipShortLabelBottomCenter_AnchorMoreToTheRight [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithElement: [ self elementWithShortLabelTooltip ].

	aScripter do
		label: 'Set space extent';
		block: [ :aSpace | aSpace extent: 650 @ 600 ];
		onSpace;
		play.

	aScripter mouseMoveOver
		label: 'Open tooltip';
		id: #anchorElement;
		play.
		
	aScripter do 
		label: 'Relocate anchor';
		block: [ :anAnchor | anAnchor relocate: 337@0 ];
		id: #anchorElement;
		play.
		
	aScripter do
		label: 'Setup tooltip overview';
		block: [ :aButton :aUserData | 
			aUserData at: BrAnchoredVisualAnalysis put: (
				BrAnchoredVisualAnalysis new
					elementWithTooltip: aButton) ];
		id: #anchorElement;
		play.
		
	self assertTooltip: aScripter.

	^ aScripter
]
