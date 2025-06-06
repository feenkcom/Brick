"
I am a collection of ""showroom"" examples.

# Buttons

In the example below we show all existing button styles
{{gtExample:BrExamplesShowroom class>>#allButtons|expanded|noCode}}

The following glamorous button reacts to various UI interaction events and changes its style according the state (pressed, hovered)
{{gtExample:BrExamplesShowroom>>#glamorousButton}}

Button can also be disabled to prevent click events
{{gtExample:BrExamplesShowroom>>#glamorousDisabledButton}}

# Toggles

Toggle buttons can have radically different look, while the behaviour of all of them is exactly the same.
{{gtExample:BrExamplesShowroom class>>#allToggles|noCode}}

## Labelled toggle

To create a toggle button with a label user should the corresponding  {{gtClass:BrMaterialToggleWithIconAptitude}}

{{gtExample:BrExamplesShowroom>>#materialLabelToggle}}

## Iconified toggle

Similarly we can use the icon look to build an iconified toggle:
{{gtExample:BrExamplesShowroom>>#materialIconToggle}}

## Iconified labelled toggle

We can compose label and icon looks to create a toggle button with both label and the icon. Note that the order of looks defines the visual order of the label and icon:

{{gtExample:BrExamplesShowroom>>#materialToggle}}

Thus being said by swapping the label and icon look we can move the icon to the right from the label:

{{gtExample:BrExamplesShowroom>>#materialReversedToggle}}

# Accordion

Accordion is the exandable and collapsable widget that consists of a header and a content. Any visual {{gtClass:BlElement}} can be a header of the accordion. The following example shows how a {{gtClass:BrButton}} can be used an accordion header:

{{gtExample:BrExamplesShowroom>>#accordion}}

# Tabs

The following example shows how to create a tab group widget with 3 tabs. The content of each tab is defined with the help of a stencil.

{{gtExample:BrExamplesShowroom>>#glamorousTabs}}

# Toolbar

The toolbar is a logical set of action buttons (either labelled or iconified).
{{gtExample:BrExamplesShowroom>>#glamorousToolbar}}
{{gtExample:BrExamplesShowroom>>#materialToolbar}}

# List

The example below describes how to instantiate a new instance of the simple list that only has one column:
{{gtExample:BrExamplesShowroom>>#simpleList|noCode}}

{{gtExample:BrExamplesShowroom>>#columnedList|noCode}}











"
Class {
	#name : #BrExamplesShowroom,
	#superclass : #Object,
	#category : #'Brick-Examples-! Showroom'
}

{ #category : #buttons }
BrExamplesShowroom class >> allButtons [
	<gtExample>

	^ BlElement new
		layout: (BlGridLayout new cellSpacing: 30);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent
		];
		addChildren: { 
			self new glamorousTinyButton.
			self new glamorousSmallButton.
			self new glamorousButton.
			self new glamorousLargeButton.
			self new glamorousDisabledButton.
			self new materialButton
		}
]

{ #category : #buttons }
BrExamplesShowroom class >> allToggles [
	<gtExample>

	^ BlElement new
		layout: (BlGridLayout new cellSpacing: 30; columnCount: 3);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent
		];
		addChildren: { 
			self new hydraToggle.
			self new hydraWithTrackToggle.
			self new hydraWithoutTrackToggle.
			self new materialIconToggle.
			self new materialLabelToggle.
			self new materialToggle
			
		}
]

{ #category : #accordion }
BrExamplesShowroom >> accordion [
	<gtExample>
	<return: #BrAccordion>
	| accordion |
	accordion := BrAccordion new.
	accordion vExact: 200.
	accordion aptitude: BrGlamorousAccordionAptitude new.
	accordion content: [ BlElement new background: Color paleRed ].
	accordion
		header: [ BrButton new
				aptitude: BrGlamorousAccordionHeaderAptitude new;
				label: 'Click to expand/collapse';
				action: [ accordion toggleExpanded ] ].
	^ accordion
]

{ #category : #accordion }
BrExamplesShowroom >> accordionList [
	<gtExample>
	<return: #BlElement>
	| children container |
	children := 5
			timesCollect: [ :anIndex | 
				| accordion |
				accordion := BrAccordion new.
				accordion aptitude: BrGlamorousAccordionAptitude new.
				accordion margin: (BlInsets all: 5).
				accordion content: [ BrEditor new text: 'Hello world' asRopedText ].
				accordion
					header: [ BrButton new
							aptitude: BrGlamorousAccordionHeaderAptitude new;
							label: 'Header ' , anIndex asString;
							action: [ accordion toggle ] ].
				accordion ].

	container := BlElement new.
	container layout: BlLinearLayout vertical.
	container padding: (BlInsets all: 10).
	container
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].

	container addChildren: children.
	^ container
]

{ #category : #list }
BrExamplesShowroom >> columnedList [
	<gtExample>
	<return: #BrColumnedList>
	| aList |
	aList := BrColumnedList new.
	aList column
		width: 50;
		title: 'Index';
		stencil: [ :aColor :aRowIndex | 
			BrLabel new
				aptitude: (BrGlamorousLabelAptitude new foreground: aColor contrastingBlackAndWhiteColor);
				text: aRowIndex asString;
				background: aColor;
				padding: (BlInsets all: 12) ].
	aList column
		matchParent;
		title: 'Color';
		stencil: [ :aColor | 
			BrLabel new
				aptitude: (BrGlamorousLabelAptitude new foreground: aColor contrastingBlackAndWhiteColor);
				text: aColor asString;
				background: aColor;
				padding: (BlInsets all: 12) ].
	aList items: Color indexedColors.
	^ aList
]

{ #category : #breacrumb }
BrExamplesShowroom >> glamorousBreadcrumb [
	<gtExample>
	<description: 'Breadcrumb with glamorous look'>
	<return: #BrBreadcrumb>
	| aBreadcrumb |
	aBreadcrumb := BrBreadcrumb new.
	aBreadcrumb
		aptitude: (BrGlamorousBreadcrumbAptitude new
				separator: [ BrLabel new
						aptitude: (BrGlamorousLabelAptitude new thin foreground: Color gray);
						text: '>';
						margin: (BlInsets left: 5 right: 5) ]).

	aBreadcrumb
		addItem: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: 'Home').

	aBreadcrumb
		addItem: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: 'Store').

	aBreadcrumb
		addItem: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: 'T-Shirt').

	^ aBreadcrumb
]

{ #category : #buttons }
BrExamplesShowroom >> glamorousButton [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Button';
		action: [ self inform: 'Clicked' ]
]

{ #category : #buttons }
BrExamplesShowroom >> glamorousButtonWithTooltipLook [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		label: 'Accept';
		icon: BrGlamorousVectorIcons accept;
		action: [ self inform: 'Clicked' ]
]

{ #category : #buttons }
BrExamplesShowroom >> glamorousDefaultButton [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Button';
		action: [ self inform: 'Clicked' ]
]

{ #category : #buttons }
BrExamplesShowroom >> glamorousDisabledButton [
	<gtExample>
	<return: #BrButton>
	^ self glamorousButton disable
]

{ #category : #buttons }
BrExamplesShowroom >> glamorousHugeButton [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		beHugeSize;
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Button';
		action: [ self inform: 'Clicked' ]
]

{ #category : #buttons }
BrExamplesShowroom >> glamorousLargeButton [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		beLargeSize;
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Button';
		action: [ self inform: 'Clicked' ]
]

{ #category : #buttons }
BrExamplesShowroom >> glamorousSmallButton [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		beSmallSize;
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Button';
		action: [ self inform: 'Clicked' ]
]

{ #category : #tabs }
BrExamplesShowroom >> glamorousTabs [
	<gtExample>
	<description: 'Tabs with glamorous look'>
	<return: #BrTabGroup>
	| aTabGroup |
	aTabGroup := BrTabGroup new.
	aTabGroup aptitude: BrGlamorousTabGroupAptitude new.

	aTabGroup
		addTab: (BrTab new
				aptitude: BrGlamorousTabAptitude new;
				label: 'Tab 1';
				stencil: [ BlElement new
						constraintsDo: [ :c | 
							c horizontal exact: 300.
							c vertical exact: 150 ];
						margin: (BlInsets all: 10);
						background: (Color red alpha: 0.2) ]).

	aTabGroup
		addTab: (BrTab new
				aptitude: BrGlamorousTabAptitude new;
				label: 'Tab 2';
				stencil: [ BlElement new
						margin: (BlInsets all: 10);
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical exact: 50 ];
						background: (Color blue alpha: 0.2) ]).

	aTabGroup
		addTab: (BrTab new
				aptitude: BrGlamorousTabAptitude new;
				label: 'Tab 3';
				stencil: [ BlElement new
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical exact: 100 ];
						margin: (BlInsets all: 10);
						background: (Color orange alpha: 0.2) ]).

	^ aTabGroup
]

{ #category : #tabs }
BrExamplesShowroom >> glamorousTabsSwitcherWithHiddenSelectedTabsWithIcons [
	<gtExample>
	<description: 'Tabs with glamorous switcher look'>
	<return: #BrTabGroup>
	| aTabGroup |
	aTabGroup := BrTabGroup new.
	aTabGroup
		aptitude: BrGlamorousTabGroupSwitcherWithHiddenSelectedTabAptitude new.

	aTabGroup
		addTab: (BrTab new
				aptitude: BrGlamorousTabSwitcherWithIconAptitude new;
				label: 'Tab 1';
				icon: BrGlamorousVectorIcons add;
				stencil: [ BlElement new
						constraintsDo: [ :c | 
							c horizontal exact: 300.
							c vertical matchParent ];
						margin: (BlInsets all: 10);
						background: (Color red alpha: 0.2) ]).

	aTabGroup
		addTab: (BrTab new
				aptitude: BrGlamorousTabSwitcherWithIconAptitude new;
				label: 'Tab 2';
				icon: BrGlamorousVectorIcons remove;
				stencil: [ BlElement new
						margin: (BlInsets all: 10);
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical matchParent ];
						background: (Color blue alpha: 0.2) ]).

	^ aTabGroup
]

{ #category : #tabs }
BrExamplesShowroom >> glamorousTabsSwitcherWithHiddenSelectedTabsWithLabels [
	<gtExample>
	<description: 'Tabs with glamorous switcher look'>
	<return: #BrTabGroup>
	| aTabGroup |
	aTabGroup := BrTabGroup new.
	aTabGroup
		aptitude: BrGlamorousTabGroupSwitcherWithHiddenSelectedTabAptitude new.

	aTabGroup
		addTab: (BrTab new
				aptitude: BrGlamorousTabSwitcherWithLabelAptitude new;
				label: 'Tab 1';
				stencil: [ BlElement new
						constraintsDo: [ :c | 
							c horizontal exact: 300.
							c vertical matchParent ];
						margin: (BlInsets all: 10);
						background: (Color red alpha: 0.2) ]).

	aTabGroup
		addTab: (BrTab new
				aptitude: BrGlamorousTabSwitcherWithLabelAptitude new;
				label: 'Tab 2';
				stencil: [ BlElement new
						margin: (BlInsets all: 10);
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical matchParent ];
						background: (Color blue alpha: 0.2) ]).

	^ aTabGroup
]

{ #category : #tabs }
BrExamplesShowroom >> glamorousTabsSwitcherWithIcons [
	<gtExample>
	<description: 'Tabs with glamorous switcher look'>
	<return: #BrTabGroup>
	| aTabGroup |
	aTabGroup := BrTabGroup new.
	aTabGroup aptitude: BrGlamorousTabGroupSwitcherAptitude new.

	aTabGroup
		addTab: (BrTab new
				aptitude: BrGlamorousTabSwitcherWithIconAptitude new;
				label: 'Tab 1';
				icon: BrGlamorousVectorIcons add;
				stencil: [ BlElement new
						constraintsDo: [ :c | 
							c horizontal exact: 300.
							c vertical matchParent ];
						margin: (BlInsets all: 10);
						background: (Color red alpha: 0.2) ]).

	aTabGroup
		addTab: (BrTab new
				aptitude: BrGlamorousTabSwitcherWithIconAptitude new;
				label: 'Tab 2';
				icon: BrGlamorousVectorIcons remove;
				stencil: [ BlElement new
						margin: (BlInsets all: 10);
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical matchParent ];
						background: (Color blue alpha: 0.2) ]).

	^ aTabGroup
]

{ #category : #tabs }
BrExamplesShowroom >> glamorousTabsSwitcherWithLabels [
	<gtExample>
	<description: 'Tabs with glamorous switcher look'>
	<return: #BrTabGroup>
	| aTabGroup |
	aTabGroup := BrTabGroup new.
	aTabGroup aptitude: BrGlamorousTabGroupSwitcherAptitude new.

	aTabGroup
		addTab: (BrTab new
				aptitude: BrGlamorousTabSwitcherWithLabelAptitude new;
				label: 'Tab 1';
				stencil: [ BlElement new
						constraintsDo: [ :c | 
							c horizontal exact: 300.
							c vertical matchParent ];
						margin: (BlInsets all: 10);
						background: (Color red alpha: 0.2) ]).

	aTabGroup
		addTab: (BrTab new
				aptitude: BrGlamorousTabSwitcherWithLabelAptitude new;
				label: 'Tab 2';
				stencil: [ BlElement new
						margin: (BlInsets all: 10);
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical matchParent ];
						background: (Color blue alpha: 0.2) ]).

	^ aTabGroup
]

{ #category : #tabs }
BrExamplesShowroom >> glamorousTabsWithTabAddedAfterSelectedTab [
	<gtExample>
	<description: 'Tabs with glamorous look'>
	<return: #BrTabGroup>
	| aTabGroup |
	aTabGroup := BrTabGroup new.
	aTabGroup aptitude: BrGlamorousTabGroupAptitude new.

	aTabGroup
		addTab: (BrTab new
				aptitude: BrGlamorousTabAptitude new;
				label: 'Tab 1';
				stencil: [ BlElement new
						constraintsDo: [ :c | 
							c horizontal exact: 300.
							c vertical exact: 150 ];
						margin: (BlInsets all: 10);
						background: (Color red alpha: 0.2) ]).

	aTabGroup
		addTab: (BrTab new
				aptitude: BrGlamorousTabAptitude new;
				label: 'Tab 2';
				stencil: [ BlElement new
						margin: (BlInsets all: 10);
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical exact: 50 ];
						background: (Color blue alpha: 0.2) ]).

	aTabGroup
		addTabAfterSelectedTab: (BrTab new
				aptitude: BrGlamorousTabAptitude new;
				label: 'Tab 3';
				stencil: [ BlElement new
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical exact: 100 ];
						margin: (BlInsets all: 10);
						background: (Color orange alpha: 0.2) ]).

	^ aTabGroup
]

{ #category : #buttons }
BrExamplesShowroom >> glamorousTinyButton [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		beTinySize;
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Button';
		action: [ self inform: 'Clicked' ]
]

{ #category : #toolbar }
BrExamplesShowroom >> glamorousToolbar [
	<gtExample>
	<description: 'Toolbar with glamorous look'>
	<return: #BrToolbar>
	| aToolbar |
	aToolbar := BrToolbar new.
	aToolbar aptitude: BrGlamorousToolbarAptitude new.

	aToolbar
		addItem: (BrButton new
				aptitude: BrGlamorousButtonWithLabelAptitude new;
				label: 'Button 1').

	aToolbar
		addItem: (BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude new;
				label: 'Button 2').

	aToolbar
		addItem: (BrButton new
				aptitude: BrGlamorousButtonWithLabelAptitude new;
				label: 'Button 3').

	^ aToolbar
]

{ #category : #toggle }
BrExamplesShowroom >> hydraToggle [
	<gtExample>
	<return: #BrToggle>
	^ BrToggle new aptitude: BrHydraSwitchRadioAptitude new
]

{ #category : #toggle }
BrExamplesShowroom >> hydraWithTrackToggle [
	<gtExample>
	<return: #BrToggle>
	^ BrToggle new aptitude: BrHydraSwitchWithTrackAptitude new
]

{ #category : #toggle }
BrExamplesShowroom >> hydraWithoutTrackToggle [
	<gtExample>
	<return: #BrToggle>
	^ BrToggle new aptitude: BrHydraSwitchWithoutTrackAptitude new
]

{ #category : #buttons }
BrExamplesShowroom >> materialButton [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrMaterialButtonAptitude new;
		label: 'Button'
]

{ #category : #buttons }
BrExamplesShowroom >> materialDisabledButton [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrMaterialButtonAptitude new;
		label: 'Disabled';
		disable
]

{ #category : #toggle }
BrExamplesShowroom >> materialIconAndLabelToggle [
	<gtExample>
	<return: #BrToggle>
	^ BrToggle new
		aptitude: BrMaterialToggleWithIconAptitude + BrMaterialToggleWithLabelAptitude
]

{ #category : #toggle }
BrExamplesShowroom >> materialIconToggle [
	<gtExample>
	<return: #BrToggle>
	^ BrToggle new aptitude: BrMaterialToggleWithIconAptitude
]

{ #category : #toggle }
BrExamplesShowroom >> materialLabelToggle [
	<gtExample>
	<return: #BrToggle>
	^ BrToggle new aptitude: BrMaterialToggleWithLabelAptitude
]

{ #category : #toggle }
BrExamplesShowroom >> materialReversedToggle [
	<gtExample>
	<return: #BrToggle>
	^ BrToggle new
		aptitude: BrMaterialToggleWithLabelAptitude + BrMaterialToggleWithIconAptitude
]

{ #category : #toggle }
BrExamplesShowroom >> materialToggle [
	<gtExample>
	<return: #BrToggle>
	^ BrToggle new
		aptitude: BrMaterialToggleWithIconAptitude + BrMaterialToggleWithLabelAptitude
]

{ #category : #toolbar }
BrExamplesShowroom >> materialToolbar [
	<gtExample>
	<description: 'Toolbar with material look'>
	<return: #BrToolbar>
	| aToolbar |
	aToolbar := BrToolbar new.
	aToolbar aptitude: BrMaterialToolbarAptitude new.

	aToolbar
		addItem: (BrButton new
				aptitude: BrMaterialButtonAptitude new;
				label: 'Button 1').

	aToolbar
		addItem: (BrButton new
				aptitude: BrMaterialButtonAptitude new;
				label: 'Button 2').

	aToolbar
		addItem: (BrButton new
				aptitude: BrMaterialButtonAptitude new;
				label: 'Button 3').

	^ aToolbar
]

{ #category : #list }
BrExamplesShowroom >> simpleList [
	<gtExample>
	<return: #BrSimpleList>
	^ BrSimpleList new
		items: Color indexedColors;
		stencil: [ :aColor | 
			BrLabel new
				aptitude: (BrGlamorousLabelAptitude new foreground: aColor contrastingBlackAndWhiteColor);
				text: aColor asString;
				background: aColor;
				padding: (BlInsets all: 12);
				hMatchParent ]
]
