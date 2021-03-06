"
I am a tab switcher look that position tabs header at top-center part of container.
I am used by ${class:BrGlamorousTabGroupSwitcherLook}$ where you can find examples.

"
Class {
	#name : #BrGlamorousTabGroupSwitcherHeaderLook,
	#superclass : #BrTabGroupHeaderLook,
	#category : #'Brick-Glamorous-Tabs - Switcher'
}

{ #category : #initialization }
BrGlamorousTabGroupSwitcherHeaderLook >> initialize [
	super initialize.
	
	"Header should always fit content vertically, while horizontal resizing depends on a resizing strategy of the tab group
	We have the following structure:
	
	- header
		- scrollable
			- tabbar
	"
	
	self header addLook: BrGlamorousFocusableShadowLook.

	self addChangeProperty: #(header geometry) with: [ BlStadium new ].
	self addChangeProperty: #(header background) with: [ Color white ]. 
	self addChangeProperty: #(header layout) with: [ BlLinearLayout horizontal alignCenter ].
	
	self addChangeProperty: #(tabbar layout) with: [ 
		BlLinearLayout horizontal alignCenter cellSpacing: 0 ].

	self add: (BrLayoutResizerLook new
		anyToFitContent: self header).

	self header addLook: (BrLayoutResizerLook new
		anyToFitContent: self scrollTabbar).

	self scrollTabbar addLook: (BrLayoutResizerLook new
		anyToFitContent: self tabbar)
]
