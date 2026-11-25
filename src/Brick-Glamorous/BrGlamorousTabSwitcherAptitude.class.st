"
I am an abstract class.
I am a tab switcher look.
My subclasses expect to be attached to {{gtClass:BrTab}} instances.


"
Class {
	#name : #BrGlamorousTabSwitcherAptitude,
	#superclass : #BrTabAptitude,
	#category : #'Brick-Glamorous-Tabs - Switcher'
}

{ #category : #initialization }
BrGlamorousTabSwitcherAptitude >> createCommonStyleAptitude [
	^ BrLazyStyleCommonAptitude new
		default: [ :aStyle :aTheme | aStyle background: aTheme item deselectedColor ];
		hovered: [ :aStyle :aTheme | aStyle background: aTheme item hoveredColor ];
		pressed: [ :aStyle :aTheme | aStyle background: aTheme item pressedColor ];
		selected: [ :aStyle :aTheme | aStyle background: aTheme item selectedColor ];
		yourself
]

{ #category : #initialization }
BrGlamorousTabSwitcherAptitude >> initialize [
	super initialize.

	self add: BrLayoutAlignmentAptitude new.
	self
		addChangeProperty: #(widget layout)
		with: [ BlLinearLayout horizontal ].

	self addChangeProperty: #(widget padding) with: [ BlInsets top: 2 left: 2 bottom: 2 right: 2 ].

	self add: self createCommonStyleAptitude.
]
