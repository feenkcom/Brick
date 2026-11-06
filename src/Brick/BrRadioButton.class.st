"
I am a one-way radio control, sibling of BrToggle under BrAbstractToggle. I reuse BrToggleModel activation, states and events without label or icon models. check/uncheck delegate to activate/deactivate. Use BrRadioButtonGroup or BrToggleGroupModel for mutual exclusion.
"
Class {
	#name : #BrRadioButton,
	#superclass : #BrAbstractToggle,
	#instVars : [
		'group'
	],
	#category : #'Brick-Radio - UI'
}

{ #category : #checking }
BrRadioButton >> check [
	self activate
]

{ #category : #checking }
BrRadioButton >> checked: aBoolean [
	self activated: aBoolean
]

{ #category : #initialization }
BrRadioButton >> initialize [
	super initialize.
	self hLocal.
	self viewModel beOneWay
]

{ #category : #checking }
BrRadioButton >> isChecked [
	^ self isActivated
]

{ #category : #checking }
BrRadioButton >> isUnchecked [
	^ self isActivated not
]

{ #category : #checking }
BrRadioButton >> uncheck [
	self deactivate
]

{ #category : #events }
BrRadioButton >> whenCheckedDo: aBlock [
	self viewModel
		when: BrToggleActivatedEvent
		do: [ :anEvent | aBlock cull: anEvent ]
]

{ #category : #events }
BrRadioButton >> whenUncheckedDo: aBlock [
	self viewModel
		when: BrToggleDeactivatedEvent
		do: [ :anEvent | aBlock cull: anEvent ]
]
