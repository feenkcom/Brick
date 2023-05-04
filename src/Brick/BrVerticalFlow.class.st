"
I arrange my children vertically in a flow layout
"
Class {
	#name : #BrVerticalFlow,
	#superclass : #BrWidgetContainer,
	#traits : 'TBrLayoutAlignable',
	#classTraits : 'TBrLayoutAlignable classTrait',
	#category : #'Brick-Layout Widgets'
}

{ #category : #initialization }
BrVerticalFlow >> initialize [
	super initialize.

	self aptitude: BrVerticalFlowAptitude new
]
