Class {
	#name : #BrInlineExpanderElement,
	#superclass : #BlElement,
	#traits : 'TBrExpandable + TBrEnableable + TBrSizeAdjustable',
	#classTraits : 'TBrExpandable classTrait + TBrEnableable classTrait + TBrSizeAdjustable classTrait',
	#category : #'Brick-Triangle - UI'
}

{ #category : #'api - actions' }
BrInlineExpanderElement >> action: aBlock [
	"do no handle expand and collapse actions"
	self viewModel action: aBlock
]

{ #category : #'api - expandable' }
BrInlineExpanderElement >> collapse [
	self states addState: BrCollapsedState uniqueInstance
]

{ #category : #'api - expandable' }
BrInlineExpanderElement >> expand [
	self states addState: BrExpandedState uniqueInstance
]

{ #category : #'api - visibility' }
BrInlineExpanderElement >> hide [
	self visibility: BlVisibility hidden
]

{ #category : #'api - visibility' }
BrInlineExpanderElement >> hide: aBoolean [
	aBoolean 
		ifTrue: [ self hide ] 
		ifFalse: [ self show ]
]

{ #category : #initialization }
BrInlineExpanderElement >> initialize [
	super initialize.
	
	self viewModel: BrButtonModel new.
	self action: [ self toggleExpanded ]
]

{ #category : #'api - expandable' }
BrInlineExpanderElement >> isExpanded [
	"Return true if an widget is expanded (has expanded state), false otherwise"
	<return: #Boolean>

	^ self states hasState: BrExpandedState uniqueInstance
]

{ #category : #'api - visibility' }
BrInlineExpanderElement >> show [
	self visibility: BlVisibility visible
]

{ #category : #'api - actions' }
BrInlineExpanderElement >> toggleAction: aBlock [
	"toggle triangle and then evaluate the block"

	self viewModel action: [ :aWidget :aButtonModel :anEvent |
		self toggleExpanded.
		aBlock gtValueWithArgs: {
			aWidget.
			aButtonModel.
			anEvent
		} ]
]
