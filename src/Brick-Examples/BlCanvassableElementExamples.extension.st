Extension { #name : #BlCanvassableElementExamples }

{ #category : #'*Brick-Examples' }
BlCanvassableElementExamples >> graphEditorDemo [
	"This demo illustrates how one might build a view for an interactive graph editor
	using a BlCanvassableElement.
	
	Note that this is only a view without an underlying model.
		
	- double click to create a node
	- click and drag to move it
	- double click node to inspect
	- drag the background to pan
	- control-click node or background to open a context menu
	
	NB: This demo replaces BlPannableElementExamples>>#pannablePinchableGraphEditorDemo."

	<gtExample>
	| padding margin graphCanvas |
	padding := 2.
	margin := padding.

	graphCanvas := BlCanvassableElement new
			constraintsDo: [ :c | 
				c vertical matchParent.
				c horizontal matchParent ];
			padding: (BlInsets all: padding);
			margin: (BlInsets all: margin);
			background: Color white;
			border: (BlBorder paint: Color red);
			when: BlDoubleClickEvent
				do: [ :evt | 
					| newNode |
					newNode := self pullableNodeStencil asElement.
					newNode relocate: evt childrenPosition.
					graphCanvas addChild: newNode. ];
			aptitude: (BrGlamorousWithExplicitContextMenuAptitude
					items: { 'Inspect graph' -> [ graphCanvas inspect ] });
			yourself.
	^ graphCanvas
]

{ #category : #'*Brick-Examples' }
BlCanvassableElementExamples >> pullableNodeStencil [
	"Node for graphEditorDemo"
	<gtExample>
	^ [ | node |
	node := BlElement new.
	node
		layout: BlFrameLayout new;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
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
						items: { 'Inspect node' -> [ node inspect ] }).
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
BlCanvassableElementExamples >> roundedNode [
	<gtExample>
	| node |
	node := BlElement new
			geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
			background: Color white;
			size: 25 @ 25;
			border: (BlBorder paint: Color black width: 2);
			aptitude: (BrStyleCommonAptitude new
					default: [ :aStyle | aStyle border: (BlBorder paint: Color black width: 1) ];
					hovered: [ :aStyle | aStyle border: (BlBorder paint: Color red width: 1) ]);
			addEventHandler: BlPullHandler new;
			yourself.
	^ node
]
