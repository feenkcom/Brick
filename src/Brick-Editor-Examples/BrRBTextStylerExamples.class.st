Class {
	#name : #BrRBTextStylerExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples-Styler'
}

{ #category : #accessing }
BrRBTextStylerExamples >> expectedStyledTextForMethodWithExplicitClass [
	| text  |
	text := (BrDummyObjectForTextStyling>>#methodOne:) 
		sourceCode asRopedText.
	
	{ 1->11 . 15->16. 24->29 . 31->31 . 33->41 } do: [ :each |	
		(text from: each key to: each value)
			foreground: Color black].

	text
		attributes: {BlFontEmphasisAttribute normal}.
		
	(text from: 1 to: 10)
		attributes: {BlFontWeightAttribute bold}.
		
	{ 12->14 . 30->30. 32->32 . 42->44 . } do: [ :each |	
		(text from: each key to: each value)
			foreground: (Color blue muchDarker)].
			
	(text from: 17 to: 23)
		attributes: {BlTextVariableLink new}.
		
	(text from: 17 to: 23)
		foreground: Color blue muchDarker.
		
	(text from: 35 to: 40)
		attributes: {BlTextMethodLink new}.
		
	^ text
]

{ #category : #accessing }
BrRBTextStylerExamples >> expectedStyledTextForMethodWithNoExplicitClass [
	| text  |
	text := (BrDummyObjectForTextStyling>>#methodOne:) 
		sourceCode asRopedText.
	
	{ 1->11 . 15->16. 24->29 . 31->31 . 33->41 } do: [ :each |	
		(text from: each key to: each value)
			foreground: Color black].

	text
		attributes: {BlFontEmphasisAttribute normal}.
		
	(text from: 1 to: 10)
		attributes: {BlFontWeightAttribute bold}.
		
	{ 12->14 . 30->30. 32->32 . 42->44 . } do: [ :each |	
		(text from: each key to: each value)
			foreground: (Color blue muchDarker)].
			
	(text from: 17 to: 23)
		attributes: {BlTextVariableLink new}.
		
	(text from: 17 to: 23)
		foreground: Color veryDarkGray.
		
	(text from: 35 to: 40)
		attributes: {BlTextMethodLink new}.
		
	^ text
]

{ #category : #utils }
BrRBTextStylerExamples >> extractIntervalsFrom: aText [
	| runsGroup currentIntervals |

	runsGroup := GtPhlowRunsGroup new.
	
	currentIntervals := aText
		gtIntervalsFrom: 1
		to: aText size
		ignoring: #().
	[ currentIntervals notEmpty ] whileTrue: [ 
		| currentInterval |
		currentInterval := currentIntervals removeFirst.
		runsGroup addRun: (GtPhlowRun  
		 	from: currentInterval first
		 	to: currentInterval second
		 	attributes: (currentInterval third 
		 		collect: [ :anAttribute |
		 			anAttribute  ]
		 		as: Array ) ).
		 currentIntervals addAll: (aText
			gtIntervalsFrom: currentInterval first
			to: currentInterval second
			ignoring: currentInterval third , currentInterval last) ].

	^ runsGroup reject: [ :aRunWithAttributes |
		aRunWithAttributes attributes isEmpty ] 
]

{ #category : #examples }
BrRBTextStylerExamples >> styledMethodWithExplicitClass [
	<gtExample>
	| unstyledText styledText styler |
	
	unstyledText := (BrDummyObjectForTextStyling >> #methodOne:) sourceCode
			asRopedText.
			
	styler := self testStylerWithExplicitClass.
	styledText := styler style: unstyledText.	
	
	self 
		assert: (self extractIntervalsFrom: styledText)  items
		equals:(self 
			extractIntervalsFrom:  self expectedStyledTextForMethodWithExplicitClass) items. 

	^ styledText
]

{ #category : #examples }
BrRBTextStylerExamples >> styledMethodWithNoExplicitClass [
	<gtExample>
	| unstyledText styledText styler |
	
	unstyledText := (BrDummyObjectForTextStyling >> #methodOne:) sourceCode
			asRopedText.
			
	styler := self testStylerWithNoExplicitClass.
	styledText := styler style: unstyledText.	
	
	self 
		assert: (self extractIntervalsFrom: styledText)  items
		equals:(self 
			extractIntervalsFrom: self 
				expectedStyledTextForMethodWithNoExplicitClass) items. 

	^ styledText
]

{ #category : #examples }
BrRBTextStylerExamples >> testStylerWithExplicitClass [
	<gtExample>
	| styler |
	
	styler := GtCodeDiffRBTextStyler new 
		classOrMetaClass: BrDummyObjectForTextStyling.
	
	self assert: styler isScripting not.
	self assert: styler isForWorkspace not.
	
	^ styler 
]

{ #category : #examples }
BrRBTextStylerExamples >> testStylerWithNoExplicitClass [
	<gtExample>
	| styler |
	
	styler := GtCodeDiffRBTextStyler new.
	
	self assert: styler isScripting not.
	self assert: styler isForWorkspace not.
	
	^ styler 
]
