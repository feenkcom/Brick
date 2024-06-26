"
I am a tab switcher look with an icon.
I expect to be attached to {{gtClass:BrTab}}.
See examples at {{gtClass:BrGlamorousTabGroupSwitcherAptitude}} and {{gtClass:BrGlamorousTabGroupSwitcherWithHiddenSelectedTabAptitude}}.


"
Class {
	#name : #BrGlamorousTabSwitcherWithLabelAptitude,
	#superclass : #BrGlamorousTabSwitcherAptitude,
	#category : #'Brick-Glamorous-Tabs - Switcher'
}

{ #category : #initialization }
BrGlamorousTabSwitcherWithLabelAptitude >> initialize [
	super initialize.

	self add: (BrGlamorousTextLabelAptitude new 
		foreground: Color black).	
		
	self addChangeProperty: #(widget geometry) with: [ 
		BlStadiumGeometry new ].
]
