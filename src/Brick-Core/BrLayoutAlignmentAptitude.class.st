Class {
	#name : #BrLayoutAlignmentAptitude,
	#superclass : #BrLazyStyleAptitude,
	#category : #'Brick-Core-Layout Alignment'
}

{ #category : #geometry }
BrLayoutAlignmentAptitude >> bottomCenter: aBlock [
	self
		when: (BrLayoutHorizontalAlignmentState center and: BrLayoutVerticalAlignmentState end)
		style: aBlock
]

{ #category : #geometry }
BrLayoutAlignmentAptitude >> bottomLeft: aBlock [
	self
		when: (BrLayoutHorizontalAlignmentState start and: BrLayoutVerticalAlignmentState end)
		style: aBlock
]

{ #category : #geometry }
BrLayoutAlignmentAptitude >> bottomRight: aBlock [
	self
		when: (BrLayoutHorizontalAlignmentState end and: BrLayoutVerticalAlignmentState end)
		style: aBlock
]

{ #category : #geometry }
BrLayoutAlignmentAptitude >> center: aBlock [	
	self
		when: (BrLayoutHorizontalAlignmentState center and: BrLayoutVerticalAlignmentState center)
		style: aBlock
]

{ #category : #geometry }
BrLayoutAlignmentAptitude >> centerLeft: aBlock [
	self
		when: (BrLayoutHorizontalAlignmentState start and: BrLayoutVerticalAlignmentState center)
		style: aBlock
]

{ #category : #geometry }
BrLayoutAlignmentAptitude >> centerRight: aBlock [
	self
		when: (BrLayoutHorizontalAlignmentState end and: BrLayoutVerticalAlignmentState center)
		style: aBlock
]

{ #category : #initialization }
BrLayoutAlignmentAptitude >> initialize [
	super initialize.
	
	self
		none: [ :aStyle | aStyle alignNone ];
		topLeft: [ :aStyle | aStyle alignTopLeft ];
		topCenter: [ :aStyle | aStyle alignTopCenter ];
		topRight: [ :aStyle | aStyle alignTopRight ];
		centerLeft: [ :aStyle | aStyle alignCenterLeft ];
		center: [ :aStyle | aStyle alignCenter ];
		centerRight: [ :aStyle | aStyle alignCenterRight ];
		bottomLeft: [ :aStyle | aStyle alignBottomLeft ];
		bottomCenter: [ :aStyle | aStyle alignBottomCenter ];
		bottomRight: [ :aStyle | aStyle alignBottomRight ]
]

{ #category : #geometry }
BrLayoutAlignmentAptitude >> none: aBlock [
	self
		when: (BrLayoutHorizontalAlignmentState none and: BrLayoutVerticalAlignmentState none)
		style: aBlock
]

{ #category : #geometry }
BrLayoutAlignmentAptitude >> topCenter: aBlock [
	self
		when: (BrLayoutHorizontalAlignmentState center and: BrLayoutVerticalAlignmentState start)
		style: aBlock
]

{ #category : #geometry }
BrLayoutAlignmentAptitude >> topLeft: aBlock [
	self
		when: (BrLayoutHorizontalAlignmentState start and: BrLayoutVerticalAlignmentState start)
		style: aBlock
]

{ #category : #geometry }
BrLayoutAlignmentAptitude >> topRight: aBlock [
	self
		when: (BrLayoutHorizontalAlignmentState end and: BrLayoutVerticalAlignmentState start)
		style: aBlock
]
