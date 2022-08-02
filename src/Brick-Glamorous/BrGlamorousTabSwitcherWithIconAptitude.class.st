"
I am a tab switcher look with a label.
I expect to be attached to {{gtClass:BrTab}}.
See examples at {{gtClass:BrGlamorousTabGroupSwitcherLook}} and {{gtClass:BrGlamorousTabGroupSwitcherWithHiddenSelectedTabLook}}.


"
Class {
	#name : #BrGlamorousTabSwitcherWithIconAptitude,
	#superclass : #BrGlamorousTabSwitcherAptitude,
	#category : #'Brick-Glamorous-Tabs - Switcher'
}

{ #category : #initialization }
BrGlamorousTabSwitcherWithIconAptitude >> initialize [
	super initialize.

	self add: (BrGlamorousButtonIconAptitude new).
	
	self addChangeProperty: #(widget geometry) with: [ BlCircleGeometry new ].
]
