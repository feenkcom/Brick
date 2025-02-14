Class {
	#name : #BrLabelExpanderAptitude,
	#superclass : #BrTriangleExpanderAptitude,
	#instVars : [
		'text'
	],
	#category : #'Brick-Triangle - Look'
}

{ #category : #'as yet unclassified' }
BrLabelExpanderAptitude >> defaultCollapsedStencil [
	^ [ BrHorizontalPane new
		alignCenter;
		fitContent;
		padding: BlInsets empty;
		addChild: self dotElement;
		addChild: (BrLabel new
				aptitude: (BrLabelAptitude new
						glamorousCodeTinySize;
						foreground: Color gray);
				text: text;
				yourself);
		addChild: self dotElement;
		yourself ] asStencil
]

{ #category : #defaults }
BrLabelExpanderAptitude >> defaultExpandedStencil [
	^ [BlElement new
		size: 11 @ 11;
		padding: BlInsets empty;
		addChild: (self dotElement relocate: 4 @ 0);
		addChild: (self dotElement relocate: 4 @ 4);
		addChild: (self dotElement relocate: 4 @ 8);
		yourself] asStencil
]

{ #category : #'as yet unclassified' }
BrLabelExpanderAptitude >> dotElement [
	| dot |
	dot := BlElement new.
	dot geometry: BlCircleGeometry new.
	dot background: Color gray.
	dot size: 3 @ 3.
			 dot constraintsDo: [:c | c linear vertical alignCenter].
	^ dot
]

{ #category : #initialization }
BrLabelExpanderAptitude >> initialize [
	super initialize.
	self
		addChangeProperty: #(widget layout) with: [ BlFrameLayout new ];
		addChangeProperty: #(widget geometry)
			with: [ BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii radius: 5) ];
		addChangeProperty: #(widget constraints vertical resizer)
			with: [ BlLayoutResizer fitContent ];
		addChangeProperty: #(widget constraints horizontal resizer)
			with: [ BlLayoutResizer fitContent ].
	self
		add: (BrLazyStyleCommonAptitude new
				default: [ :aStyle | 
					aStyle
						"border: (BlBorder paint: Color gray width: 1);"
						background: self theme item deselectedColor ];
				hovered: [ :aStyle | 
					aStyle
						"border: (BlBorder paint: Color gray width: 1);"
						background: self theme item hoveredColor ];
				pressed: [ :aStyle | 
					aStyle
						"border: (BlBorder paint: Color gray width: 1);"
						background: self theme item pressedColor ]).
	self
		add: (BrSizeAdjustmentAptitude new
				huge: [ :aStyle | 
					aStyle
						padding: (BlInsets all: 2);
						scaleBy: 1.5 ];
				large: [ :aStyle | 
					aStyle
						padding: (BlInsets all: 2);
						scaleBy: 1.25 ];
				normal: [ :aStyle | 
					aStyle
						padding: (BlInsets all: 2);
						scaleBy: 1 ];
				small: [ :aStyle | 
					aStyle
						padding: (BlInsets all: 1);
						scaleBy: 0.91 ];
				tiny: [ :aStyle | 
					aStyle
						padding: (BlInsets all: 1);
						scaleBy: 0.83 ];
				mini: [ :aStyle | 
					aStyle
						padding: (BlInsets all: 1);
						scaleBy: 0.75 ])
]

{ #category : #initialization }
BrLabelExpanderAptitude >> initializeTriangle: aTriangle [
	"configure collapsed and expanded triangle elements"

	aTriangle
		constraintsDo: [ :c | 
			c frame horizontal alignCenter.
			c frame vertical alignCenter ]
]

{ #category : #'as yet unclassified' }
BrLabelExpanderAptitude >> text: aString [
	text := aString
]
