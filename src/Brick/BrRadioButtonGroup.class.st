"
I am a BrToggleGroup for radio buttons. My inherited BrToggleGroupModel coordinates member models and emits membership and selection events. Add buttons with addToggle: or addToggles:. Removing members follows ToggleGroup deactivation semantics.
"
Class {
	#name : #BrRadioButtonGroup,
	#superclass : #BrToggleGroup,
	#instVars : [
		'radioButtons'
	],
	#category : #'Brick-Radio - UI'
}

{ #category : #'gt - views' }
BrRadioButtonGroup >> gtMembersFor: aView [
	"Which of my radio buttons is selected?"

	<gtView>
	^ aView columnedList
		title: 'Selection';
		priority: 5;
		items: [ self viewModel toggles ];
		column: 'Button' text: [ :each | self viewModel indexOf: each ];
		column: 'Selected' text: #isActivated;
		send: #widget
]
