Class {
	#name : #BrEditorExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Editor'
}

{ #category : #'examples - modes' }
BrEditorExamples >> editableEditorWithGlamorousRegularLook [
	<gtExample>
	<return: #BrEditor>
	^ BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude new;
		beEditable;
		text: String loremIpsum
]

{ #category : #accessing }
BrEditorExamples >> editorClickToFocus [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := BlScripter new.
	aScripter
		element: (BrEditor new
				aptitude: BrGlamorousEditorAptitude + BrGlamorousTextAreaSpacingAptitude;
				text: 'Hello';
				fitContent).

	aScripter
		assertStep: [ :s | s satisfies: [ :anEditor | anEditor hasFocus not ] ].

	aScripter click play.

	aScripter assertStep: [ :s | s satisfies: [ :anEditor | anEditor hasFocus ] ].

	^ aScripter
]

{ #category : #'examples - input filter' }
BrEditorExamples >> editorWithAlphaNumericFilter [
	<gtExample>
	<return: #BrEditor>
	^ BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude + BrGlamorousEditorSpacingAptitude;
		inputFilter: BrTextEditorAlphaNumericInputFilter new;
		vFitContent;
		text: 'Only alpha-numeric chatacters are allowed'
]

{ #category : #'examples - input filter' }
BrEditorExamples >> editorWithDigitFilter [
	<gtExample>
	<return: #BrEditor>
	^ BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude + BrGlamorousEditorSpacingAptitude;
		inputFilter: BrTextEditorDigitInputFilter new;
		vFitContent;
		text: 'Only digits are allowed'
]

{ #category : #examples }
BrEditorExamples >> editorWithGlamorousRegularLook [
	<gtExample>
	<return: #BrEditor>
	^ BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude new;
		text: String loremIpsum
]

{ #category : #'examples - modes look' }
BrEditorExamples >> editorWithGlamorousRegularLookAndModeLook [
	<gtExample>
	<return: #BrHorizontalPane>
	| aModeLook anEditor |
	aModeLook := BrEditorModeAptitude new
			editableFocused: [ :aWidget | 
				aWidget
					border: (BlBorder paint: BrGlamorousColors focusedEditorBorderColor width: 1) ];
			editableUnfocused: [ :aWidget | aWidget border: (BlBorder paint: BrGlamorousColors editorBorderColor width: 1) ];
			readOnly: [ :aWidget | aWidget border: BlBorder empty ].

	anEditor := BrEditor new
			aptitude: BrGlamorousRegularEditorAptitude new + aModeLook;
			text: String loremIpsum;
			vFitContent.

	^ BrHorizontalPane new
		cellSpacing: 5;
		hMatchParent;
		vFitContent;
		addChildren: {anEditor.
				BrVerticalPane new
					fitContent;
					cellSpacing: 5;
					addChildren: {BrButton new
								aptitude: BrGlamorousButtonWithLabelAptitude new;
								label: 'Editable';
								action: [ anEditor beEditable ].
							BrButton new
								aptitude: BrGlamorousButtonWithLabelAptitude new;
								label: 'Readonly with selection';
								action: [ anEditor beReadOnlyWithSelection ].
							BrButton new
								aptitude: BrGlamorousButtonWithLabelAptitude new;
								label: 'Readonly without selection';
								action: [ anEditor beReadOnlyWithoutSelection ]}}
]

{ #category : #'examples - input filter' }
BrEditorExamples >> editorWithNoFilter [
	<gtExample>
	<return: #BrEditor>
	^ BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude + BrGlamorousEditorSpacingAptitude;
		inputFilter: BrTextEditorNoInputFilter new;
		vFitContent;
		text: 'All characters are allowed'
]

{ #category : #'examples - modes' }
BrEditorExamples >> readOnlyWithSelectionEditorWithGlamorousRegularLook [
	<gtExample>
	<return: #BrEditor>
	^ BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude new;
		beReadOnlyWithSelection;
		text: String loremIpsum
]

{ #category : #'examples - modes' }
BrEditorExamples >> readOnlyWithoutSelectionEditorWithGlamorousRegularLook [
	<gtExample>
	<return: #BrEditor>
	^ BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude new;
		beReadOnlyWithoutSelection;
		text: String loremIpsum
]

{ #category : #accessing }
BrEditorExamples >> scrollingLongText [
	<gtExample>
	<return: #BlScripter>
	| aScripter text editor |
	aScripter := BlScripter new.
	text := (String
			streamContents: [ :stream | 
				1
					to: 100000
					do: [ :i | 
						i
							printOn: stream
							base: 10
							nDigits: 9.
						stream cr ] ]) asRopedText.
	editor := BrEditor new.
	editor editor text: text.
	aScripter element: editor.
	aScripter
		doStep: [ :s | 
			s
				label: 'Initial scroll';
				block: [ :el | el scrollToPosition: 51111 ] ].
	aScripter
		doStep: [ :s | 
			s
				label: 'Scroll to end';
				block: [ :el | el scrollToPosition: 99999 ] ].
	^ aScripter
]

{ #category : #accessing }
BrEditorExamples >> wrappedEditorClickToFocus [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := BlScripter new.
	aScripter
		element: (BrFrame new
				fitContent;
				when: BlClickEvent do: [ :anEvent | anEvent currentTarget requestFocus ];
				addChild: (BrEditor new
						aptitude: BrGlamorousEditorAptitude + BrGlamorousTextAreaSpacingAptitude;
						text: 'Hello';
						fitContent;
						id: #editor)).

	aScripter
		assertStep: [ :s | 
			s
				// #editor;
				satisfies: [ :anEditor | anEditor hasFocus not ] ].

	aScripter clickStep: [ :s | s // #editor ].

	aScripter
		assertStep: [ :s | 
			s
				// #editor;
				satisfies: [ :anEditor | anEditor hasFocus ] ].

	^ aScripter
]
