Extension { #name : #BlPannableElementExamples }

{ #category : #'*Brick-Examples' }
BlPannableElementExamples >> clickableNodeStencil [
	"For the pannablePinchableGraphEditorDemo"
	<gtExample>
	<noTest>
	^ [ | node |
	node := BlElement new.
	node
		layout: BlFrameLayout new;
		geometry: (BlRectangle cornerRadius: 4);
		background: Color white;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		padding: (BlInsets all: 10).
	node graph beNode.
	node
		aptitude: (BrStyleCommonAptitude new
				default: [ :aStyle | aStyle border: (BlBorder paint: Color black width: 1) ];
				hovered: [ :aStyle | aStyle border: (BlBorder paint: Color red width: 1) ])
				+ (BrGlamorousWithExplicitContextMenuAptitude
						items: {'Inspect node' -> [ node inspect ]}).
	node addEventHandler: BlPullHandler new.
	node
		addEventHandler: (BlEventHandler
				on: BlDoubleClickEvent
				do: [ :evt | 
					evt consumed: true.
					node phlow spawnObject: node ]).
	node ] asStencil
]

{ #category : #'*Brick-Examples' }
BlPannableElementExamples >> pannablePinchableDemo [
	"Example by Aliaksei Syrel. Shows how bounds of parent element can automatically adjust to its children. Double-click on background to add children."

	<gtExample>
	<noTest>
	| makeNode graph graphHolder pannable |
	makeNode := self pullableNodeStencil.	"The graph element holds the actual graph nodes and edges"
	graph := BlElement new
			layout: (BlWrapAroundChildrenLayout new addLayout: BlBasicNodeBasedLayout new);
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ];
			background: Color white;
			effect: BrGlamorousShadowEffect new.
	graphHolder := BlPinchableElement new
			zoomLevel: 2;
			clipChildren: false;
			contentElement: graph;
			border: (BlBorder paint: Color black).
	pannable := graphHolder asPannableElement
			background: Color veryLightGray;
			when: BlDoubleClickEvent
				do: [ :evt | 
					| newNode |
					newNode := self pullableNodeStencil asElement.
					graph addChild: newNode.
					newNode relocate: (graphHolder globalPointToLocal: evt position) ].
	^ pannable
]

{ #category : #'*Brick-Examples' }
BlPannableElementExamples >> pannablePinchableGraphEditorDemo [
	"graph editor demo example using a composition of elements.
	NB: It is now possible to create a similar demo directly using a BlCanvassableElement. See BlCanvassableElementExamples>>#graphEditorDemo

	This demo only builds a view without an underlying model, just to show in a script how to compose the key UI elements. Each element has a border or shading to make its bounds visible.
	
	- double click to create a node
	- click and drag to move it
	- double click node to inspect
	- drag the background to pan
	- control-click node or background to open a context menu
	- zoom buttons only work partially

	The graphEditor (blue border) is the root element. It holds a buttonBar and a graphContainer (orange borders). The graphContainer contains the (pinchable) graphHolder (light gray border), which holds the graph (white with shading).
	The graph element (white with shading) holds the actual graph nodes. It adapts its size to its children with a BlWrapAroundChildrenLayout layout.
	The graphHolder (gray border) is a pinchable container for the graph. See BlPinchableElement. Note that the graph it contains may overlap its own border, so we don't care about the gray border when zooming or resizing.
	The graphContainer (orange border) supports panning and handles the background events for the graph (context menu and node creation).
	"

	<gtExample>
	<noTest>
	| padding margin graphEditor graph buttonBar graphHolder graphContainer |
	padding := 2.
	margin := padding.


	graph := BlElement new
			layout: (BlWrapAroundChildrenLayout new addLayout: BlBasicNodeBasedLayout new);
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ];
			padding: (BlInsets all: padding);
			margin: (BlInsets all: margin);
			background: Color white;
			effect: BrGlamorousShadowEffect new;
			yourself.

	graphHolder := BlPinchableElement new
			zoomLevel: 2;
			clipChildren: false;
			contentElement: graph;
			border: (BlBorder paint: Color lightGray);
			yourself.

	graphContainer := graphHolder asPannableElement
			border: (BlBorder paint: Color orange);
			padding: (BlInsets all: padding);
			margin: (BlInsets all: margin);
			when: BlDoubleClickEvent
				do: [ :evt | 
					| newNode |
					newNode := self clickableNodeStencil asElement.
					graph addChild: newNode.
					newNode relocate: (graphHolder globalPointToLocal: evt position) ];
			aptitude: (BrGlamorousWithExplicitContextMenuAptitude
					items: {'Inspect graph' -> [ graph inspect ]});
			yourself.

	buttonBar := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical fitContent ];
			padding: (BlInsets all: padding);
			margin: (BlInsets all: margin);
			layout: BlLinearLayout horizontal;
			border: (BlBorder paint: Color orange width: 1);
			addChild: (BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousVectorIcons zoomin;
					label: 'Zoom In';
					action: [ graphContainer zoomIn ]);
			addChild: (BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousVectorIcons zoomout;
					label: 'Zoom Out';
					action: [ graphContainer zoomOut ]);
			addChild: (BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousVectorIcons zoomtofit;
					label: 'Fit';
					action: [ graphContainer zoomToFit ]);
			addChild: (BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousVectorIcons actualsize;
					label: 'Resize';
					action: [ graphContainer zoomToActualSize ]).

	graphEditor := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			padding: (BlInsets all: padding);
			margin: (BlInsets all: margin);
			layout: BlLinearLayout vertical;
			border: (BlBorder paint: Color blue width: 1);
			addChild: buttonBar;
			addChild: graphContainer;
			yourself.

	^ graphEditor
]
