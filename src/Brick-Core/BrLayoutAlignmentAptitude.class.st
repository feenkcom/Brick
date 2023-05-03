Class {
	#name : #BrLayoutAlignmentAptitude,
	#superclass : #BrStyleAptitude,
	#category : #'Brick-Core-Layout Alignment'
}

{ #category : #geometry }
BrLayoutAlignmentAptitude >> bottomCenter: aBlock [
	aBlock value: (self styleFor: (BrLayoutHorizontalAlignmentState center and: BrLayoutVerticalAlignmentState end))
]

{ #category : #geometry }
BrLayoutAlignmentAptitude >> bottomLeft: aBlock [
	aBlock value: (self styleFor: (BrLayoutHorizontalAlignmentState start and: BrLayoutVerticalAlignmentState end))
]

{ #category : #geometry }
BrLayoutAlignmentAptitude >> bottomRight: aBlock [
	aBlock value: (self styleFor: (BrLayoutHorizontalAlignmentState end and: BrLayoutVerticalAlignmentState end))
]

{ #category : #geometry }
BrLayoutAlignmentAptitude >> center: aBlock [
	aBlock value: (self styleFor: (BrLayoutHorizontalAlignmentState center and: BrLayoutVerticalAlignmentState center))
]

{ #category : #geometry }
BrLayoutAlignmentAptitude >> centerLeft: aBlock [
	aBlock value: (self styleFor: (BrLayoutHorizontalAlignmentState start and: BrLayoutVerticalAlignmentState center))
]

{ #category : #geometry }
BrLayoutAlignmentAptitude >> centerRight: aBlock [
	aBlock value: (self styleFor: (BrLayoutHorizontalAlignmentState end and: BrLayoutVerticalAlignmentState center))
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
	aBlock value: (self styleFor: (BrLayoutHorizontalAlignmentState none and: BrLayoutVerticalAlignmentState none))
]

{ #category : #geometry }
BrLayoutAlignmentAptitude >> topCenter: aBlock [
	aBlock value: (self styleFor: (BrLayoutHorizontalAlignmentState center and: BrLayoutVerticalAlignmentState start))
]

{ #category : #geometry }
BrLayoutAlignmentAptitude >> topLeft: aBlock [
	aBlock value: (self styleFor: (BrLayoutHorizontalAlignmentState start and: BrLayoutVerticalAlignmentState start))
]

{ #category : #geometry }
BrLayoutAlignmentAptitude >> topRight: aBlock [
	aBlock value: (self styleFor: (BrLayoutHorizontalAlignmentState end and: BrLayoutVerticalAlignmentState start))
]
