"
I arrange my children in one horizontal row, one by one
"
Class {
	#name : #BrHorizontalPane,
	#superclass : #BrWidgetContainer,
	#traits : 'TBrLayoutAlignable',
	#classTraits : 'TBrLayoutAlignable classTrait',
	#category : #'Brick-Layout Widgets'
}

{ #category : #accessing }
BrHorizontalPane >> cellSpacing: aNumber [
	self layoutDo: [ :l | l cellSpacing: aNumber ]
]

{ #category : #initialization }
BrHorizontalPane >> initialize [
	super initialize.
	
	self layout: BlLinearLayout horizontal.
	self aptitude: BrLayoutAlignmentStatelessAptitude new
]

{ #category : #accessing }
BrHorizontalPane >> weightSum: aNumber [
	self layoutDo: [ :l | l weightSum: aNumber ]
]
