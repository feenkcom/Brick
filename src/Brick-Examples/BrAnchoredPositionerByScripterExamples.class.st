Class {
	#name : #BrAnchoredPositionerByScripterExamples,
	#superclass : #BrAnchoredPositionerExamples,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Brick-Examples-Anchored'
}

{ #category : #'examples - support' }
BrAnchoredPositionerByScripterExamples >> addLegend: anElement label: label into: legendContainer [
	<gtExample>
	legendContainer
		addChild: (BlElement new
				size: 8 @ 8;
				background: anElement background;
				border: anElement border;
				constraintsDo: [ :c | 
					c margin: (BlInsets right: 5).
					c linear vertical alignCenter ]);
		addChild: (BlTextElement new
				text: (label asRopedText foreground: Color lightGray);
				constraintsDo: [ :c | 
					c margin: (BlInsets right: 10).
					c horizontal fitContent.
					c vertical fitContent.
					c linear vertical alignCenter ])
]

{ #category : #'examples - support' }
BrAnchoredPositionerByScripterExamples >> anchorPosition: anchorPositionBlock relocateAnchored: popupRelocationBlock assertAnchoredMaxBounds: popupMaxBoundsBlock [
	<gtExample>
	| aScripter |
	aScripter := self rootContainerWithDefinedExtent.
	self scripter: aScripter relocateAnchor: anchorPositionBlock.

	aScripter do
		label: 'Resize popup';
		block: [ :theRootContainer | 
			| positioner popupSize popup |
			positioner := theRootContainer userData at: #anchoredPositioner.
			popupSize := positioner target size / 4.

			popup := (theRootContainer query // #popup) result first.
			popup size: popupSize ];
		play.
		
	self scripter: aScripter relocatePopup: popupRelocationBlock.
	
	aScripter assert
		label: 'Assert popup bounds in target';
		value: [ :theRootContainer | theRootContainer userData at: #popupPreferredMaxBoundsInTarget ]
			equals: [ :theRootContainer | 
				| positioner popup |
				positioner := theRootContainer userData at: #anchoredPositioner.
				popup := (theRootContainer query // #popup) result first.
				popupMaxBoundsBlock
					cull: positioner target
					cull: positioner anchor
					cull: popup ];
		play.
	^ aScripter
]

{ #category : #accessing }
BrAnchoredPositionerByScripterExamples >> rightSide [
	<gtExample>
	| aScripter |
	aScripter := self rootContainerWithDefinedExtent.

	self
		scripter: aScripter
		relocateAnchor: [ :target :anchor | (target size x / 12) @ (target size y / 2) ].

	self
		scripter: aScripter
		resizePopup: [ :target :anchor | (target size x / 4) @ (target size y * 0.8) ].

	self
		scripter: aScripter
		relocatePopup: [ :popupPreferredMaxBoundsInTarget :popupSize | 
			popupPreferredMaxBoundsInTarget topLeft ].

	^ aScripter	"^ self
		anchorPosition: [ :target :anchor | (target size - anchor size) / 8 + (0 @ (6 / 8 * (target size - anchor size) y)) ]
		relocateAnchored: [ :popupPreferredMaxBoundsInTarget :popupSize | popupPreferredMaxBoundsInTarget bottomLeft - (0 @ popupSize y) ]
		assertAnchoredMaxBounds: [ :target :anchor :popup | 
			BlBounds
				origin: (anchor bounds inSpace inChild: target) left @ 0
				corner: target width @ (anchor bounds inSpace inChild: target) top ]"
]

{ #category : #'examples - element' }
BrAnchoredPositionerByScripterExamples >> rootContainer [
	<gtExample>
	| screenContainer targetContainer positioner anchor target anchorContainer popup rootContainer legendContainer |
	positioner := self anchoredPositioner.
	anchor := positioner anchor.
	target := positioner target.
	anchorContainer := self anchorContainer.
	targetContainer := self targetContainer.
	popup := self popup.
	anchor constraintsDo: [ :c | c ignoreByLayout ].
	popup constraintsDo: [ :c | c ignoreByLayout ].
	targetContainer addChild: target as: #target.
	target addChild: anchorContainer as: #anchorContainer.
	anchorContainer addChild: anchor as: #anchor.
	target addChild: popup as: #popup.

	screenContainer := BlElement new
			layout: BlLinearLayout horizontal;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].
	screenContainer addChild: targetContainer as: #targetContainer.

	legendContainer := BlElement new
			layout: BlLinearLayout horizontal;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical fitContent.
				c padding: (BlInsets top: 10) ].

	self
		addLegend: targetContainer
		label: 'target container'
		into: legendContainer.
	self
		addLegend: target
		label: 'target'
		into: legendContainer.
	self
		addLegend: anchorContainer
		label: 'anchor container'
		into: legendContainer.
	self
		addLegend: popup
		label: 'popup'
		into: legendContainer.
	self
		addLegend: anchor
		label: 'anchor'
		into: legendContainer.

	rootContainer := BlElement new
			layout: BlLinearLayout vertical;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			addChild: screenContainer as: #screenContainer;
			addChild: legendContainer as: #legendContainer;
			id: #rootContainer.

	rootContainer userData at: #anchoredPositioner put: positioner.

	^ rootContainer
]

{ #category : #'examples - support' }
BrAnchoredPositionerByScripterExamples >> rootContainerWithDefinedExtent [
	| aScripter |
	aScripter := self scripterWithElement: [ :aModel | self rootContainer ].
	aScripter do
		label: 'Define space extent';
		block: [ :aSpace | aSpace extent: 800 @ 600 ];
		onSpace;
		play.
	^ aScripter
]

{ #category : #'examples - support' }
BrAnchoredPositionerByScripterExamples >> scripter: aScripter relocateAnchor: anchorPositionBlock [
	<gtExample>
	aScripter do
		label: 'Relocate anchor';
		block: [ :theRootContainer | 
			| positioner |
			positioner := theRootContainer userData at: #anchoredPositioner.
			positioner anchor
				relocate: (anchorPositionBlock cull: positioner target cull: positioner anchor) ];
		play
]

{ #category : #'examples - support' }
BrAnchoredPositionerByScripterExamples >> scripter: aScripter relocatePopup: popupRelocationBlock [
	<gtExample>
	aScripter do
		label: 'Relocate popup';
		block: [ :theRootContainer | 
			| positioner popupSize popupPreferredMaxBoundsInTarget popup |
			positioner := theRootContainer userData at: #anchoredPositioner.
			popup := (theRootContainer query // #popup) result first.
			popupSize := popup size.
			popupPreferredMaxBoundsInTarget := positioner
					maxBoundsPreferredInTarget: popupSize.
			theRootContainer userData
				at: #popupPreferredMaxBoundsInTarget
				put: popupPreferredMaxBoundsInTarget.
			popup
				relocate: (popupRelocationBlock cull: popupPreferredMaxBoundsInTarget cull: popupSize) ];
		play
]

{ #category : #'examples - support' }
BrAnchoredPositionerByScripterExamples >> scripter: aScripter resizePopup: popupSizeBlock [
	<gtExample>
	aScripter do
		label: 'Resize popup';
		block: [ :theRootContainer | 
			| positioner popup |
			positioner := theRootContainer userData at: #anchoredPositioner.
			popup := (theRootContainer query // #popup) result first.
			popup size: (popupSizeBlock cull: positioner target cull: positioner anchor) ];
		play
]
