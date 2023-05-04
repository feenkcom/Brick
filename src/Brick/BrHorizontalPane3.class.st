Class {
	#name : #BrHorizontalPane3,
	#superclass : #BrWidgetContainer,
	#traits : 'TBrLayoutAlignable',
	#classTraits : 'TBrLayoutAlignable classTrait',
	#category : #'Brick-Layout Widgets'
}

{ #category : #accessing }
BrHorizontalPane3 >> cellSpacing: aNumber [
	self layoutDo: [ :l | l cellSpacing: aNumber ]
]

{ #category : #initialization }
BrHorizontalPane3 >> initialize [
	super initialize.
	
	self layout: BlLinearLayout horizontal.
	self aptitude: BrLayoutAlignmentAptitude3 new
]

{ #category : #accessing }
BrHorizontalPane3 >> weightSum: aNumber [
	self layoutDo: [ :l | l weightSum: aNumber ]
]
