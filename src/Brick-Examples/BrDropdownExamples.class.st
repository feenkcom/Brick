Class {
	#name : #BrDropdownExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Dropdown'
}

{ #category : #examples }
BrDropdownExamples >> alignedDropdowns [
	<gtExample>
	<return: #BlElement>
	| container topLeft topCenter topRight centerLeft centerCenter centerRight bottomLeft bottomCenter bottomRight |
	container := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			padding: (BlInsets all: 10);
			layout: BlFrameLayout new.
	topLeft := self coloredDropdown
			constraintsDo: [ :c | 
				c frame horizontal alignLeft.
				c frame vertical alignTop ];
			yourself.
	topCenter := self coloredDropdown
			constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignTop ];
			yourself.
	topRight := self coloredDropdown
			constraintsDo: [ :c | 
				c frame horizontal alignRight.
				c frame vertical alignTop ];
			yourself.
	centerLeft := self coloredDropdown
			constraintsDo: [ :c | 
				c frame horizontal alignLeft.
				c frame vertical alignCenter ];
			yourself.
	centerCenter := self coloredDropdown
			constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignCenter ];
			yourself.
	centerRight := self coloredDropdown
			constraintsDo: [ :c | 
				c frame horizontal alignRight.
				c frame vertical alignCenter ];
			yourself.
	bottomLeft := self coloredDropdown
			constraintsDo: [ :c | 
				c frame horizontal alignLeft.
				c frame vertical alignBottom ];
			yourself.
	bottomCenter := self coloredDropdown
			constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignBottom ];
			yourself.
	bottomRight := self coloredDropdown
			constraintsDo: [ :c | 
				c frame horizontal alignRight.
				c frame vertical alignBottom ];
			yourself.
	container
		addChildren: {topLeft.
				topCenter.
				topRight.
				centerLeft.
				centerCenter.
				centerRight.
				bottomLeft.
				bottomCenter.
				bottomRight}.
	^ container
]

{ #category : #'instance creation' }
BrDropdownExamples >> badgeButton [
	<gtExample>
	<return: #BrLabel>
	^ BrLabel new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		padding: (BlInsets all: 7);
		background: Color orange;
		text: ('3' asRopedText
				fontSize: 15;
				foreground: Color white;
				bold);
		yourself
]

{ #category : #examples }
BrDropdownExamples >> coloredDropdown [
	<gtExample>
	<return: #BrButton>
	| aButtonCircularLook aWithDropdownLook |
	aButtonCircularLook := [ BrLazyStyleCommonAptitude new
			default: [ :e | 
				e
					background: BrGlamorousColors defaultButtonBorderColor;
					border: (BlBorder paint: BrGlamorousColors defaultButtonBackgroundColor width: 3) ];
			hovered: [ :e | e background: BrGlamorousColors hoveredButtonBorderColor ] ]
			asStencil.

	aWithDropdownLook := BrGlamorousWithExplicitDropdownAptitude
			handle: [ BrButton new
					size: 20 @ 20;
					geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
					aptitude: aButtonCircularLook create ]
			content: [ BrEditor new
					aptitude: BrGlamorousCodeEditorAptitude;
					text: '<content>






</content>';
					padding: (BlInsets all: 10);
					matchParent;
					yourself ]
			containerDo: [ :aMenuContainer | 
				aMenuContainer
					geometry: (BlChildrenWrappingGeometry cornerRadius: 10 enlargedBy: 1) ].

	^ BrButton new
		size: 20 @ 20;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		label: 'howdy';
		aptitude: aButtonCircularLook create + aWithDropdownLook;
		yourself
]

{ #category : #examples }
BrDropdownExamples >> compact [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude
				+ (BrGlamorousWithExplicitDropdownAptitude
						handle: [ BrButton new
								aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonLabelAptitude;
								label: 'click me';
								yourself ]
						content: [ BrFrame new
								fitContent;
								addChild: (BlElement new
										background: (Color gray alpha: 0.2);
										size: 100 @ 100;
										margin: (BlInsets all: 10);
										yourself) ]);
		label: 'click me';
		yourself
]

{ #category : #'examples - hide' }
BrDropdownExamples >> hideOnClickViaDropdownLook [
	<gtExample>
	<return: #BrButton>
	| aWithDropdownLook |
	aWithDropdownLook := nil.
	aWithDropdownLook := BrGlamorousWithExplicitDropdownAptitude
			handle: [ BrButton new
					aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonIconAptitude;
					icon: BrGlamorousIcons menu ]
			content: [ BrFrame new
					fitContent;
					addChild: (BrButton new
							aptitude: BrGlamorousButtonWithLabelAptitude new;
							label: 'Close';
							margin: (BlInsets all: 20);
							action: [ :aButton | aButton fireEvent: BrDropdownHideWish new ]) ].

	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude + aWithDropdownLook;
		icon: BrGlamorousIcons menu;
		yourself
]

{ #category : #'examples - hide' }
BrDropdownExamples >> hideOnClickViaWish [
	<gtExample>
	<return: #BrButton>
	| aWithDropdownLook |
	aWithDropdownLook := BrGlamorousWithExplicitDropdownAptitude
			handle: [ BrButton new
					aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonIconAptitude;
					icon: BrGlamorousIcons menu ]
			content: [ BrButton new
					aptitude: BrGlamorousButtonWithLabelAptitude new;
					label: 'Close';
					margin: (BlInsets all: 20);
					action: [ :aButton | aButton fireEvent: BrDropdownHideWish new ] ].

	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude + aWithDropdownLook;
		icon: BrGlamorousIcons menu;
		yourself
]

{ #category : #'examples - hide' }
BrDropdownExamples >> hideOnClickViaWishInNestedDropdown [
	<gtExample>
	<return: #BrButton>
	| aWithDropdownLook |
	aWithDropdownLook := BrGlamorousWithExplicitDropdownAptitude
			handle: [ BrButton new
					aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonIconAptitude;
					icon: BrGlamorousIcons menu ]
			content: [ BrVerticalPane new
					fitContent;
					padding: (BlInsets all: 20);
					addChildren: {BrButton new
								aptitude: BrGlamorousButtonWithLabelAptitude new;
								label: 'Close';
								margin: (BlInsets bottom: 20);
								action: [ :aButton | aButton fireEvent: BrDropdownHideWish new ].
							BrButton new
								aptitude: BrGlamorousButtonWithIconAptitude
										+ (BrGlamorousWithExplicitDropdownAptitude
												handle: [ BrButton new
														aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonIconAptitude;
														icon: BrGlamorousIcons menu ]
												content: [ BrFrame new
														fitContent;
														addChild: (BrButton new
																aptitude: BrGlamorousButtonWithLabelAptitude new;
																margin: (BlInsets all: 20);
																label: 'Close';
																action: [ :aButton | aButton fireEvent: BrDropdownHideWish new ]) ]);
								icon: BrGlamorousIcons menu} ].

	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude + aWithDropdownLook;
		icon: BrGlamorousIcons menu;
		yourself
]

{ #category : #'instance creation' }
BrDropdownExamples >> popupList [
	<gtExample>
	<return: #BrSimpleList>
	^ BrSimpleListExamples new allClasses
		aptitudeDo: [ :aLook | aLook listElement constraintsDo: [ :c | c maxHeight: 200 ] ];
		layout: BlLinearLayout vertical;
		padding: (BlInsets all: 5);
		vFitContent;
		hExact: 200
]

{ #category : #examples }
BrDropdownExamples >> roundedDropdownList [
	<gtExample>
	<return: #BrButton>
	^ self toggleButton
		aptitude: BrGlamorousButtonWithLabelAndIconAptitude
				+ (BrGlamorousWithExplicitDropdownAptitude
						handle: [ self toggleButton
								aptitude: BrGlamorousButtonWithLabelAndIconAptitude - BrGlamorousButtonExteriorAptitude;
								yourself ]
						content: [ self popupList ]);
		yourself
]

{ #category : #examples }
BrDropdownExamples >> scaledAndAlignedDropdowns [
	<gtExample>
	<return: #BlElement>
	^ self alignedDropdowns
		constraintsDo: [ :c | c ignoreByLayout ];
		size: 200 @ 200;
		background: Color white;
		aptitude: BrShadowAptitude new;
		padding: (BlInsets all: 10);
		margin: (BlInsets all: 10);
		transformDo: [ :t | t scaleBy: 2 @ 2 ];
		relocate: 120 @ 120;
		yourself
]

{ #category : #examples }
BrDropdownExamples >> suggesterBadgeDropdownList [
	<gtExample>
	<return: #BrLabel>
	^ self badgeButton
		aptitude: BrTextLabelAptitude
				+ (BrGlamorousWithExplicitDropdownAptitude
						handle: [ self badgeButton
								aptitude: BrTextLabelAptitude;
								yourself ]
						content: [ self popupList
								background: Color white;
								border: (BlBorder paint: Color orange width: 1) ]
						containerDo: [ :aMenuContainer | 
							aMenuContainer
								background: Color orange;
								border: (BlBorder paint: Color orange width: 1) ]);
		relocate: 200 @ 100;
		yourself
]

{ #category : #'instance creation' }
BrDropdownExamples >> toggleButton [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		label: 'Classes';
		icon: (BlElement new
				size: 8 @ 8;
				geometry: (BlPolygonGeometry
						vertices: {0 @ 0.
								8 @ 0.
								(8 / 2) rounded @ 8});
				background: Color lightGray;
				margin: (BlInsets left: 6);
				constraintsDo: [ :c | c linear vertical alignCenter ]);
		yourself
]
