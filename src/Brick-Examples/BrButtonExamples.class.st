"
# Brick buttons
Button is one of the most essential graphical components in UI. It can be in a lot of different variaties and forms.
See {{gtClass:BrButtonModel}} for a more detailed description.
## Instantiating a button
A button widget is an instance of {{gtClass:BrButton}}. By default it does not have any attached look and therefore has no visual appearance:

{{gtExample:BrButtonExamples>>#newButton}}
## Behavior
A button widget is composed of multiple view models that add important functionality:

{{gtClass:BrLabelModel}} is responsible for button's label
{{gtClass:BrIconModel}} adds support of an icon
{{gtClass:TBrSizeAdjustable}} is responsible for managing the logical size of a button (tiny, small, large etc)
{{gtClass:TBrLayoutAlignable}} lets users to align a button's content within the button itself (center, top-right, etc)
{{gtClass:TBrLayoutResizable}} provides support for horizontal and vertical resizing strategies (fit content, match parent, exact size)

## Building a button
Button's look can be implemented by composing existing looks or implementing a new one.
### Adding and styling a label
Having {{gtClass:BrLabelModel}} view model is not enough to create a button with a label. For that we would need to add {{gtClass:BrTextLabelAptitude}}:
{{gtExample:BrButtonExamples>>#buttonWithLabelLook|previewShow=#gtLiveFor:|previewHeight=55|previewExpanded=true}}

Of course, a text style can be customized to match user's preference:
{{gtExample:BrButtonExamples>>#buttonWithLabelLookAndCustomFont|previewShow=#gtLiveFor:|previewHeight=70|previewExpanded=true}}

Quite often though, it may be needed to change label's style when users hover a button. {{gtClass:BrHoverModel}} handles widget hover state change. To style the text accordingly we can add {{gtClass:BrInteractiveCommonAptitude}} to the previosly created {{gtClass:BrTextLabelAptitude}}. Please note that we should also provide default values for all button properties that change due to interactivity in a `default:` style:
{{gtExample:BrButtonExamples>>#buttonWithLabelLookReactingToHover|previewShow=#gtLiveFor:|previewHeight=70|previewExpanded=true}}

In a similar fashing we can also change the text style on a button press which is managed by {{gtClass:BrPressModel}}:
{{gtExample:BrButtonExamples>>#buttonWithLabelLookReactingToHoverAndPress|previewShow=#gtLiveFor:|previewHeight=70|previewExpanded=true}}

One more common use-case is to provide a text style for a disabled button which is modelled by {{gtClass:BrInteractiveModel}}. Please note that disabled button does not react to click and hover events:
{{gtExample:BrButtonExamples>>#buttonWithLabelLookReactingToHoverAndPressAndDisabled|previewShow=#gtLiveFor:|previewHeight=70|previewExpanded=true}}

Sometimes users may want to create a look that depends on a logical button size modelled by {{gtClass:BrSizeAdjustmentModel}}. For example a button can be made huge `beHuge` or tiny `beTiny`. To style a label based on the logical widget size we can use {{gtClass:BrSizeAdjustmentAptitude}} which provides a fluent api for variuos sizes. Click on the label to randomly change its logial size:
{{gtExample:BrButtonExamples>>#buttonWithLabelLookOfDifferentSizes|previewShow=#gtLiveFor:|previewHeight=70|previewExpanded=true}}

Now lets put together the final label look that we will use later to build our custom button:
{{gtExample:BrButtonExamples>>#labelLookWithCommonAndSizeInteractions}}

### Adding and styling the button's exterior


"
Class {
	#name : #BrButtonExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Button'
}

{ #category : #'instance creation' }
BrButtonExamples >> buttonAndLookWithLabelAndExterior [
	<gtExample>
	<return: #BrButton>
	| aButtonLook aLabelLook anExteriorLook |
	aLabelLook := BrTextLabelAptitude new.
	aLabelLook
		bold;
		fontName: 'Source Sans Pro'.

	aLabelLook
		add: (BrInteractiveCommonAptitude new
				default: [ aLabelLook foreground: Color gray ];
				hovered: [ aLabelLook foreground: Color white ];
				pressed: [ aLabelLook foreground: Color paleBlue ];
				disabled: [ aLabelLook foreground: Color veryLightGray ]).

	aLabelLook
		add: (BrDeprecatedSizeAdjustmentAptitude new
				default: [ aLabelLook fontSize: 20 ];
				tiny: [ aLabelLook fontSize: 10 ];
				small: [ aLabelLook fontSize: 16 ];
				large: [ aLabelLook fontSize: 26 ];
				huge: [ aLabelLook fontSize: 36 ]).

	anExteriorLook := BrInteractiveCommonAptitude new.
	anExteriorLook
		default: [ :aWidget | 
			aWidget
				padding: (BlInsets
						top: 5
						left: 10
						bottom: 5
						right: 10).
			aWidget background: Color veryVeryLightGray ];
		hovered: [ :aWidget | 
			aWidget
				background: (Color
						r: 0.27
						g: 0.67
						b: 0.99) ];
		pressed: [ :aWidget | 
			aWidget
				background: (Color
						r: 0.04
						g: 0.43
						b: 0.85) ];
		disabled: [ :aWidget | aWidget background: Color veryVeryLightGray ].

	anExteriorLook add: BrLayoutResizerAptitude inherit.
	anExteriorLook add: BrLayoutAlignmentAptitude new.
	anExteriorLook
		addChangeProperty: #(widget layout)
		with: [ BlLinearLayout horizontal ].
	anExteriorLook add: (BrFlatShadowAptitude new offset: 3 @ 3).

	aButtonLook := BrAptitude new.
	aButtonLook
		addAll: {aLabelLook.
				anExteriorLook}.

	^ self newButton
		label: 'Button';
		aptitude: aButtonLook
]

{ #category : #accessing }
BrButtonExamples >> buttonWithAsyncBehavior [
	"Demonstrate the use of Async behavior with buttons.
	The example button:
	- initially has a label of 'Initial Label'.
	- when pressed the label changes to 'Pending...'.
	- If the current minute number is odd, an error is raised and the button label is changed to display it.
	- If the current minute number is even, the action waits 1 second and completes successfully."

	<gtExample>
	<return: #BrButton>
	| button |
	button := BrButton new
			label: 'Initial Label';
			aptitude: BrGlamorousButtonWithLabelAptitude;
			size: 200 @ 100.
	button
		action: [ :aButton | 
			aButton
				withAsyncFutureDo: [ :anElementFuture | 
					anElementFuture
						whenSuccess: [ :currentButton | 
							currentButton
								enable;
								label: 'Success' ];
						whenError: [ :currentButton :anError | 
							currentButton
								enable;
								label: 'Error: ' , anError printString ];
						whenPending: [ :currentButton | 
							currentButton
								disable;
								label: ('Pending...' asRopedText foreground: Color gray) ].
					aButton asyncFuture
						future: [ self inform: 'Starting wait'.
							Time now minutes odd ifTrue: [ self error: 'You got unlucky' ].
							1 seconds wait.
							self inform: 'Completed wait' ] asAsyncFuture ] ].
	^ button
]

{ #category : #'instance creation' }
BrButtonExamples >> buttonWithExteriorLook [
	<gtExample>
	<return: #BrButton>
	| anExteriorLook |
	anExteriorLook := BrInteractiveCommonAptitude new.
	anExteriorLook
		default: [ :aWidget | aWidget background: Color veryVeryLightGray ];
		hovered: [ :aWidget | 
			aWidget
				background: (Color
						r: 0.27
						g: 0.67
						b: 0.99) ];
		pressed: [ :aWidget | 
			aWidget
				background: (Color
						r: 0.04
						g: 0.43
						b: 0.85) ];
		disabled: [ :aWidget | aWidget background: Color veryVeryLightGray ].

	^ self newButton aptitude: anExteriorLook
]

{ #category : #'instance creation' }
BrButtonExamples >> buttonWithLabelLook [
	<gtExample>
	<return: #BrButton>
	| aLabelLook |
	aLabelLook := BrTextLabelAptitude new.

	^ self newButton aptitude: aLabelLook
]

{ #category : #'instance creation' }
BrButtonExamples >> buttonWithLabelLookAndCustomFont [
	<gtExample>
	<return: #BrButton>
	| aLabelLook |
	aLabelLook := BrTextLabelAptitude new.
	aLabelLook
		bold;
		fontName: 'Source Sans Pro';
		fontSize: 20;
		foreground: Color gray.

	^ self newButton aptitude: aLabelLook
]

{ #category : #'instance creation' }
BrButtonExamples >> buttonWithLabelLookOfDifferentSizes [
	<gtExample>
	<return: #BrButton>
	| aLabelLook |
	aLabelLook := BrTextLabelAptitude new.
	aLabelLook
		bold;
		fontName: 'Source Sans Pro'.

	aLabelLook
		add: (BrDeprecatedSizeAdjustmentAptitude new
				default: [ aLabelLook fontSize: 20 ];
				tiny: [ aLabelLook fontSize: 10 ];
				small: [ aLabelLook fontSize: 16 ];
				large: [ aLabelLook fontSize: 26 ];
				huge: [ aLabelLook fontSize: 36 ]).

	^ self newButton
		action: [ :aButton | 
			aButton
				perform: #(beNormalSize beTinySize beSmallSize beLargeSize beHugeSize) atRandom ];
		beSmallSize;
		aptitude: aLabelLook
]

{ #category : #'instance creation' }
BrButtonExamples >> buttonWithLabelLookReactingToHover [
	<gtExample>
	<return: #BrButton>
	| aLabelLook |
	aLabelLook := BrTextLabelAptitude new.
	aLabelLook
		bold;
		fontName: 'Source Sans Pro';
		fontSize: 20.

	aLabelLook
		add: (BrInteractiveCommonAptitude new
				default: [ aLabelLook foreground: Color gray ];
				hovered: [ aLabelLook foreground: Color darkGray ]).

	^ self newButton aptitude: aLabelLook
]

{ #category : #'instance creation' }
BrButtonExamples >> buttonWithLabelLookReactingToHoverAndPress [
	<gtExample>
	<return: #BrButton>
	| aLabelLook |
	aLabelLook := BrTextLabelAptitude new.
	aLabelLook
		bold;
		fontName: 'Source Sans Pro';
		fontSize: 20.

	aLabelLook
		add: (BrInteractiveCommonAptitude new
				default: [ aLabelLook foreground: Color gray ];
				hovered: [ aLabelLook foreground: Color darkGray ];
				pressed: [ aLabelLook foreground: Color black ]).

	^ self newButton aptitude: aLabelLook
]

{ #category : #'instance creation' }
BrButtonExamples >> buttonWithLabelLookReactingToHoverAndPressAndDisabled [
	<gtExample>
	<return: #BrButton>
	| aLabelLook |
	aLabelLook := BrGlamorousLabelAptitude new.
	aLabelLook
		bold;
		fontName: 'Source Sans Pro';
		fontSize: 20.

	aLabelLook
		add: (BrStyleCommonAptitude new
				@ aLabelLook label;
				default: [ :aStyle | aStyle foreground: Color gray ];
				hovered: [ :aStyle | aStyle foreground: Color darkGray ];
				pressed: [ :aStyle | aStyle  foreground: Color black ];
				disabled: [ :aStyle | aStyle  foreground: Color veryLightGray ]).

	^ self newButton
		disable;
		aptitude: aLabelLook
]

{ #category : #'instance creation' }
BrButtonExamples >> labelLookWithCommonAndSizeInteractions [
	<gtExample>
	<return: #BrTextLabelAptitude>
	| aLabelLook |
	aLabelLook := BrTextLabelAptitude new.
	aLabelLook
		bold;
		fontName: 'Source Sans Pro'.

	aLabelLook
		add: (BrInteractiveCommonAptitude new
				default: [ aLabelLook foreground: Color gray ];
				hovered: [ aLabelLook foreground: Color darkGray ];
				pressed: [ aLabelLook foreground: Color black ];
				disabled: [ aLabelLook foreground: Color veryLightGray ]).

	aLabelLook
		add: (BrDeprecatedSizeAdjustmentAptitude new
				default: [ aLabelLook fontSize: 20 ];
				tiny: [ aLabelLook fontSize: 10 ];
				small: [ aLabelLook fontSize: 16 ];
				large: [ aLabelLook fontSize: 26 ];
				huge: [ aLabelLook fontSize: 36 ]).

	^ aLabelLook
]

{ #category : #'instance creation' }
BrButtonExamples >> newButton [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
]
