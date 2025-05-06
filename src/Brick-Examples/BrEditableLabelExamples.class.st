Class {
	#name : #BrEditableLabelExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Editor'
}

{ #category : #'examples - actions' }
BrEditableLabelExamples >> acceptTextInEditorMode [
	<gtExample>
	<return: #BrEditableLabel>
	| anEditableLabel wasAccepted acceptedText |
	anEditableLabel := self editTextInEditorMode.

	wasAccepted := 0.
	acceptedText := ''.
	anEditableLabel
		when: BrEditorAcceptWish
		do: [ :aWish | 
			acceptedText := aWish text.
			wasAccepted := wasAccepted + 1 ].

	anEditableLabel acceptEdition.

	self assert: anEditableLabel viewModel model asString equals: 'edit me'.
	self assert: anEditableLabel text asString equals: 'edit me'.
	self assert: acceptedText asString equals: 'edit me'.
	self assert: wasAccepted equals: 1.
	self assert: anEditableLabel isReadOnly.

	^ anEditableLabel
]

{ #category : #'examples - actions' }
BrEditableLabelExamples >> cancelTextInEditorMode [
	<gtExample>
	<return: #BrEditableLabel>
	| anEditableLabel wasCancelled |
	anEditableLabel := self editTextInEditorMode.

	wasCancelled := 0.
	anEditableLabel
		when: BrEditorCancelWish
		do: [ wasCancelled := wasCancelled + 1 ].

	anEditableLabel cancelEdition.	"the original text is restored"
	self assert: anEditableLabel viewModel model asString equals: 'Double click me'.
	self assert: anEditableLabel text asString equals: 'Double click me'.
	self assert: wasCancelled equals: 1.
	self assert: anEditableLabel isReadOnly.

	^ anEditableLabel
]

{ #category : #'examples - actions' }
BrEditableLabelExamples >> editTextInEditorMode [
	<gtExample>
	<return: #BrEditableLabel>
	| anEditableLabel |
	anEditableLabel := self switchToEditor.

	anEditableLabel text
		deleteAll;
		append: 'edit me' asRopedText.	"the original text is stored in order to be restored if edition cancelled"
	self assert: anEditableLabel viewModel model asString equals: 'Double click me'.
	self assert: anEditableLabel text asString equals: 'edit me'.

	^ anEditableLabel
]

{ #category : #'examples - instance creation' }
BrEditableLabelExamples >> editableLabelWithGlamorousLook [
	<gtExample>
	<return: #BrEditableLabel>
	| anEditableLabel |
	anEditableLabel := BrEditableLabel new
			aptitude: BrGlamorousEditableLabelAptitude new glamorousRegularFontAndSize;
			text: 'Double click me'.

	self assert: anEditableLabel isReadOnly.
	self assert: anEditableLabel text asString equals: 'Double click me'.

	^ anEditableLabel
]

{ #category : #'examples - scripter' }
BrEditableLabelExamples >> scripter_01_initial [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := BlScripter new.
	aScripter element: self editableLabelWithGlamorousLook.

	^ aScripter
]

{ #category : #'examples - scripter' }
BrEditableLabelExamples >> scripter_02_double_click_to_edit [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripter_01_initial.
	aScripter
		substep: 'Switch to the edit mode'
		do: [ :aStep | 
			aStep
				checkStep: [ :s | 
					s
						label: 'Check read-only state';
						satisfies: [ :anEditableLabel | anEditableLabel states hasState: BrEditorModeState readOnlyWithoutSelection ] ].

			aStep doubleClick play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check edit mode';
						satisfies: [ :anEditableLabel | anEditableLabel isEditable ] ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check edit state';
						satisfies: [ :anEditableLabel | anEditableLabel states hasState: BrEditorModeState editableOnly ] ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check has focus';
						satisfies: [ :anEditableLabel | anEditableLabel isFocused ] ] ].

	^ aScripter
]

{ #category : #'examples - scripter' }
BrEditableLabelExamples >> scripter_03_press_esc_to_cancel_changes [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripter_02_double_click_to_edit.
	aScripter
		substep: 'Switch back to readonly'
		do: [ :aStep | 
			aStep
				keyPress: BlKeyboardKey escape;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check readonly mode';
						satisfies: [ :anEditableLabel | anEditableLabel isReadOnly ] ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check still has focus';
						satisfies: [ :anEditableLabel | anEditableLabel isFocused ] ] ].

	^ aScripter
]

{ #category : #'examples - actions' }
BrEditableLabelExamples >> switchToEditor [
	<gtExample>
	<return: #BrEditableLabel>
	| anEditableLabel |
	anEditableLabel := self editableLabelWithGlamorousLook.
	anEditableLabel switchToEditor.

	self assert: anEditableLabel isEditable.
	self
		assert: anEditableLabel viewModel model asString
		equals: anEditableLabel text asString.

	^ anEditableLabel
]

{ #category : #'examples - actions' }
BrEditableLabelExamples >> switchToLabelWhileInEditorMode [
	<gtExample>
	<return: #BrEditableLabel>
	| anEditableLabel |
	anEditableLabel := self editTextInEditorMode.

	anEditableLabel switchToLabel.

	self assert: anEditableLabel viewModel model asString equals: 'Double click me'.	"manual switching to label does nothing to the current text"
	self assert: anEditableLabel text asString equals: 'edit me'.
	self assert: anEditableLabel isReadOnly.

	^ anEditableLabel
]
