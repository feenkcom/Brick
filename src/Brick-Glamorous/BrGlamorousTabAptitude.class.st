Class {
	#name : #BrGlamorousTabAptitude,
	#superclass : #BrTabAptitude,
	#instVars : [
		'bar'
	],
	#category : #'Brick-Glamorous-Tabs'
}

{ #category : #initialization }
BrGlamorousTabAptitude >> initialize [
	super initialize.
	self add: BrGlamorousLabelAptitude.
	self add: BrGlamorousTabActionbarAptitude new.
		
	bar := BlElement new
		visibility: BlVisibility hidden;
		background: self theme default primaryBorderColor;
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored vertical alignBottom.
			c vertical exact: 2.
			c horizontal matchParent ].
	self
		add:
			(BrStyleCommonAptitude new
				default: [ :aStyle | 
					aStyle
						padding:
							(BlInsets
								top: 10
								left: 12
								bottom: 10
								right: 12) ]).
	self
		add:
			(BrStyleCommonAptitude new
				@ bar;
				deselected: [ :aStyle | aStyle hidden ];
				selected: [ :aStyle | aStyle visible ]).
	self addChangeAddChildAs: #(content bar) with: [ bar ]
]
