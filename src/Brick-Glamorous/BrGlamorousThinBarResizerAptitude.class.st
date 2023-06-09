Class {
	#name : #BrGlamorousThinBarResizerAptitude,
	#superclass : #BrResizerAptitude,
	#instVars : [
		'thickness',
		'borderSeparation'
	],
	#category : #'Brick-Glamorous-Resizer'
}

{ #category : #accessing }
BrGlamorousThinBarResizerAptitude >> borderSeparation [
	^ borderSeparation
]

{ #category : #accessing }
BrGlamorousThinBarResizerAptitude >> borderSeparation: aNumber [
	borderSeparation := aNumber
]

{ #category : #initialization }
BrGlamorousThinBarResizerAptitude >> initialize [
	| aHandle |
	super initialize.

	thickness := 1.
	borderSeparation := 2.
	
	aHandle := BlElement new.

	self
		addChangeProperty: #(widget layout)
		with: [ BlLinearLayout horizontal alignCenter ].

	self
		addChangeAddChildAs: #(handle)
		with: [ aHandle ].
	
	self
		vertical: [ :aStyle | 
			aStyle
				hMatchParent;
				vFitContent ];
		horizontal: [ :aStyle | 
			aStyle
				hFitContent;
				vMatchParent ];
		top: [ :aStyle |
			aStyle constraintsDo: [ :c | c ignored vertical alignTop ] ];
		bottom: [ :aStyle | 
			aStyle constraintsDo: [ :c | c ignored vertical alignBottom ] ];
		left: [ :aStyle | 
			aStyle constraintsDo: [ :c | c ignored horizontal alignLeft ] ];
		right: [ :aStyle | 
			aStyle constraintsDo: [ :c | c ignored horizontal alignRight ] ].
	
	self add: (BrLazyStyleCommonAptitude new
		@ aHandle;
		default: [ :aStyle | aStyle background: self theme button defaultBorderColor ];
		hovered: [ :aStyle | aStyle background: self theme button hoveredBorderColor ];
		pressed: [ :aStyle | aStyle background: self theme button pressedBorderColor ]).
		
	self add: (BrResizerAptitude new
		@ aHandle;
		vertical: [ :aStyle | 
			aStyle
				hMatchParent;
				vExact: thickness;
				margin: (BlInsets top: borderSeparation bottom: borderSeparation) ];
		horizontal: [ :aStyle | 
			aStyle
				hExact: thickness;
				vMatchParent;
				margin: (BlInsets left: borderSeparation right: borderSeparation) ])
]

{ #category : #accessing }
BrGlamorousThinBarResizerAptitude >> thickness [
	^ thickness
]

{ #category : #accessing }
BrGlamorousThinBarResizerAptitude >> thickness: aNumber [
	thickness := aNumber
]
