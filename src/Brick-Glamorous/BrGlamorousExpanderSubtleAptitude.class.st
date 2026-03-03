Class {
	#name : #BrGlamorousExpanderSubtleAptitude,
	#superclass : #BrExpanderAptitude,
	#instVars : [
		'sidebar',
		'toggle',
		'container',
		'borderWidth',
		'expandedBorderWidth',
		'borderPaint',
		'borderFocusedPaint',
		'cornerRadius',
		'padding',
		'toggleLine',
		'sidebarExtraPadding'
	],
	#category : #'Brick-Glamorous-Expander'
}

{ #category : #accessing }
BrGlamorousExpanderSubtleAptitude >> borderFocusedPaint [
	^ borderFocusedPaint
]

{ #category : #accessing }
BrGlamorousExpanderSubtleAptitude >> borderFocusedPaint: aPaintOrColor [
	borderFocusedPaint := aPaintOrColor
]

{ #category : #accessing }
BrGlamorousExpanderSubtleAptitude >> borderPaint [
	^ borderPaint
]

{ #category : #accessing }
BrGlamorousExpanderSubtleAptitude >> borderPaint: aPaintOrColor [
	borderPaint := aPaintOrColor
]

{ #category : #accessing }
BrGlamorousExpanderSubtleAptitude >> borderWidth [
	^ borderWidth
]

{ #category : #accessing }
BrGlamorousExpanderSubtleAptitude >> borderWidth: anInteger [
	borderWidth := anInteger
]

{ #category : #accessing }
BrGlamorousExpanderSubtleAptitude >> cornerRadius [
	^ cornerRadius
]

{ #category : #accessing }
BrGlamorousExpanderSubtleAptitude >> cornerRadius: aNumber [
	cornerRadius := aNumber
]

{ #category : #initialization }
BrGlamorousExpanderSubtleAptitude >> defaultBorderPaint [
	^ self theme default lightBorderColor
]

{ #category : #initialization }
BrGlamorousExpanderSubtleAptitude >> defaultFocusedBorderPaint [
	^ self theme default primaryBorderColor
]

{ #category : #accessing }
BrGlamorousExpanderSubtleAptitude >> expandedBorderWidth [
	<return: #Number>

	^ expandedBorderWidth
]

{ #category : #accessing }
BrGlamorousExpanderSubtleAptitude >> expandedBorderWidth: aNumber [
	expandedBorderWidth := aNumber
]

{ #category : #initialization }
BrGlamorousExpanderSubtleAptitude >> initialize [
	super initialize.

	borderWidth := 0.
	expandedBorderWidth := 0.
	cornerRadius := 3.
	padding := BlInsets all: 4.
	sidebarExtraPadding := BlInsets empty.

	borderPaint := self defaultBorderPaint.
	borderFocusedPaint := self defaultFocusedBorderPaint.

	toggle := self newToggle.
	toggleLine := self newToggleLine.

	sidebar := self newSidebar.
	sidebar padding: self sidebarPadding.
	sidebar addChild: toggle.

	container := BlElement new
		padding: self padding;
		layout: BlLinearLayout vertical.

	self initializeStyling.

	self addChangeAddChildAs: #(sidebar) with: [ sidebar ].
	self addChangeAddChildAs: #(content) with: [ container ].
	self
		addChangeProperty: #(widget layout)
		with: [ BlLinearLayout horizontal ].
	self
		addChangeProperty: #(widget geometry)
		with: [ BlRoundedRectangleGeometry cornerRadius: self cornerRadius ]
]

{ #category : #initialization }
BrGlamorousExpanderSubtleAptitude >> initializeStyling [
	self add: (BrLazyStyleCommonAptitude new
		default: [ :aStyle :aTheme |
			aStyle background: aTheme default contentBackground ];
		collapsed: [ :aStyle |
			aStyle border: (BlBorder paint: self borderPaint width: self borderWidth) ];
		expanded: [ :aStyle |
			aStyle border: (BlBorder paint: self borderPaint width: self expandedBorderWidth) ];
		focused: [ :aStyle |
			aStyle border: (BlBorder paint: self borderFocusedPaint width: self expandedBorderWidth) ]).

	self add: (BrLazyStyleCommonAptitude new
		@ toggle;
		default: [ :aStyle | aStyle background: self borderPaint ];
		focused: [ :aStyle | aStyle background: self borderFocusedPaint ]).
	self add: (BrLazyStyleCommonAptitude new
		@ toggleLine;
		default: [ :aStyle | aStyle background: self borderPaint ];
		focused: [ :aStyle | aStyle background: self borderFocusedPaint ]).
		
	sidebar addAptitude: (BrLazyStyleCommonAptitude new
		@ toggle;
		default: [ :aStyle | aStyle background: self borderPaint ];
		hovered: [ :aStyle | aStyle background: self borderFocusedPaint ]).
	sidebar addAptitude: (BrLazyStyleCommonAptitude new
		@ toggleLine;
		default: [ :aStyle | aStyle background: self borderPaint ];
		hovered: [ :aStyle | aStyle background: self borderFocusedPaint ]).
]

{ #category : #'private - instance creation' }
BrGlamorousExpanderSubtleAptitude >> newCollapsedTriangleGeometry [
	^ BlPolygonGeometry vertices: {
		(0 @ 0).
		(8 @ 4).
		(0 @ 8)
	}
]

{ #category : #'private - instance creation' }
BrGlamorousExpanderSubtleAptitude >> newExpandedTriangleGeometry [
	^ BlPolygonGeometry vertices: {
		(0 @ 0).
		(8 @ 0).
		(4 @ 8)
	}
]

{ #category : #'private - instance creation' }
BrGlamorousExpanderSubtleAptitude >> newSidebar [
	^ BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical matchParent ];
		background: Color transparent;
		when: BlClickEvent
			do: [ :anEvent | 
				anEvent consumed: true.
				self dispatchEvent: BrExpansionToggleWish new ]
]

{ #category : #'private - instance creation' }
BrGlamorousExpanderSubtleAptitude >> newToggle [
	^ BlElement new
		id: #'expander--toggle';
		layout: BlLinearLayout horizontal;
		geometry: self newCollapsedTriangleGeometry;
		constraintsDo: [ :c | 
			c horizontal exact: 8.
			c vertical exact: 7.
			c linear horizontal alignCenter ];
		background: self borderPaint
]

{ #category : #'private - instance creation' }
BrGlamorousExpanderSubtleAptitude >> newToggleLine [
	^ BlElement new
		id: #'expander--toggle-line';
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal exact: 1.
			c vertical matchParent.
			c linear horizontal alignCenter ];
		background: self borderPaint
]

{ #category : #hooks }
BrGlamorousExpanderSubtleAptitude >> onCollapsed [
	super onCollapsed.
	
	toggle geometry: self newCollapsedTriangleGeometry.
	toggleLine removeFromParent
]

{ #category : #hooks }
BrGlamorousExpanderSubtleAptitude >> onExpanded [
	super onExpanded.
	
	toggle geometry: self newExpandedTriangleGeometry.
	sidebar addChild: toggleLine
]

{ #category : #accessing }
BrGlamorousExpanderSubtleAptitude >> padding [
	^ padding
]

{ #category : #accessing }
BrGlamorousExpanderSubtleAptitude >> padding: aBlInsets [
	padding := aBlInsets.
	container padding: aBlInsets.
	sidebar padding: self sidebarPadding.
]

{ #category : #accessing }
BrGlamorousExpanderSubtleAptitude >> resizableElementsDo: aBlock [
	super resizableElementsDo: aBlock.
	aBlock value: container
]

{ #category : #accessing }
BrGlamorousExpanderSubtleAptitude >> sidebarExtraPadding [
	^ sidebarExtraPadding
]

{ #category : #accessing }
BrGlamorousExpanderSubtleAptitude >> sidebarExtraPadding: anInsets [
	sidebarExtraPadding := anInsets.
	
	sidebar padding: self sidebarPadding.
]

{ #category : #initialization }
BrGlamorousExpanderSubtleAptitude >> sidebarPadding [
	^ (BlInsets
		top: self padding top
		left: 2
		bottom: self padding bottom
		right: 2) + self sidebarExtraPadding
]
