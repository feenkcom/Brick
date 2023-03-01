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
BrAnchoredPositionerByScripterExamples >> anchorPosition: aBlock relocateAnchored: anotherBlock assertAnchoredMaxBounds: yetAnotherBlock [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithElement: [ :aModel :theScripter | self rootContainerWithUserData: theScripter userData ].
	aScripter do
		label: 'Define space extent';
		block: [ :aSpace | aSpace extent: 800 @ 600 ];
		onSpace;
		play.

	aScripter do
		label: 'Relocate anchor';
		block: [ :theScripter | 
			| positioner |
			positioner := theScripter userData at: #container_positioner.
			positioner anchor
				relocate: (aBlock 
					cull: positioner target 
					cull: positioner anchor) ];
		onScripter;
		play.

	aScripter do
		label: 'Resize and relocate popup';
		block: [ :theScripter | 
			| positioner popupSize popupPreferredMaxBoundsInTarget popup |
			positioner := theScripter userData at: #container_positioner.
			popupSize := positioner target size / 4.
			popupPreferredMaxBoundsInTarget := positioner
					maxBoundsPreferredInTarget: popupSize.
			theScripter userData
				at: #popupPreferredMaxBoundsInTarget
				put: popupPreferredMaxBoundsInTarget.

			popup := theScripter userData at: #container_popup.
			popup
				size: popupSize;
				relocate: (anotherBlock 
					cull: popupPreferredMaxBoundsInTarget 
					cull: popupSize) ];
		onScripter;
		play.

	aScripter assert
		label: 'Assert popup bounds in target';
		value: [ :theScripter | theScripter userData at: #popupPreferredMaxBoundsInTarget ]
			equals: [ :theScripter | 
				| positioner popup |
				positioner := theScripter userData at: #container_positioner.
				popup := theScripter userData at: #container_popup.

				yetAnotherBlock
					cull: positioner target
					cull: positioner anchor
					cull: popup ];
		onScripter;
		play.

	^ aScripter
]

{ #category : #'examples  - anchor' }
BrAnchoredPositionerByScripterExamples >> rootContainer [
	<gtExample>
	^ self rootContainerWithUserData: nil
]

{ #category : #'examples  - anchor' }
BrAnchoredPositionerByScripterExamples >> rootContainerWithUserData: aUserData [
	<gtExample>
	| screenContainer targetContainer example positioner anchor target anchorContainer popup rootContainer legendContainer |
	example := self.

	positioner := example anchoredPositioner.
	anchor := positioner anchor.
	target := positioner target.
	anchorContainer := example anchorContainer.
	targetContainer := example targetContainer.
	popup := example popup.
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

	aUserData
		ifNotNil: [ aUserData at: #container_positioner put: positioner.
			aUserData at: #container_popup put: popup ].

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

	^ rootContainer
]

{ #category : #accessing }
BrAnchoredPositionerByScripterExamples >> topLeft_highPopup [
	<gtExample>
	^ self
		anchorPosition: [ :target :anchor | 
			(target size - anchor size) / 8
				+ (0 @ (6 / 8 * (target size - anchor size) y)) ]
		relocateAnchored:
			[ :popupPreferredMaxBoundsInTarget :popupSize | popupPreferredMaxBoundsInTarget bottomLeft - (0 @ popupSize y) ]
		assertAnchoredMaxBounds: [ :target :anchor :popup | 
			BlBounds
				origin: (anchor bounds inSpace inChild: target) left @ 0
				corner: target width @ (anchor bounds inSpace inChild: target) top ]
]
