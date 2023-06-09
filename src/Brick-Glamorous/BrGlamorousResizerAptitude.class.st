Class {
	#name : #BrGlamorousResizerAptitude,
	#superclass : #BrResizerAptitude,
	#instVars : [
		'thickness',
		'borderSeparation',
		'weight'
	],
	#category : #'Brick-Glamorous-Resizer'
}

{ #category : #accessing }
BrGlamorousResizerAptitude >> borderSeparation [
	^ borderSeparation
]

{ #category : #accessing }
BrGlamorousResizerAptitude >> borderSeparation: aNumber [
	borderSeparation := aNumber
]

{ #category : #initialization }
BrGlamorousResizerAptitude >> initialize [
	super initialize.

	thickness := 3.
	borderSeparation := 0.
	weight := 0.4.
	
	self
		addChangeProperty: #(widget geometry)
		with: [ BlRoundedRectangleGeometry cornerRadius: 2 ].
	
	self
		default: [ :aStyle | aStyle background: self theme button defaultBorderColor ];
		hovered: [ :aStyle | aStyle background: self theme button hoveredBorderColor ];
		pressed: [ :aStyle | aStyle background: self theme button pressedBorderColor ].
	
	self
		vertical: [ :aStyle | 
			aStyle
				vExact: thickness;
				hMatchParent;
				constraintsDo: [ :c | 
					c ignored horizontal alignCenter.
					c ignored horizontal weight: weight ] ];
		top: [ :aStyle |
			aStyle
				margin: (BlInsets top: borderSeparation);
				constraintsDo: [ :c | 
					c ignored vertical alignTop ] ];
		bottom: [ :aStyle | 
			aStyle margin: (BlInsets bottom: borderSeparation).
			aStyle constraintsDo: [ :c | 
				c ignored vertical alignBottom. ] ];
		horizontal: [ :aStyle | 
			aStyle
				hExact: thickness;
				vMatchParent;
				constraintsDo: [ :c | 
					c ignored vertical alignCenter.
					c ignored vertical weight: weight ] ];
		left: [ :aStyle | 
			aStyle margin: (BlInsets left: borderSeparation).
			aStyle constraintsDo: [ :c | 
				c ignored horizontal alignLeft ] ];
		right: [ :aStyle | 
			aStyle margin: (BlInsets right: borderSeparation).
			aStyle constraintsDo: [ :c | 
				c ignored horizontal alignRight ] ].
]

{ #category : #accessing }
BrGlamorousResizerAptitude >> thickness [
	^ thickness
]

{ #category : #accessing }
BrGlamorousResizerAptitude >> thickness: aNumber [
	thickness := aNumber
]

{ #category : #accessing }
BrGlamorousResizerAptitude >> weight [
	^ weight
]

{ #category : #accessing }
BrGlamorousResizerAptitude >> weight: aNumber [
	weight := aNumber
]
