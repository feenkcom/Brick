"
!Editor
Use editors to edit text.
!!Basic editor
${example:BrGlamorousComponentsEditors>>#basicEditor|previewShow=#gtLiveFor:|previewHeight=100|previewExpanded=true|codeExpanded=false}$
!!Input filter allowing digits only
${example:BrGlamorousComponentsEditors>>#digitsOnly|previewShow=#gtLiveFor:|previewHeight=100|previewExpanded=true|codeExpanded=false}$
!!Input field
${example:BrGlamorousComponentsEditors>>#inputField|previewShow=#gtLiveFor:|previewHeight=100|previewExpanded=true|codeExpanded=false}$
!!Text area
${example:BrGlamorousComponentsEditors>>#textArea|previewShow=#gtLiveFor:|previewHeight=200|previewExpanded=true|codeExpanded=false}$
"
Class {
	#name : 'BrGlamorousComponentsEditors',
	#superclass : 'BrGlamorousComponents',
	#category : 'Brick-Examples-! Glamorous components'
}

{ #category : 'examples' }
BrGlamorousComponentsEditors >> basicEditor [
	<gtExample>

	^ BrEditor new
		aptitude: BrGlamorousEditorAptitude;
		text: String loremIpsum
]

{ #category : 'examples' }
BrGlamorousComponentsEditors >> digitsOnly [
	<gtExample>

	^ BrEditor new
		aptitude: BrGlamorousEditorAptitude + BrGlamorousInputFieldSpacingAptitude;
		inputFilter: BrTextEditorDigitInputFilter new;
		text: '42';
		fitContent
]

{ #category : 'examples' }
BrGlamorousComponentsEditors >> inputField [
	<gtExample>

	^ BrEditor new
		aptitude: BrGlamorousEditorAptitude + BrGlamorousInputFieldSpacingAptitude;
		text: (String loremIpsum: 20) trimBoth;
		fitContent
]

{ #category : 'examples' }
BrGlamorousComponentsEditors >> textArea [
	<gtExample>

	^ BrEditor new
		aptitude: BrGlamorousEditorAptitude + BrGlamorousTextAreaSpacingAptitude;
		text: String loremIpsum
]
