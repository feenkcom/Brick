"
# Accordion

The accordion is a graphical control element that can be ""expanded"" or ""collapsed"" to reveal the content associated with that element. 

By default an accordion is collapsed:
{{gtExample:name=BrAccordionExamples>>#glamorousWithEditor|noCode|previewShow=#gtLiveFor:|previewHeight=140}}
and users are required to click on the header to expand it:
{{gtExample:name=BrAccordionExamples>>#glamorousWithEditorExpanded|noCode|previewShow=#gtLiveFor:|previewHeight=140}}
the color of the vertical bar on the left side changes when the accordion receives keyboard focus:
{{gtExample:name=BrAccordionExamples>>#glamorousWithEditorExpandedWithFocus|noCode|previewShow=#gtLiveFor:|previewHeight=140}}

## Resizing

"
Class {
	#name : #BrAccordionExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Accordion'
}

{ #category : #examples }
BrAccordionExamples >> glamorousWithEditor [
	<gtExample>
	<return: #BrAccordion>
	| anAccordion |
	anAccordion := BrAccordion new.
	anAccordion
		hMatchParent;
		vFitContent.

	anAccordion aptitude: BrGlamorousAccordionAptitude new.
	anAccordion
		header: [ BrButton new
				aptitude: BrGlamorousAccordionHeaderAptitude new;
				label: 'Click to expand/collapse';
				action: [ anAccordion toggle ] ].
	anAccordion
		content: [ BrEditor new
				aptitude: BrGlamorousEditorAptitude new;
				text: (String loremIpsum: 200) trimBoth ].

	^ anAccordion
]

{ #category : #examples }
BrAccordionExamples >> glamorousWithEditorExpanded [
	<gtExample>
	<return: #BrAccordion>
	| anAccordion |
	anAccordion := self glamorousWithEditor.
	anAccordion expand.

	^ anAccordion
]

{ #category : #examples }
BrAccordionExamples >> glamorousWithEditorExpandedWithFocus [
	<gtExample>
	<return: #BrAccordion>
	| anAccordion |
	anAccordion := self glamorousWithEditorExpanded.
	anAccordion requestFocus.

	^ anAccordion
]
