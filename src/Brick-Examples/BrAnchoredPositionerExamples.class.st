Class {
	#name : #BrAnchoredPositionerExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Anchored'
}

{ #category : #'examples - element' }
BrAnchoredPositionerExamples >> anchor [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		size: 30 @ 20;
		background: Color purple;
		yourself
]

{ #category : #'examples - element' }
BrAnchoredPositionerExamples >> anchorContainer [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		layout: BlLinearLayout horizontal;
		background: Color tan;
		padding: (BlInsets
				top: 5
				left: 7
				bottom: 11
				right: 17);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		yourself
]

{ #category : #'examples - support' }
BrAnchoredPositionerExamples >> anchorPosition: aBlock relocateAnchored: anotherBlock assertAnchoredMaxBounds: yetAnotherBlock [
	| space positioner anchor anchorContainer target targetContainer popup popupSize popupPreferredMaxBoundsInTarget |
	space := BlSpace new
		extent: 800 @ 600;
		yourself.
	positioner := self anchoredPositioner.
	anchor := positioner anchor.
	target := positioner target.
	anchorContainer := self anchorContainer.
	targetContainer := self targetContainer.
	popup := self popup.
	anchor constraintsDo: [ :c | c ignoreByLayout ].
	popup constraintsDo: [ :c | c ignoreByLayout ].
	targetContainer addChild: target.
	target addChild: anchorContainer.
	anchorContainer addChild: anchor.
	target addChild: popup.
	space root
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		addChild: targetContainer.
	space doUpdateLayout.
	anchor relocate: (aBlock cull: target cull: anchor).
	space doUpdateLayout.
	popupSize := target size / 4.
	popupPreferredMaxBoundsInTarget := positioner
		maxBoundsPreferredInTarget: popupSize.
	popup
		size: popupSize;
		relocate: (anotherBlock cull: popupPreferredMaxBoundsInTarget cull: popupSize).
	self
		assert:
			popupPreferredMaxBoundsInTarget
				= (yetAnotherBlock cull: target cull: anchor cull: popup).
	^ space
]

{ #category : #'examples - positioner' }
BrAnchoredPositionerExamples >> anchoredPositioner [
	<gtExample>
	<return: #BrAnchoredPositioner>
	^ BrAnchoredPositioner anchor: self anchor target: self target
]

{ #category : #'examples  - anchor' }
BrAnchoredPositionerExamples >> bottomLeft [
	<gtExample>
	<return: #BlSpace>
	^ self
		anchorPosition: [ :target :anchor | 7 * (target size - anchor size) / 8 - (0 @ (6 / 8 * target height)) ]
		relocateAnchored: [ :popupPreferredMaxBoundsInTarget :popupSize | popupPreferredMaxBoundsInTarget topRight - (popupSize x @ 0) ]
		assertAnchoredMaxBounds: [ :target :anchor :popup | 
			BlBounds
				origin: 0 @ (anchor bounds inSpace inChild: target) bottom
				corner: (anchor bounds inSpace inChild: target) right @ target height ]
]

{ #category : #'examples  - anchor' }
BrAnchoredPositionerExamples >> bottomRight [
	<gtExample>
	<return: #BlSpace>
	^ self
		anchorPosition: [ :target :anchor | (target size - anchor size) / 8 ]
		relocateAnchored: [ :popupPreferredMaxBoundsInTarget :popupSize | popupPreferredMaxBoundsInTarget topLeft ]
		assertAnchoredMaxBounds: [ :target :anchor :popup | 
			BlBounds
				origin: (anchor bounds inSpace inChild: target) bottomLeft
				corner: target size ]
]

{ #category : #'examples  - anchor' }
BrAnchoredPositionerExamples >> defaultToBottomRight [
	<gtExample>
	<return: #BlSpace>
	^ self
		anchorPosition: [ :target :anchor | (target size - anchor size) / 2 ]
		relocateAnchored: [ :popupPreferredMaxBoundsInTarget :popupSize | popupPreferredMaxBoundsInTarget topLeft ]
		assertAnchoredMaxBounds: [ :target :anchor :popup | 
			BlBounds
				origin: (anchor bounds inSpace inChild: target) bottomLeft
				corner: target size ]
]

{ #category : #'examples - element' }
BrAnchoredPositionerExamples >> popup [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		background: Color white;
		border: (BlBorder paint: Color purple asBlPaint width: 1);
		yourself
]

{ #category : #'examples - element' }
BrAnchoredPositionerExamples >> target [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		layout: BlLinearLayout horizontal;
		size: 300 @ 200;
		transformDo: [ :t | t scaleBy: 0.5 @ 0.5 ];
		background: Color gray;
		padding: (BlInsets
				top: 5
				left: 7
				bottom: 11
				right: 17);
		yourself
]

{ #category : #'examples - element' }
BrAnchoredPositionerExamples >> targetContainer [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		layout: BlLinearLayout horizontal;
		background: Color veryVeryLightGray;
		padding: (BlInsets
				top: 5
				left: 7
				bottom: 11
				right: 17);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		yourself
]

{ #category : #'examples  - anchor' }
BrAnchoredPositionerExamples >> topLeft [
	<gtExample>
	<return: #BlSpace>
	^ self
		anchorPosition: [ :target :anchor | 7 * (target size - anchor size) / 8 ]
		relocateAnchored: [ :popupPreferredMaxBoundsInTarget :popupSize | popupPreferredMaxBoundsInTarget bottomRight - popupSize ]
		assertAnchoredMaxBounds: [ :target :anchor :popup | BlBounds origin: 0 @ 0 corner: (anchor bounds inSpace inChild: target) topRight ]
]

{ #category : #'examples  - anchor' }
BrAnchoredPositionerExamples >> topRight [
	<gtExample>
	<return: #BlSpace>
	^ self
		anchorPosition: [ :target :anchor | (target size - anchor size) / 8 + (0 @ (6 / 8 * (target size - anchor size) y)) ]
		relocateAnchored: [ :popupPreferredMaxBoundsInTarget :popupSize | popupPreferredMaxBoundsInTarget bottomLeft - (0 @ popupSize y) ]
		assertAnchoredMaxBounds: [ :target :anchor :popup | 
			BlBounds
				origin: (anchor bounds inSpace inChild: target) left @ 0
				corner: target width @ (anchor bounds inSpace inChild: target) top ]
]
