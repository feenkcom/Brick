"
I am a tab switcher look that position tabs at top-center part of container.
I expect to be attached to a {{gtClass:BrTabGroup}} instance.
#Examples 
##With Labels
{{gtExample:BrExamplesShowroom>>#glamorousTabsSwitcherWithLabels|codeExpanded=false|previewExpanded=true}}

##With Icons
{{gtExample:BrExamplesShowroom>>#glamorousTabsSwitcherWithIcons|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : #BrGlamorousTabGroupSwitcherAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'headerLook'
	],
	#category : #'Brick-Glamorous-Tabs - Switcher'
}

{ #category : #'api - style' }
BrGlamorousTabGroupSwitcherAptitude >> headerBackground: aBackground [
	headerLook headerDo: [ :aHeaderElement | aHeaderElement background: aBackground ]
]

{ #category : #initialization }
BrGlamorousTabGroupSwitcherAptitude >> initialize [
	super initialize.

	self addAll: {
		BrTabGroupContentAptitude new.
		headerLook := self newHeaderLook }.
	
	headerLook headerDo: [ :aHeader | 
		aHeader 
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c ignored horizontal alignCenter.
				c ignored vertical alignCenterAt: 0 ] ].
	
	self addChangeProperty: #(widget clipChildren) with: [ false ].
	self addChangeProperty: #(widget layout) with: [ BlLinearLayout vertical ].
]

{ #category : #'instance creation' }
BrGlamorousTabGroupSwitcherAptitude >> newHeaderLook [
	^ BrGlamorousTabGroupSwitcherHeaderAptitude new
]
