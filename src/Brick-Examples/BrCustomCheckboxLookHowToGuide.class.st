"
# How to build a custom checkbox look with a label
In this how-to guide we will build a custom checkbox look with styles for every of the three states: `checked`, `unchecked` and `indeterminate`:
{{gtExample:BrCustomCheckboxLookHowToGuide>>#_8_withPressedBackgroundAll|noCode=true|previewShow=#gtLiveFor:|previewHeight=120}}
### Label
First of all we create an instance of a {{gtClass:BrCheckboxAptitude}} and add a {{gtClass:BrGlamorousLabelAptitude}} to it:
{{gtExample:BrCustomCheckboxLookHowToGuide>>#_1_withLabelLook|codeExpanded=false}}
This should create a widget with just a static text in it (by default it is `Label`), which is the same for all three states:
{{gtExample:BrCustomCheckboxLookHowToGuide>>#_1_withLabelLookAll|noCode=true|previewShow=#gtLiveFor:|previewHeight=120}}
### Border
Now let's add a border to the checkbox widget so we can see its boundaries. For this we will define a `default:` style of the {{gtClass:BrCheckboxAptitude}}:
{{gtExample:BrCustomCheckboxLookHowToGuide>>#_2_withBorder|codeExpanded=false}}
As a result we we should get a rectangular widget with a border:
{{gtExample:BrCustomCheckboxLookHowToGuide>>#_2_withBorderAll|noCode=true|previewShow=#gtLiveFor:|previewHeight=120}}
### Better geometry and layout
The widget does not look that nice, let's make it have a nice rounded rectangle geometry and some padding around the label, for that we will use already existed {{gtClass:BrGlamorousButtonRectangularAptitude}} which we can add directly to our checkbox look:
{{gtExample:BrCustomCheckboxLookHowToGuide>>#_3_withShape|codeExpanded=false}}
This should give us a better looking widget:
{{gtExample:BrCustomCheckboxLookHowToGuide>>#_3_withShapeAll|noCode=true|previewShow=#gtLiveFor:|previewHeight=120}}
### Label based on state
Since we wanted our checkbox to have a label that depends on the state we should define a text for each checkbox state:
{{gtExample:BrCustomCheckboxLookHowToGuide>>#_4_withStateText|codeExpanded=false}}
With this change we can finally distinguish between the states:
{{gtExample:BrCustomCheckboxLookHowToGuide>>#_4_withStateTextAll|noCode=true|previewShow=#gtLiveFor:|previewHeight=120}}
### Styling the text
Furthermore we can use the same mechanism and style the text depending on the state:
{{gtExample:BrCustomCheckboxLookHowToGuide>>#_5_withStyledStateText|codeExpanded=false}}
Users can easier understand in which state the checkbox is:
{{gtExample:BrCustomCheckboxLookHowToGuide>>#_5_withStyledStateTextAll|noCode=true|previewShow=#gtLiveFor:|previewHeight=120}}
### Dynamic background
Once we are able to style the text based on the text we could also change the widget's background accordingly:
{{gtExample:BrCustomCheckboxLookHowToGuide>>#_6_withStyledBackground|codeExpanded=false}}
{{gtExample:BrCustomCheckboxLookHowToGuide>>#_6_withStyledBackgroundAll|noCode=true|previewShow=#gtLiveFor:|previewHeight=120}}
### Reacting to hover
Even though the widget already looks like what we wanted, something still does not feel right. It is not ""live"" - there is no feedback when users hover a checkbox with a mouse, making it look like it is not clickable. To fix it, we should define a style for the composite states`(checked & hovered), (unchecked & hovered) and (indeterminate & hovered)`. It is important to define this style after the existing `checked`, `unchecked` and `indeterminate` states, because we want the hovered styles to have precedence over the non-hovered:
{{gtExample:BrCustomCheckboxLookHowToGuide>>#_7_withHoveredBackground|codeExpanded=false}}
Try to move the mouse over the checkboxes to see it in action:
{{gtExample:BrCustomCheckboxLookHowToGuide>>#_7_withHoveredBackgroundAll|noCode=true|previewShow=#gtLiveFor:|previewHeight=120}}
### Reacting to press
Very similar to the previous step we can extend our checkbox look to also react to the mouse pressed state:
{{gtExample:BrCustomCheckboxLookHowToGuide>>#_8_withPressedBackground|codeExpanded=false}}
This leaves us with a final custom checkbox widget built from almost from scratch in one simple script:
{{gtExample:BrCustomCheckboxLookHowToGuide>>#_8_withPressedBackgroundAll|noCode=true|previewShow=#gtLiveFor:|previewHeight=120}}

"
Class {
	#name : #BrCustomCheckboxLookHowToGuide,
	#superclass : #Object,
	#category : #'Brick-Examples-Checkbox'
}

{ #category : #'examples - look' }
BrCustomCheckboxLookHowToGuide >> _1_withLabelLook [
	<gtExample>
	<return: #BrCheckbox>
	| aLabel aLook |
	aLabel := BrGlamorousLabelAptitude new.

	aLook := BrCheckboxAptitude new.

	^ self checkboxWidget aptitude: aLook + aLabel
]

{ #category : #'examples - look' }
BrCustomCheckboxLookHowToGuide >> _1_withLabelLookAll [
	<gtExample>
	<return: #BrHorizontalFlow>
	^ self allCheckboxStates: #_1_withLabelLook
]

{ #category : #'examples - look' }
BrCustomCheckboxLookHowToGuide >> _2_withBorder [
	<gtExample>
	<return: #BrCheckbox>
	| aLabel aLook |
	aLabel := BrGlamorousLabelAptitude new.

	aLook := BrCheckboxAptitude new
			default: [ :aWidget | aWidget border: (BlBorder paint: Color gray width: 1) ].

	^ self checkboxWidget aptitude: aLook + aLabel
]

{ #category : #'examples - look' }
BrCustomCheckboxLookHowToGuide >> _2_withBorderAll [
	<gtExample>
	<return: #BrHorizontalFlow>
	^ self allCheckboxStates: #_2_withBorder
]

{ #category : #'examples - look' }
BrCustomCheckboxLookHowToGuide >> _3_withShape [
	<gtExample>
	<return: #BrCheckbox>
	| aLabel aLook aShape |
	aLabel := BrGlamorousLabelAptitude new.
	aShape := BrGlamorousButtonRectangularAptitude new.

	aLook := BrCheckboxAptitude new
			default: [ :aWidget | aWidget border: (BlBorder paint: Color gray width: 1) ].

	^ self checkboxWidget aptitude: aLook + aLabel + aShape
]

{ #category : #'examples - look' }
BrCustomCheckboxLookHowToGuide >> _3_withShapeAll [
	<gtExample>
	<return: #BrHorizontalFlow>
	^ self allCheckboxStates: #_3_withShape
]

{ #category : #'examples - look' }
BrCustomCheckboxLookHowToGuide >> _4_withStateText [
	<gtExample>
	<return: #BrCheckbox>
	| aLabel aLook aShape |
	aLabel := BrGlamorousLabelAptitude new.
	aShape := BrGlamorousButtonRectangularAptitude new.

	aLook := BrCheckboxAptitude new
			default: [ :aWidget | aWidget border: (BlBorder paint: Color gray width: 1) ];
			checked: [ :aWidget | aLabel text: 'Checked' ];
			unchecked: [ :aWidget | aLabel text: 'Unchecked' ];
			indeterminate: [ :aWidget | aLabel text: 'Indeterminate' ].

	^ self checkboxWidget aptitude: aLook + aLabel + aShape
]

{ #category : #'examples - look' }
BrCustomCheckboxLookHowToGuide >> _4_withStateTextAll [
	<gtExample>
	<return: #BrHorizontalFlow>
	^ self allCheckboxStates: #_4_withStateText
]

{ #category : #'examples - look' }
BrCustomCheckboxLookHowToGuide >> _5_withStyledStateText [
	<gtExample>
	<return: #BrCheckbox>
	| aLabel aLook aShape |
	aLabel := BrGlamorousLabelAptitude new.
	aShape := BrGlamorousButtonRectangularAptitude new.

	aLook := BrCheckboxAptitude new
			default: [ :aWidget | aWidget border: (BlBorder paint: Color gray width: 1) ];
			checked: [ :aWidget | 
				aLabel
					text: 'Checked';
					foreground: Color black;
					bold ];
			unchecked: [ :aWidget | 
				aLabel
					text: 'Unchecked';
					foreground: Color gray;
					regular ];
			indeterminate: [ :aWidget | 
				aLabel
					text: 'Indeterminate';
					foreground: Color veryLightGray;
					regular ].

	^ self checkboxWidget aptitude: aLook + aLabel + aShape
]

{ #category : #'examples - look' }
BrCustomCheckboxLookHowToGuide >> _5_withStyledStateTextAll [
	<gtExample>
	<return: #BrHorizontalFlow>
	^ self allCheckboxStates: #_5_withStyledStateText
]

{ #category : #'examples - look' }
BrCustomCheckboxLookHowToGuide >> _6_withStyledBackground [
	<gtExample>
	<return: #BrCheckbox>
	| aLabel aLook aShape |
	aLabel := BrGlamorousLabelAptitude new.
	aShape := BrGlamorousButtonRectangularAptitude new.

	aLook := BrCheckboxAptitude new
			default: [ :aWidget | aWidget border: (BlBorder paint: Color gray width: 1) ];
			checked: [ :aWidget | 
				aWidget background: self checkedBackground.
				aLabel
					text: 'Checked';
					foreground: Color black;
					bold ];
			unchecked: [ :aWidget | 
				aWidget background: self uncheckedBackground.
				aLabel
					text: 'Unchecked';
					foreground: Color gray;
					regular ];
			indeterminate: [ :aWidget | 
				aWidget background: self indeterminateBackground.
				aLabel
					text: 'Indeterminate';
					foreground: Color veryLightGray;
					regular ].

	^ self checkboxWidget aptitude: aLook + aLabel + aShape
]

{ #category : #'examples - look' }
BrCustomCheckboxLookHowToGuide >> _6_withStyledBackgroundAll [
	<gtExample>
	<return: #BrHorizontalFlow>
	^ self allCheckboxStates: #_6_withStyledBackground
]

{ #category : #'examples - look' }
BrCustomCheckboxLookHowToGuide >> _7_withHoveredBackground [
	<gtExample>
	<return: #BrCheckbox>
	| aLabel aLook aShape |
	aLabel := BrGlamorousLabelAptitude new.
	aShape := BrGlamorousButtonRectangularAptitude new.

	aLook := BrCheckboxAptitude new
			default: [ :aWidget | aWidget border: (BlBorder paint: Color gray width: 1) ];
			checked: [ :aWidget | 
				aWidget background: self checkedBackground.
				aLabel
					text: 'Checked';
					foreground: Color black;
					bold ];
			when: [ :aState | aState checked & aState hovered ]
				style: [ :aWidget | aWidget background: self checkedBackground darker ];
			unchecked: [ :aWidget | 
				aWidget background: self uncheckedBackground.
				aLabel
					text: 'Unchecked';
					foreground: Color gray;
					regular ];
			when: [ :aState | aState unchecked & aState hovered ]
				style: [ :aWidget | aWidget background: self uncheckedBackground darker ];
			indeterminate: [ :aWidget | 
				aWidget background: self indeterminateBackground.
				aLabel
					text: 'Indeterminate';
					foreground: Color veryLightGray;
					regular ];
			when: [ :aState | aState indeterminate & aState hovered ]
				style: [ :aWidget | aWidget background: self indeterminateBackground darker ].

	^ self checkboxWidget aptitude: aLook + aLabel + aShape
]

{ #category : #'examples - look' }
BrCustomCheckboxLookHowToGuide >> _7_withHoveredBackgroundAll [
	<gtExample>
	<return: #BrHorizontalFlow>
	^ self allCheckboxStates: #_7_withHoveredBackground
]

{ #category : #'examples - look' }
BrCustomCheckboxLookHowToGuide >> _8_withPressedBackground [
	<gtExample>
	<return: #BrCheckbox>
	| aLabel aLook aShape |
	aLabel := BrGlamorousLabelAptitude new.
	aShape := BrGlamorousButtonRectangularAptitude new.

	aLook := BrCheckboxAptitude new
			default: [ :aWidget | aWidget border: (BlBorder paint: Color gray width: 1) ];
			checked: [ :aWidget | 
				aWidget background: self checkedBackground.
				aLabel
					text: 'Checked';
					foreground: Color black;
					bold ];
			when: [ :aState | aState checked & aState hovered ]
				style: [ :aWidget | aWidget background: self checkedBackground darker ];
			when: [ :aState | aState checked & aState pressed ]
				style: [ :aWidget | aWidget background: self checkedBackground darker darker ];
			unchecked: [ :aWidget | 
				aWidget background: self uncheckedBackground.
				aLabel
					text: 'Unchecked';
					foreground: Color gray;
					regular ];
			when: [ :aState | aState unchecked & aState hovered ]
				style: [ :aWidget | aWidget background: self uncheckedBackground darker ];
			when: [ :aState | aState unchecked & aState pressed ]
				style: [ :aWidget | aWidget background: self uncheckedBackground darker darker ];
			indeterminate: [ :aWidget | 
				aWidget background: self indeterminateBackground.
				aLabel
					text: 'Indeterminate';
					foreground: Color veryLightGray;
					regular ];
			when: [ :aState | aState indeterminate & aState hovered ]
				style: [ :aWidget | aWidget background: self indeterminateBackground darker ];
			when: [ :aState | aState indeterminate & aState pressed ]
				style: [ :aWidget | aWidget background: self indeterminateBackground darker darker ].

	^ self checkboxWidget aptitude: aLook + aLabel + aShape
]

{ #category : #'examples - look' }
BrCustomCheckboxLookHowToGuide >> _8_withPressedBackgroundAll [
	<gtExample>
	<return: #BrHorizontalFlow>
	^ self allCheckboxStates: #_8_withPressedBackground
]

{ #category : #private }
BrCustomCheckboxLookHowToGuide >> allCheckboxStates: anExampleName [
	| aContainer |
	
	aContainer := BrHorizontalFlow new
		hMatchParent;
		vFitContent.

	aContainer addChildren: ({ #check . #uncheck . #indeterminate }
		collect: [ :aStateName |
			BrVerticalPane new
				alignTopCenter;
				margin: (BlInsets all: 10);
				padding: (BlInsets all: 15);
				background: Color white;
				addAptitude: BrShadowAptitude;
				fitContent;
				"addChild: (BrLabel new
					margin: (BlInsets bottom: 10);
					look: (BrGlamorousLabelLook new foreground: Color gray);
					text: aStateName);"
				addChild: ((self perform: anExampleName) perform: aStateName) ]).
			
	^ aContainer
]

{ #category : #'instance creation' }
BrCustomCheckboxLookHowToGuide >> checkboxLook [
	<gtExample>
	<return: #BrCheckboxAptitude>
	^ BrCheckboxAptitude new
]

{ #category : #'instance creation' }
BrCustomCheckboxLookHowToGuide >> checkboxWidget [
	<gtExample>
	<return: #BrCheckbox>
	^ BrCheckbox new
]

{ #category : #'instance creation' }
BrCustomCheckboxLookHowToGuide >> checkboxWidgetAll [
	<gtExample>
	<return: #BrHorizontalFlow>
	^ self allCheckboxStates: #checkboxWidget
]

{ #category : #'instance creation' }
BrCustomCheckboxLookHowToGuide >> checkedBackground [
	<gtExample>
	<return: #Color>
	^ Color
		r: 0.71
		g: 0.87
		b: 1
]

{ #category : #'instance creation' }
BrCustomCheckboxLookHowToGuide >> indeterminateBackground [
	<gtExample>
	<return: #Color>
	^ Color veryVeryLightGray lighter
]

{ #category : #'instance creation' }
BrCustomCheckboxLookHowToGuide >> uncheckedBackground [
	<gtExample>
	<return: #Color>
	^ Color white
]
