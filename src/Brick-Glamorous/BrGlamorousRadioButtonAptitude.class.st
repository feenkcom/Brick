"
I draw a circular radio button and selected dot from BrToggleState using BrToggleAptitude.
"
Class {
	#name : #BrGlamorousRadioButtonAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'iconLook'
	],
	#category : #'Brick-Glamorous-Radio'
}

{ #category : #initialization }
BrGlamorousRadioButtonAptitude >> initialize [
	super initialize.
	self add: BrLayoutAlignmentAptitude new.
	self addChangeProperty: #(widget layout) with: [ BlLinearLayout horizontal ].
	self
		add: (iconLook := BrIconAptitude new
					icon: (BlElement new
							size: 8 @ 8;
							geometry: BlEllipseGeometry new)).
	self
		add: (BrToggleAptitude new
				default: [ :aStyle | 
					aStyle
						geometry: BlEllipseGeometry new;
						background: Color white;
						border: (BlBorder paint: self theme button defaultBorderColor width: 1) ];
				hovered: [ :aStyle | aStyle border: (BlBorder paint: self theme default darkBorderColor width: 1) ];
				activated: [ :aStyle | aStyle border: (BlBorder paint: self theme default darkBorderColor width: 1) ]).
	self
		add: (BrToggleAptitude new
				@ [ iconLook icon ];
				activated: [ :aStyle | aStyle background: self theme default darkBorderColor muchDarker ];
				deactivated: [ :aStyle | aStyle background: Color transparent ]).
	self
		add: (BrSizeAdjustmentAptitude new
				normal: [ :aStyle | 
					aStyle
						vExact: 16;
						hExact: 16 ];
				small: [ :aStyle | 
					aStyle
						vExact: 14;
						hExact: 14 ])
]
