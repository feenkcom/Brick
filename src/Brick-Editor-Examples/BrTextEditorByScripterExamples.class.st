Class {
	#name : #BrTextEditorByScripterExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples-By scripter'
}

{ #category : #'click - adornment element' }
BrTextEditorByScripterExamples >> click_adornment_element [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithElement.
	aScripter
		doStep: [ :s | 
			s
				action: [ :aBrEditor | aBrEditor text: self textWithAdornment ];
				onSelf ].

	aScripter
		clickStep: [ :s | 
			s
				id: #adornment ].

	aScripter
		checkStep: [ :s | 
			s
				value: [ :aBrTextEditor | aBrTextEditor cursors positions ] equals: #();
				onBrTextEditor ].

	aScripter
		checkStep: [ :s | 
			s
				satisfies: [ :aBrEditor | aBrEditor isFocused not ];
				onSelf ].

	^ aScripter
]

{ #category : #'click - empty' }
BrTextEditorByScripterExamples >> click_empty [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithElement.

	aScripter
		clickStep: [ :s | 
			s
				onSelf ].

	aScripter
		checkStep: [ :s | 
			s
				value: [ :aBrTextEditor | aBrTextEditor cursors positions ] equals: #(0);
				onBrTextEditor ].

	aScripter
		checkStep: [ :s | 
			s
				satisfies: [ :aBrEditor | aBrEditor isFocused ];
				onSelf ].

	^ aScripter
]

{ #category : #'instance creation' }
BrTextEditorByScripterExamples >> scripter [
	<gtExample>
	
	^ BlScripter new
]

{ #category : #'instance creation' }
BrTextEditorByScripterExamples >> scripterElement [
	<gtExample>

	^ BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude + BrGlamorousTextAreaSpacingAptitude;
		matchParent;
		text: '' asRopedText
]

{ #category : #'instance creation' }
BrTextEditorByScripterExamples >> scripterWithElement [
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter element: self scripterElement.

	aScripter
		checkStep: [ :s | 
			s
				value: [ :aBrTextEditor | aBrTextEditor cursors positions ] equals: #();
				onBrTextEditor ].

	aScripter
		checkStep: [ :s | 
			s
				satisfies: [ :aBrEditor | aBrEditor isFocused not ];
				onSelf ].

	^ aScripter
]

{ #category : #'click - adornment element' }
BrTextEditorByScripterExamples >> textWithAdornment [
	<gtExample>

	^ 'Hello world
Next line with ' asRopedText, ('adornment' asRopedText appendingAdornment: [
	BlElement new
		size: 200@100;
		background: (Color gray alpha: 0.2);
		id: #adornment ]), ' element' asRopedText
]
