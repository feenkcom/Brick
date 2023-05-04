Class {
	#name : #BrLayoutAlignmentStyles,
	#superclass : #BlStatelessStyles,
	#category : #'Brick-Core-Layout Alignment'
}

{ #category : #'api - styles' }
BrLayoutAlignmentStyles >> bottomCenter: aBlock [
	self
		when: (BrLayoutHorizontalAlignmentState center and: BrLayoutVerticalAlignmentState end)
		style: aBlock
]

{ #category : #'api - styles' }
BrLayoutAlignmentStyles >> bottomLeft: aBlock [
	self
		when: (BrLayoutHorizontalAlignmentState start and: BrLayoutVerticalAlignmentState end)
		style: aBlock
]

{ #category : #'api - styles' }
BrLayoutAlignmentStyles >> bottomRight: aBlock [
	self
		when: (BrLayoutHorizontalAlignmentState end and: BrLayoutVerticalAlignmentState end)
		style: aBlock
]

{ #category : #'api - styles' }
BrLayoutAlignmentStyles >> center: aBlock [	
	self
		when: (BrLayoutHorizontalAlignmentState center and: BrLayoutVerticalAlignmentState center)
		style: aBlock
]

{ #category : #'api - styles' }
BrLayoutAlignmentStyles >> centerLeft: aBlock [
	self
		when: (BrLayoutHorizontalAlignmentState start and: BrLayoutVerticalAlignmentState center)
		style: aBlock
]

{ #category : #'api - styles' }
BrLayoutAlignmentStyles >> centerRight: aBlock [
	self
		when: (BrLayoutHorizontalAlignmentState end and: BrLayoutVerticalAlignmentState center)
		style: aBlock
]

{ #category : #'api - styles' }
BrLayoutAlignmentStyles >> none: aBlock [
	self
		when: (BrLayoutHorizontalAlignmentState none and: BrLayoutVerticalAlignmentState none)
		style: aBlock
]

{ #category : #'api - styles' }
BrLayoutAlignmentStyles >> topCenter: aBlock [
	self
		when: (BrLayoutHorizontalAlignmentState center and: BrLayoutVerticalAlignmentState start)
		style: aBlock
]

{ #category : #'api - styles' }
BrLayoutAlignmentStyles >> topLeft: aBlock [
	self
		when: (BrLayoutHorizontalAlignmentState start and: BrLayoutVerticalAlignmentState start)
		style: aBlock
]

{ #category : #'api - styles' }
BrLayoutAlignmentStyles >> topRight: aBlock [
	self
		when: (BrLayoutHorizontalAlignmentState end and: BrLayoutVerticalAlignmentState start)
		style: aBlock
]
