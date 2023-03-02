Class {
	#name : #BrAnchoredByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Brick-Examples-Anchored'
}

{ #category : #'examples - element' }
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

{ #category : #'examples - in scripter' }
BrAnchoredByScripterExamples >> longContextMenu [
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
