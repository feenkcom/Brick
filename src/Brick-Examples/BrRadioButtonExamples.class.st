"
I demonstrate radio buttons sharing BrAbstractToggle activation and BrToggleGroup coordination, without BrToggle label or icon models.
"
Class {
	#name : #BrRadioButtonExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Radio'
}

{ #category : #examples }
BrRadioButtonExamples >> addingCheckedMember [
	<gtExample>
	| group radio |
	group := self groupSelection.
	radio := self checkedRadioButtonWithLook.
	group addToggle: radio.
	self assert: group activatedToggle == radio.
	self assert: (group viewModel toggles count: #isActivated) equals: 1.
	^ group
]

{ #category : #examples }
BrRadioButtonExamples >> checkedRadioButton [
	<gtExample>
	| radio |
	radio := self radioButton.
	radio check.
	self assert: radio isActivated.
	self assert: radio isChecked.
	^ radio
]

{ #category : #examples }
BrRadioButtonExamples >> checkedRadioButtonWithLook [
	<gtExample>
	^ self checkedRadioButton aptitude: BrGlamorousRadioButtonAptitude
]

{ #category : #examples }
BrRadioButtonExamples >> checkedSetterAndNotifications [
	<gtExample>
	| radio checkedCount uncheckedCount |
	radio := self radioButton.
	checkedCount := 0.
	uncheckedCount := 0.
	radio
		whenCheckedDo: [ :event | 
			self assert: event class equals: BrToggleActivatedEvent.
			checkedCount := checkedCount + 1 ].
	radio whenUncheckedDo: [ uncheckedCount := uncheckedCount + 1 ].
	radio checked: true.
	radio check.
	self assert: checkedCount equals: 1.
	radio checked: false.
	self assert: radio isUnchecked.
	self assert: uncheckedCount equals: 1.
	^ radio
]

{ #category : #examples }
BrRadioButtonExamples >> clickEventProvenance [
	<gtExample>
	| radio click original |
	radio := self radioButtonWithLook.
	click := BlClickEvent new.
	radio viewModel
		when: BrToggleActivatedEvent
		do: [ :event | original := event originalEvent ].
	radio dispatchEvent: click.
	self assert: original == click.
	^ radio
]

{ #category : #examples }
BrRadioButtonExamples >> clickSelects [
	<gtExample>
	| radio |
	radio := self radioButtonWithLook.
	radio dispatchEvent: BlClickEvent new.
	self assert: radio isActivated.
	^ radio
]

{ #category : #examples }
BrRadioButtonExamples >> disabledClickDoesNotSelect [
	<gtExample>
	| radio |
	radio := self radioButtonWithLook.
	radio disable.
	radio dispatchEvent: BlClickEvent new.
	self assert: radio isUnchecked.
	^ radio
]

{ #category : #examples }
BrRadioButtonExamples >> groupClickSelection [
	<gtExample>
	| group first second |
	group := self groupSelection.
	first := group children first.
	second := group children second.
	first dispatchEvent: BlClickEvent new.
	self assert: first isChecked.
	self assert: second isUnchecked.
	self assert: group activatedToggle == first.
	^ group
]

{ #category : #examples }
BrRadioButtonExamples >> groupSelection [
	<gtExample>
	| group first second |
	group := BrRadioButtonGroup new.
	self assert: group viewModel class equals: BrToggleGroupModel.
	first := self checkedRadioButtonWithLook.
	second := self radioButtonWithLook.
	group
		addToggles: {first.
				second}.
	second activate.
	self assert: first isUnchecked.
	self assert: second isChecked.
	self assert: group activatedToggle == second.
	self assert: first parent == group.
	self assert: second parent == group.
	^ group
]

{ #category : #examples }
BrRadioButtonExamples >> groupSelectionEvents [
	<gtExample>
	| group activated deactivated first |
	group := self groupSelection.
	activated := OrderedCollection new.
	deactivated := OrderedCollection new.
	group viewModel
		when: BrToggleActivatedEvent
		do: [ :event | activated add: event toggle ].
	group viewModel
		when: BrToggleDeactivatedEvent
		do: [ :event | deactivated add: event toggle ].
	first := group children first.
	first activate.
	self assert: activated asArray equals: {first viewModel}.
	self assert: deactivated size equals: 1.
	self assert: group activatedToggle == first.
	^ group
]

{ #category : #examples }
BrRadioButtonExamples >> groupWithLook [
	<gtExample>
	^ self groupSelection
		aptitude: BrGlamorousToggleGroupAptitude new + BrLayoutAlignmentAptitude new;
		yourself
]

{ #category : #examples }
BrRadioButtonExamples >> independentGroups [
	<gtExample>
	| firstGroup secondGroup |
	firstGroup := self groupSelection.
	secondGroup := self groupSelection.
	firstGroup children first check.
	self assert: firstGroup children first isChecked.
	self assert: secondGroup children second isChecked.
	^ firstGroup
]

{ #category : #examples }
BrRadioButtonExamples >> modelsWithoutWidgets [
	<gtExample>
	| group first second |
	group := BrToggleGroupModel new.
	first := BrToggleModel new beOneWay.
	second := BrToggleModel new beOneWay.
	group
		addToggles: {first.
				second}.
	first activate.
	second activate.
	self assert: group isAttachedToWidget not.
	self assert: group activatedToggle == second.
	self assert: first isActivated not.
	self assert: second isActivated.
	group removeToggle: second.
	self assert: group hasActivatedToggle not.
	self assert: second isActivated not.
	^ group
]

{ #category : #examples }
BrRadioButtonExamples >> normalToggleStillToggles [
	<gtExample>
	| toggle |
	toggle := BrToggle new.
	self assert: toggle viewModel isOneWay not.
	toggle dispatchEvent: BlClickEvent new.
	self assert: toggle isActivated.
	toggle dispatchEvent: BlClickEvent new.
	self assert: toggle isActivated not.
	^ toggle
]

{ #category : #examples }
BrRadioButtonExamples >> radioButton [
	<gtExample>
	| radio |
	radio := BrRadioButton new.
	self assert: radio viewModel class equals: BrToggleModel.
	self assert: radio viewModel children isEmpty.
	self assert: (radio viewModel hasActorOfKind: BrLabelModel) not.
	self assert: (radio viewModel hasActorOfKind: BrIconModel) not.
	self assert: radio viewModel isOneWay.
	self assert: radio isUnchecked.
	^ radio
]

{ #category : #examples }
BrRadioButtonExamples >> radioButtonWithLook [
	<gtExample>
	^ self radioButton aptitude: BrGlamorousRadioButtonAptitude
]

{ #category : #examples }
BrRadioButtonExamples >> removingMembers [
	<gtExample>
	| group radio |
	group := self groupSelection.
	radio := group activatedToggle.
	group removeToggles.
	self assert: group children isEmpty.
	self assert: group viewModel isEmpty.
	self assert: group viewModel hasActivatedToggle not.
	self assert: radio isUnchecked.
	self assert: radio parent isNil.
	^ group
]

{ #category : #examples }
BrRadioButtonExamples >> repeatedClickStaysChecked [
	<gtExample>
	| radio |
	radio := self clickSelects.
	radio dispatchEvent: BlClickEvent new.
	self assert: radio isActivated.
	^ radio
]

{ #category : #examples }
BrRadioButtonExamples >> smallRadioButtonWithLook [
	<gtExample>
	^ self checkedRadioButtonWithLook beSmallSize
]
