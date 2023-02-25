"
## Playing with Label Looks for Buttons
When using a label look, the label look embeds the label element directly in the widget element as a child. In the example below, the look is added directly to the button element:
{{gtExample:name=BrButtonLabelAptitudeExamples>>#buttonWithDirectlyEmbeddedLabel|expanded=true|previewExpanded=true}}

If the button has a more complex structure, this behaviour can cause problems. In the example below, the button defines a content element in which the label should be added. However, because the look is added to the button element, the label will be emdedd in the button element instead of the content element:
{{gtExample:name=BrButtonLabelAptitudeExamples>>#buttonWithModelAndWrongContentPlacement|expanded=true|previewExpanded=true}}

To change this behavior, the label look  provides more control over where the label is inserted into the button element: to identify the element in the button element where the label should be placed, the look looks for an element named `#content`. There shoud be only one element named  `#content` within the button.  To fix the problem from the above example,  we can name the `aContent` element with `#content` when adding it to the button element:
{{gtExample:name=BrButtonLabelAptitudeExamples>>#buttonWithModelAndLookWithoutConstraints|expanded=true|previewExpanded=true}}

The label look can directly change properties of the label element. This can be usefull when one wants to change layout properties or update graphical properties of the label:
{{gtExample:name=BrButtonLabelAptitudeExamples>>#buttonWithChangedConstraintsInLook|expanded=true|previewExpanded=true}}

After linking the button element with the label look and the button model, changing the value in the button model updates the label in the button element:
{{gtExample:name=BrButtonLabelAptitudeExamples>>#buttonWithModelAndLookAndChangedModelLabel|expanded=true|previewExpanded=true}}

When changing the label in the model, a `BlLabelChanged` event is triggered that reaches the label look, through the button widget. The propagation of this element is as follows:
{{gtExample:name=BrButtonLabelAptitudeExamples>>#labelChangedEvent|expanded=true|previewExpanded=true|previewShow=gtTraversedLiveFor:}}

In case the button widget does not have a label look attached, changing the value of the text in the model does not update the visual representation of the label in the button widget:
{{gtExample:name=BrButtonLabelAptitudeExamples>>#buttonWithOnlyModelAndChangedModelLabel|expanded=true|previewExpanded=true}}

When attaching a label look and a button model to a button widget the order in which they are attached does not matter.  If the model is set first then the text value set in the label look is not used; the model has priority  over the label look
{{gtExample:name=BrButtonLabelAptitudeExamples>>#buttonWithModelFirstThenLook|expanded=true|previewExpanded=true}}

"
Class {
	#name : #BrButtonLabelAptitudeExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Button'
}

{ #category : #'example - instance creation' }
BrButtonLabelAptitudeExamples >> allModels [
	<gtExample>
	
	| aModel |
	aModel := self buttonModel + self labelModel + self iconModel.
	self assert: aModel widgetModels size equals: 2.
	^ aModel
]

{ #category : #'example - instance creation' }
BrButtonLabelAptitudeExamples >> buttonContentElementWithFrameLayout [
	<gtExample>

	^ BlElement new
		border: (BlBorder paint: Color black width: 1);
		background: (Color white alpha: 0.5);
		layout: BlFrameLayout new;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent.
			c padding: (BlInsets all: 10) ]
]

{ #category : #'example - instance creation' }
BrButtonLabelAptitudeExamples >> buttonContentElementWithLinearLayout [
	<gtExample>

	^ BlElement new
		border: (BlBorder paint: Color black width: 1);
		background: (Color white alpha: 0.5);
		layout: BlLinearLayout new alignCenter;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent.
			c padding: (BlInsets all: 10) ]
]

{ #category : #'example - instance creation' }
BrButtonLabelAptitudeExamples >> buttonElement [
	<gtExample>

	^ BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		background: (Color gray alpha: 0.3);
		padding: (BlInsets all: 10)
]

{ #category : #'example - instance creation' }
BrButtonLabelAptitudeExamples >> buttonLabelElement [
	<gtExample>
	
	^ (BlTextElement text: self labelText asRopedText)
		constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ]
]

{ #category : #'example - instance creation' }
BrButtonLabelAptitudeExamples >> buttonLabelLookWithConstraints [
	<gtExample>

	^ BrTextLabelAptitude new labelDo: [ :aLabelElement | 
		aLabelElement constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ] ]
]

{ #category : #'example - instance creation' }
BrButtonLabelAptitudeExamples >> buttonLabelLookWithoutConstraints [
	<gtExample>

	^ BrTextLabelAptitude asLook
]

{ #category : #'example - instance creation' }
BrButtonLabelAptitudeExamples >> buttonModel [
	<gtExample>
	
	^ BrButtonModel new action: [ self inform: 'Clicked!' ]
]

{ #category : #'example - button' }
BrButtonLabelAptitudeExamples >> buttonWithChangedConstraintsInLook [
	<gtExample>
	| aButton aContent aLabelLook |
	
	aButton := self buttonElement.
	aContent := self buttonContentElementWithLinearLayout.
	aLabelLook := self buttonLabelLookWithoutConstraints
		labelDo: [ :aLabelElement | aLabelElement constraintsDo: [ :c | c linear vertical alignBottom ] ];
		fontSize: 30;
		bold.
	
	aButton addChild: aContent as: #content.

	aButton viewModel: self buttonModel.
	aButton aptitude: aLabelLook.
	
	^ aButton
]

{ #category : #'example - button' }
BrButtonLabelAptitudeExamples >> buttonWithDirectlyEmbeddedLabel [
	<gtExample>
	| aButton aLabelLook |
	
	aButton := self buttonElement.
	aLabelLook := self buttonLabelLookWithConstraints.

	aButton viewModel: self allModels.
	aButton aptitude: aLabelLook.
	
	self assert: aLabelLook label text asString equals: self labelText.
	self assert: aButton children asArray equals: { aLabelLook label }.

	^ aButton
]

{ #category : #'example - button' }
BrButtonLabelAptitudeExamples >> buttonWithModelAndLookAndChangedModelLabel [
	<gtExample>
	| aButton newLabel |
	
	newLabel := self labelText, ' World'.
	
	aButton := self buttonWithModelAndLookWithoutConstraints.
	
	aButton viewModel widgetModels first text: newLabel.

	self assert: aButton aptitude text asString equals: newLabel.
	self assert: aButton aptitude label text asString equals: newLabel.

	^ aButton
]

{ #category : #'example - button' }
BrButtonLabelAptitudeExamples >> buttonWithModelAndLookWithConstraints [
	<gtExample>
	| aButton aContent aLabelLook |
	
	aButton := self buttonElement.
	aContent := self buttonContentElementWithFrameLayout.
	aLabelLook := self buttonLabelLookWithConstraints.
	
	aButton addChild: aContent as: #content.

	aButton viewModel: self allModels.
	aButton aptitude: aLabelLook.
	
	self assert: aLabelLook label text asString equals: self labelText.
	
	self assert: aButton children asArray equals: { aContent }.
	self assert: aContent children asArray equals: { aLabelLook label }.

	^ aButton
]

{ #category : #'example - button' }
BrButtonLabelAptitudeExamples >> buttonWithModelAndLookWithoutConstraints [
	<gtExample>
	| aButton aContent aLabelLook |
	
	aButton := self buttonElement.
	aContent := self buttonContentElementWithLinearLayout.
	aLabelLook := self buttonLabelLookWithoutConstraints.
	
	aButton addChild: aContent as: #content.

	aButton viewModel: self allModels.
	aButton aptitude: aLabelLook.
	
	self assert: aLabelLook label text asString equals: self labelText.

	self assert: aButton children asArray equals: { aContent }.
	self assert: aContent children asArray equals: { aLabelLook label }.

	^ aButton
]

{ #category : #'example - button' }
BrButtonLabelAptitudeExamples >> buttonWithModelAndWrongContentPlacement [
	<gtExample>
	| aButton aContent aLabelLook |
	
	aButton := self buttonElement.
	aContent := self buttonContentElementWithFrameLayout.
	aLabelLook := self buttonLabelLookWithConstraints.

	aButton addChild: aContent.

	aButton viewModel: self allModels.
	aButton aptitude: aLabelLook.

	self assert: aButton children asArray equals: { aContent . aLabelLook label }.
	self assert: aContent children asArray equals: { }.

	^ aButton
]

{ #category : #'example - button' }
BrButtonLabelAptitudeExamples >> buttonWithModelFirstThenLook [
	<gtExample>
	| aButton aModel aLook modelLabel lookLabel |
	
	modelLabel := 'Hello world'.
	lookLabel := 'Hello cruel world'.
	
	aButton := self buttonElement.

	aModel := self labelModel + self buttonModel.
	aModel text: modelLabel.
	
	aLook := self buttonLabelLookWithConstraints.
	aLook text: lookLabel.
	
	aButton viewModel: aModel.
	aButton aptitude: aLook.
	
	self assert: aLook text asString equals: modelLabel.
	self assert: aModel text asString equals: modelLabel.
	
	^ aButton
]

{ #category : #'example - button' }
BrButtonLabelAptitudeExamples >> buttonWithOnlyModel [
	<gtExample>
	| aButton aContent aLabel |
	
	aButton := self buttonElement.
	aContent := self buttonContentElementWithFrameLayout.
	aLabel := self buttonLabelElement.

	aContent addChild: aLabel.
	aButton addChild: aContent.

	aButton viewModel: self labelModel + self buttonModel.

	self assert: aLabel text asString equals: self labelText.

	self assert: aButton children asArray equals: { aContent }.
	self assert: aContent children asArray equals: { aLabel }.

	^ aButton
]

{ #category : #'example - button' }
BrButtonLabelAptitudeExamples >> buttonWithOnlyModelAndChangedModelLabel [
	<gtExample>
	| aButton aLabel |
	
	aButton := self buttonWithOnlyModel.
	
	"we know the structure from the sub-example"
	aLabel := aButton children first children first.
	
	"changing label in the view model does not propagate to the label element"
	self flag: 'Do we need the following line?'.
	self labelModel text: self labelText, ' world'.
	self assert: aLabel text asString equals: self labelText.

	^ aButton
]

{ #category : #'example - model' }
BrButtonLabelAptitudeExamples >> changeIconOfButtonModelEvent [
	<gtExample>
	| anIconModel aButtonIcon anIconChangedEvent |

	anIconModel := self iconModel.
	aButtonIcon := ((BlEllipseGeometry new) extent: 10@10) asElement.
	
	anIconChangedEvent := nil.
	anIconModel when: BrIconChanged do: [ :anEvent | anIconChangedEvent := anEvent copy ].
	
	anIconModel icon: aButtonIcon.
	
	self assert: anIconModel icon equals: aButtonIcon.
	
	self assert: anIconChangedEvent isNotNil.
	self assert: anIconChangedEvent source equals: anIconModel.
	self assert: anIconChangedEvent target equals: anIconModel.
	self assert: anIconChangedEvent currentTarget equals: anIconModel.
	self assert: anIconChangedEvent isConsumed not.
	
	^ anIconChangedEvent
]

{ #category : #'example - model' }
BrButtonLabelAptitudeExamples >> changeLabelOfButtonModelEvent [
	<gtExample>
	| aButtonModel aButtonLabel aLabelChangedEvent |
	
	aButtonModel := self labelModel + self buttonModel.
	aButtonLabel := 'Hello glamorous world'.
	
	aLabelChangedEvent := nil.
	aButtonModel when: BrLabelChanged do: [ :anEvent | aLabelChangedEvent := anEvent copy ].
	
	aButtonModel text: aButtonLabel.
	
	self assert: aButtonModel text asString equals: aButtonLabel.
	
	self assert: aLabelChangedEvent isNotNil.
	self assert: aLabelChangedEvent source equals: aButtonModel.
	self assert: aLabelChangedEvent target equals: aButtonModel.
	self assert: aLabelChangedEvent currentTarget equals: aButtonModel.
	self assert: aLabelChangedEvent isConsumed not.
	
	^ aLabelChangedEvent
]

{ #category : #'example - events' }
BrButtonLabelAptitudeExamples >> clickOnButtonTriggersAction [
	<gtExample>
	| aButton actionTriggeredCount |

	actionTriggeredCount := 0.

	aButton := self buttonWithModelAndLookWithoutConstraints.
	aButton viewModel action: [ actionTriggeredCount := actionTriggeredCount + 1 ].
	
	BlSpace simulateClickOn: aButton.
	
	self assert: actionTriggeredCount equals: 1.
	
	^ aButton
]

{ #category : #'example - events' }
BrButtonLabelAptitudeExamples >> iconChangedEvent [
	<gtExample>
	| aButton newIcon anIconChangedEvent |

	anIconChangedEvent := nil.
	newIcon := ((BlEllipseGeometry new) extent: 10@10) asElement.

	aButton := self buttonWithModelAndLookWithoutConstraints.
	aButton aptitude when: BrIconChanged do: [ :anEvent | anIconChangedEvent := anEvent copy ].
	aButton viewModel widgetModels second icon: newIcon.
	
	self assert: aButton viewModel widgetModels second icon equals: newIcon.

	self assert: anIconChangedEvent notNil.
	self assert: anIconChangedEvent isConsumed not.
	self assert: anIconChangedEvent target equals: aButton.
	self assert: anIconChangedEvent currentTarget equals: aButton aptitude.
	self assert: anIconChangedEvent source equals: aButton viewModel widgetModels second.
	self assert: anIconChangedEvent icon equals: newIcon.
	self assert: anIconChangedEvent timestamp isNil.	

	^ anIconChangedEvent
]

{ #category : #'example - instance creation' }
BrButtonLabelAptitudeExamples >> iconModel [
	<gtExample>
	
	^ BrIconModel new
]

{ #category : #'example - events' }
BrButtonLabelAptitudeExamples >> labelChangedEvent [
	<gtExample>
	| aButton newLabel aLabelChangedEvent |

	aLabelChangedEvent := nil.
	newLabel := self labelText, ' World'.

	aButton := self buttonWithModelAndLookWithoutConstraints.
	aButton aptitude when: BrLabelChanged do: [ :anEvent | aLabelChangedEvent := anEvent copy ].
	aButton viewModel widgetModels first text: newLabel.

	self assert: aButton viewModel widgetModels first text asString equals: newLabel.

	self assert: aLabelChangedEvent notNil.
	self assert: aLabelChangedEvent isConsumed not.
	self assert: aLabelChangedEvent target equals: aButton.
	self assert: aLabelChangedEvent currentTarget equals: aButton aptitude.
	self assert: aLabelChangedEvent source equals: aButton viewModel widgetModels first.
	self assert: aLabelChangedEvent text asString equals: newLabel.
	self assert: aLabelChangedEvent timestamp isNil.

	^ aLabelChangedEvent
]

{ #category : #'example - instance creation' }
BrButtonLabelAptitudeExamples >> labelModel [
	<gtExample>
	
	^ BrLabelModel new text: self labelText
]

{ #category : #accessing }
BrButtonLabelAptitudeExamples >> labelText [
	
	^ 'Hello'
]
