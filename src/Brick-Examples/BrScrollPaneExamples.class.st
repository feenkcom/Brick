Class {
	#name : #BrScrollPaneExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Scrollpane'
}

{ #category : #'instance creation' }
BrScrollPaneExamples >> content [
	<gtExample>
	<return: #BrVerticalPane>
	^ BrVerticalPane new
		vFitContent;
		hMatchParent;
		cellSpacing: 5;
		padding: (BlInsets right: 10);
		addChildren: (20
				timesCollect: [ :i | 
					BlElement new
						background: (BlColorTransition
								interpolate: BrGlamorousColors primaryBorderColor
								to: Color yellow
								at: i / 50.0);
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical exact: 10 + (i * 5) ] ])
]

{ #category : #'examples - scrollbar' }
BrScrollPaneExamples >> dragHorizontalScrollbarThumbRightAndBack [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self horizontalScrollbarThumbHasOnePullHandler.

	aScripter
		substep: 'Drag the thumb to the right'
		do: [ :aStep | 
			aStep mouseMoveOver
				// BlHorizontalScrollbarElement;
				/ #thumb.
			aStep mouseDown.
			aStep mouseMove by: 50 @ 0.
			aStep play ].

	aScripter assertStep: [ :s | 
		s
			label: 'Assert the content is scrolled to the right';
			satisfies: [ :aScrollable | aScrollable computeHorizontalScrollOffset > 0 ];
			// BlScrollableElement ].

	aScripter
		substep: 'Drag the thumb back to the left, past its start position'
		do: [ :aStep | 
			aStep mouseMove by: -100 @ 0.
			aStep mouseUp.
			aStep play ].

	aScripter assertStep: [ :s | 
		s
			label: 'Assert the content is scrolled back to the start';
			value: [ :aScrollable | aScrollable computeHorizontalScrollOffset ] equals: 0;
			// BlScrollableElement ].

	^ aScripter
]

{ #category : #'instance creation' }
BrScrollPaneExamples >> horizontalContent [
	<gtExample>
	<return: #BrHorizontalPane>
	^ BrHorizontalPane new
		hFitContent;
		vMatchParent;
		cellSpacing: 5;
		addChildren: (20
				timesCollect: [ :i | 
					BlElement new
						background: (BlColorTransition
								interpolate: BrGlamorousColors primaryBorderColor
								to: Color yellow
								at: i / 50.0);
						constraintsDo: [ :c | 
							c horizontal exact: 100.
							c vertical matchParent ] ])
]

{ #category : #'examples - scrollbar' }
BrScrollPaneExamples >> horizontalScrollbarThumbAndTrackHaveBackground [
	"The horizontal scrollbar creates its thumb and track after the widget styles are added.
	They must get the default style without being hovered first."
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self horizontalScrollbarThumbHasOnePullHandler.

	aScripter assertStep: [ :s | 
		s
			label: 'Assert the thumb has a background';
			value: [ :aThumb | aThumb background isTransparent ] equals: false;
			// BlHorizontalScrollbarElement;
			/ #thumb ].

	aScripter assertStep: [ :s | 
		s
			label: 'Assert the track has a background';
			value: [ :aTrack | aTrack background isTransparent ] equals: false;
			// BlHorizontalScrollbarElement;
			/ #track ].

	^ aScripter
]

{ #category : #'examples - scrollbar' }
BrScrollPaneExamples >> horizontalScrollbarThumbHasOnePullHandler [
	"The horizontal scrollbar replaces a default vertical one and reuses its thumb.
	Only the horizontal scrollbar may handle pulling the thumb."
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := BlScripter new
			extent: 400 @ 200;
			element: self scrollpaneWithContentAndHorizontalScrollbar.

	aScripter assertStep: [ :s | 
		s
			label: 'Assert the thumb has one pull handler';
			value: [ :aThumb | 
					(aThumb eventDispatcher handlers
						select: [ :each | each isKindOf: BlPullHandler ]) size ]
				equals: 1;
			// BlHorizontalScrollbarElement;
			/ #thumb ].

	^ aScripter
]

{ #category : #'examples - scrollpane' }
BrScrollPaneExamples >> scrollpaneWithContentAndHorizontalScrollbar [
	<gtExample>
	<return: #BrScrollPane>
	^ BrScrollPane new
		aptitude: BrScrollPaneAptitude + BrGlamorousWithHorizontalScrollbarAptitude;
		content: self horizontalContent
]

{ #category : #'examples - scrollpane' }
BrScrollPaneExamples >> scrollpaneWithContentAndScrollbar [
	<gtExample>
	<return: #BrScrollPane>
	^ BrScrollPane new
		aptitude: BrScrollPaneAptitude + BrGlamorousWithVerticalScrollbarAptitude;
		content: self content
]

{ #category : #'examples - scrollpane' }
BrScrollPaneExamples >> scrollpaneWithContentWithoutScrollbar [
	<gtExample>
	<return: #BrScrollPane>
	^ BrScrollPane new
		aptitude: BrScrollPaneAptitude;
		content: self content
]

{ #category : #'examples - scrollbar' }
BrScrollPaneExamples >> verticalScrollbarThumbAndTrackHaveBackground [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := BlScripter new
			extent: 400 @ 200;
			element: self scrollpaneWithContentAndScrollbar.

	aScripter assertStep: [ :s | 
		s
			label: 'Assert the thumb has a background';
			value: [ :aThumb | aThumb background isTransparent ] equals: false;
			// BlVerticalScrollbarElement;
			/ #thumb ].

	aScripter assertStep: [ :s | 
		s
			label: 'Assert the track has a background';
			value: [ :aTrack | aTrack background isTransparent ] equals: false;
			// BlVerticalScrollbarElement;
			/ #track ].

	^ aScripter
]
