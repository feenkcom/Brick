Class {
	#name : #BrGlamorousHandleBarResizerAptitude,
	#superclass : #BrResizerAptitude,
	#instVars : [
		'thickness'
	],
	#category : #'Brick-Glamorous-Resizer'
}

{ #category : #initialization }
BrGlamorousHandleBarResizerAptitude >> initialize [
	| aHandle |
	super initialize.

	aHandle := BlElement new
		outskirts: BlOutskirts centered.

	self
		addChangeProperty: #(widget geometry)
		with: [ BlRoundedRectangleGeometry cornerRadius: 2 ].
		
	self
		addChangeProperty: #(widget background)
		with: [ Color white ].

	self
		addChangeAddChildAs: #(handle)
		with: [ aHandle ].
	
	self
		vertical: [ :aStyle | 
			aStyle
				hExact: 50;
				vExact: 10;
				constraintsDo: [ :c | c ignored horizontal alignCenter ] ];
		horizontal: [ :aStyle | 
			aStyle
				hExact: 10;
				vExact: 50;
				constraintsDo: [ :c | c ignored vertical alignCenter ] ];
		top: [ :aStyle |
			aStyle constraintsDo: [ :c | c ignored vertical alignCenterAt: 0.0 ] ];
		bottom: [ :aStyle | 
			aStyle constraintsDo: [ :c | c ignored vertical alignCenterAt: 1.0 ] ];
		left: [ :aStyle | 
			aStyle constraintsDo: [ :c | c ignored horizontal alignCenterAt: 0.0 ] ];
		right: [ :aStyle | 
			aStyle constraintsDo: [ :c | c ignored horizontal alignCenterAt: 1.0 ] ].
	
	self
		default: [ :aStyle | aStyle border: (BlBorder paint: self theme button defaultBorderColor width: 1) ];
		hovered: [ :aStyle | aStyle border: (BlBorder paint: self theme button hoveredBorderColor width: 1) ];
		pressed: [ :aStyle | aStyle border: (BlBorder paint: self theme button pressedBorderColor width: 1) ].
	
	self add: (BrLazyStyleCommonAptitude new
		@ aHandle;
		default: [ :aStyle | aStyle border: (BlBorder paint: self theme button defaultBorderColor width: 1) ];
		hovered: [ :aStyle | aStyle border: (BlBorder paint: self theme button hoveredBorderColor width: 1) ];
		pressed: [ :aStyle | aStyle border: (BlBorder paint: self theme button pressedBorderColor width: 1) ]).

	self add: (BrResizerAptitude new
		@ aHandle;
		vertical: [ :aStyle |
			aStyle
				geometry: (BlNormalizedMultiPolylineGeometry polylines: {
					{ 0.2 @ 0.35 . 0.8 @ 0.35 }.
					{ 0.2 @ 0.65 . 0.8 @ 0.65 } });
				hMatchParent;
				vMatchParent ];
		horizontal: [ :aStyle |
			aStyle
				geometry: (BlNormalizedMultiPolylineGeometry polylines: {
					{ 0.35 @ 0.2 . 0.35 @ 0.8 }.
					{ 0.65 @ 0.2 . 0.65 @ 0.8 } });
				hMatchParent;
				vMatchParent ])
]
