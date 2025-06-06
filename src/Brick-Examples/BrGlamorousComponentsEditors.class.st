"
# Editor
Use editors to edit text.
## Basic editor
{{gtExample:BrGlamorousComponentsEditors>>#basicEditor|previewShow=#gtLiveFor:|previewHeight=100|previewExpanded=true|codeExpanded=false}}
## Input filter allowing digits only
{{gtExample:BrGlamorousComponentsEditors>>#digitsOnly|previewShow=#gtLiveFor:|previewHeight=100|previewExpanded=true|codeExpanded=false}}
## Input field
{{gtExample:BrGlamorousComponentsEditors>>#inputField|previewShow=#gtLiveFor:|previewHeight=100|previewExpanded=true|codeExpanded=false}}
## Text area
{{gtExample:BrGlamorousComponentsEditors>>#textArea|previewShow=#gtLiveFor:|previewHeight=200|previewExpanded=true|codeExpanded=false}}

"
Class {
	#name : #BrGlamorousComponentsEditors,
	#superclass : #BrGlamorousComponents,
	#category : #'Brick-Examples-! Glamorous components'
}

{ #category : #examples }
BrGlamorousComponentsEditors >> basicEditor [
	<gtExample>
	<return: #BrEditor>
	^ BrEditor new
		aptitude: BrGlamorousEditorAptitude;
		text: String loremIpsum
]

{ #category : #examples }
BrGlamorousComponentsEditors >> digitsOnly [
	<gtExample>
	<return: #BrEditor>
	^ BrEditor new
		aptitude: BrGlamorousEditorAptitude + BrGlamorousInputFieldSpacingAptitude;
		inputFilter: BrTextEditorDigitInputFilter new;
		text: '42';
		fitContent
]

{ #category : #examples }
BrGlamorousComponentsEditors >> inputField [
	<gtExample>
	<return: #BrEditor>
	^ BrEditor new
		aptitude: BrGlamorousEditorAptitude + BrGlamorousInputFieldSpacingAptitude;
		text: (String loremIpsum: 20) trimBoth;
		fitContent
]

{ #category : #examples }
BrGlamorousComponentsEditors >> textArea [
	<gtExample>
	<return: #BrEditor>
	^ BrEditor new
		aptitude: BrGlamorousEditorAptitude + BrGlamorousTextAreaSpacingAptitude;
		text: String loremIpsum
]
