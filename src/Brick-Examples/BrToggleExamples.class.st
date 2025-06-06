"
## Playing with looks 

Let's take a look at a toggle button as an example. A toggle button is made of an element and an associated view model. To have it drawn on the screen, we add a look to it, such as an icon:
{{gtExample:BrToggleExamples>>#toogleWithMaterialIcon|previewExpanded}}

Or a label:
{{gtExample:BrToggleExamples>>#toogleWithMaterialLabel|previewExpanded}}

The icon and the label can also be combined:
{{gtExample:BrToggleExamples>>#toggleWithMaterialIconAndLabel|previewExpanded}}

Changing the order of composition can also affect the rendering. In this case, the icon appears to the right of the label:
{{gtExample:BrToggleExamples>>#toggleWithMaterialLabelAndIcon|previewExpanded}}

But, looks can also influence the behavior of a widget. For example, to change the icon depending of the state of the toggle, we simply make hte look listen to the toggle event and change the icon from the view model:
{{gtExample:BrToggleExamples>>#toggleWithMaterialChangingIcon|previewExpanded}}


"
Class {
	#name : #BrToggleExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Toggle'
}

{ #category : #'examples - toggle' }
BrToggleExamples >> activatePredefinedToggle [
	<gtExample>
	<return: #BrToggle>
	| aToggle |
	aToggle := self predefinedToggle.
	aToggle activate.

	self assert: aToggle isActivated.

	^ aToggle
]

{ #category : #'examples - toggle' }
BrToggleExamples >> changeIconOfThePredefinedToggle [
	<gtExample>
	<return: #BrToggle>
	| aToggle anIcon |
	aToggle := self predefinedToggle.
	anIcon := (BlEllipseGeometry new extent: 10 @ 10) asElement.

	aToggle icon: anIcon.
	self assert: aToggle icon equals: anIcon.

	^ aToggle
]

{ #category : #'examples - toggle' }
BrToggleExamples >> changeLabelOfThePredefinedToggle [
	<gtExample>
	<return: #BrToggle>
	| aToggle aLabel |
	aToggle := self predefinedToggle.
	aLabel := 'Hello world'.

	aToggle label: aLabel.
	self assert: aToggle label asString equals: aLabel.

	^ aToggle
]

{ #category : #'instance creation' }
BrToggleExamples >> circleIcon [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		size: 6 @ 6;
		background: Color red;
		geometry: BlEllipseGeometry new;
		margin: (BlInsets all: 3)
]

{ #category : #'examples - click' }
BrToggleExamples >> clickOnActivatedPredefinedToggle [
	<gtExample>
	<return: #BrToggleDeactivatedEvent>
	| aToggleElement aToggleModel aToggleDeactivatedEvent |
	aToggleElement := self activatePredefinedToggle.
	aToggleModel := aToggleElement viewModel.

	aToggleDeactivatedEvent := nil.
	aToggleElement
		when: BrToggleDeactivatedEvent
		do: [ :anEvent | aToggleDeactivatedEvent := anEvent copy ].

	BlSpace simulateClickOn: aToggleElement.

	self assert: aToggleElement isActivated not.
	self assert: aToggleModel isActivated not.

	self assert: aToggleDeactivatedEvent isNotNil.
	self assert: aToggleDeactivatedEvent source equals: aToggleModel.
	self assert: aToggleDeactivatedEvent target equals: aToggleElement.
	self assert: aToggleDeactivatedEvent currentTarget equals: aToggleElement.
	self assert: aToggleDeactivatedEvent isConsumed not.

	self assert: aToggleDeactivatedEvent toggle equals: aToggleModel.

	^ aToggleDeactivatedEvent
]

{ #category : #'examples - click' }
BrToggleExamples >> clickOnDeactivatedPredefinedToggle [
	<gtExample>
	<return: #BrToggleActivatedEvent>
	| aToggleElement aToggleModel aToggleActivatedEvent |
	aToggleElement := self deactivatePredefinedToggle.
	aToggleModel := aToggleElement viewModel.

	aToggleActivatedEvent := nil.
	aToggleElement
		when: BrToggleActivatedEvent
		do: [ :anEvent | aToggleActivatedEvent := anEvent copy ].

	BlSpace simulateClickOn: aToggleElement.

	self assert: aToggleElement isActivated.
	self assert: aToggleModel isActivated.

	self assert: aToggleActivatedEvent isNotNil.
	self assert: aToggleActivatedEvent source equals: aToggleModel.
	self assert: aToggleActivatedEvent target equals: aToggleElement.
	self assert: aToggleActivatedEvent currentTarget equals: aToggleElement.
	self assert: aToggleActivatedEvent isConsumed not.

	self assert: aToggleActivatedEvent toggle equals: aToggleModel.

	^ aToggleActivatedEvent
]

{ #category : #'examples - toggle' }
BrToggleExamples >> deactivatePredefinedToggle [
	<gtExample>
	<return: #BrToggle>
	| aToggle |
	aToggle := self activatePredefinedToggle.
	aToggle deactivate.

	self assert: aToggle isActivated not.

	^ aToggle
]

{ #category : #'examples - toggle' }
BrToggleExamples >> predefinedToggle [
	<gtExample>
	<return: #BrToggle>
	| aToggle |
	aToggle := BrToggle new.
	aToggle aptitude: BrIconAptitude + BrTextLabelAptitude + BrToggleAptitude.
	aToggle layout: BlLinearLayout horizontal.
	aToggle
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].

	self assert: aToggle isActivated not.

	^ aToggle
]

{ #category : #'examples - toggle' }
BrToggleExamples >> setActivatedOfPredefinedToggle [
	<gtExample>
	<return: #BrToggle>
	| aToggle |
	aToggle := self predefinedToggle.
	aToggle activated: true.

	self assert: aToggle isActivated.

	^ aToggle
]

{ #category : #'examples - toggle' }
BrToggleExamples >> setDeactivatedOfPredefinedToggle [
	<gtExample>
	<return: #BrToggle>
	| aToggle |
	aToggle := self activatePredefinedToggle.
	aToggle activated: false.

	self assert: aToggle isActivated not.

	^ aToggle
]

{ #category : #'instance creation' }
BrToggleExamples >> squareIcon [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		size: 6 @ 6;
		background: Color blue;
		margin: (BlInsets all: 3)
]

{ #category : #'examples - toggle' }
BrToggleExamples >> toggleActivatedPredefinedToggle [
	<gtExample>
	<return: #BrToggle>
	| aToggle |
	aToggle := self activatePredefinedToggle.
	aToggle toggle.

	self assert: aToggle isActivated not.

	^ aToggle
]

{ #category : #'instance creation' }
BrToggleExamples >> toggleButton [
	<gtExample>
	<return: #BrToggle>
	^ BrToggle new relocate: 10 @ 10
]

{ #category : #'instance creation' }
BrToggleExamples >> toggleButtonIcon [
	<gtExample>
	<return: #BlElement>
	^ self circleIcon background: Color red
]

{ #category : #'examples - toggle' }
BrToggleExamples >> toggleDeactivatedPredefinedToggle [
	<gtExample>
	<return: #BrToggle>
	| aToggle |
	aToggle := self deactivatePredefinedToggle.
	aToggle toggle.

	self assert: aToggle isActivated.

	^ aToggle
]

{ #category : #'instance creation' }
BrToggleExamples >> toggleModel [
	<gtExample>
	<return: #BrToggleModel>
	^ BrToggleModel new
]

{ #category : #'examples - material' }
BrToggleExamples >> toggleWithMaterialChangingIcon [
	<gtExample>
	<return: #BrToggle>
	^ self toggleButton
		aptitude: BrMaterialToggleLabelledAptitude + BrMaterialToggleIconifiedAptitude;
		when: BrToggleActivatedEvent
			do: [ :anEvent | anEvent currentTarget icon: self squareIcon ];
		when: BrToggleDeactivatedEvent
			do: [ :anEvent | anEvent currentTarget icon: self circleIcon ]
]

{ #category : #'examples - material' }
BrToggleExamples >> toggleWithMaterialIconAndLabel [
	<gtExample>
	<return: #BrToggle>
	^ self toggleButton
		aptitude: BrMaterialToggleIconifiedAptitude + BrMaterialToggleLabelledAptitude;
		icon: self toggleButtonIcon
]

{ #category : #'examples - material' }
BrToggleExamples >> toggleWithMaterialLabelAndIcon [
	<gtExample>
	<return: #BrToggle>
	^ self toggleButton
		aptitude: BrMaterialToggleLabelledAptitude + BrMaterialToggleIconifiedAptitude;
		icon: self toggleButtonIcon
]

{ #category : #'examples - material' }
BrToggleExamples >> toogleWithMaterialIcon [
	<gtExample>
	<return: #BrToggle>
	^ self toggleButton
		aptitude: BrMaterialToggleIconifiedAptitude new;
		icon: self toggleButtonIcon
]

{ #category : #'examples - material' }
BrToggleExamples >> toogleWithMaterialLabel [
	<gtExample>
	<return: #BrToggle>
	^ self toggleButton aptitude: BrMaterialToggleLabelledAptitude new
]
