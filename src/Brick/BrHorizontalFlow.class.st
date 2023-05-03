"
I arrange my children horizontally in a flow layout
"
Class {
	#name : #BrHorizontalFlow,
	#superclass : #BrWidgetContainer,
	#traits : 'TBrLayoutAlignable',
	#classTraits : 'TBrLayoutAlignable classTrait',
	#category : #'Brick-Layout Widgets'
}

{ #category : #initialization }
BrHorizontalFlow >> initialize [
	super initialize.

	self aptitude: BrHorizontalFlowAptitude new
]
