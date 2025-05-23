"
# Button
Use Glamorous buttons for actions in forms, popups or other views with support for multiple styles, sizes, states and more.
### Relevant documents
{{gtClass:BrButtonExamples|label=Building a custom button look}}, {{gtClass:BrButtonModelExamples|label=Learning how button model works}}, {{gtClass:BrButtonLabelAptitudeExamples|label=Playing with button label look}}
## With label
#### Default labelled button
{{gtExample:BrGlamorousComponentsButtons>>#withLabel|previewShow=#gtLiveFor:|previewHeight=65|previewExpanded=true|codeExpanded=false}}
#### Disabled labelled button
{{gtExample:BrGlamorousComponentsButtons>>#withLabelDisabled|previewShow=#gtLiveFor:|previewHeight=65|previewExpanded=true|codeExpanded=false}}
#### Labelled buttons of different size
{{gtExample:BrGlamorousComponentsButtons>>#withLabelSizes|previewShow=#gtLiveFor:|previewHeight=85|previewExpanded=true|codeExpanded=false}}

"
Class {
	#name : #BrGlamorousComponentsButtons,
	#superclass : #BrGlamorousComponents,
	#category : #'Brick-Examples-! Glamorous components'
}

{ #category : #accessing }
BrGlamorousComponentsButtons >> withLabel [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Default';
		action: [ :aButton | 'Clicked' traceCr ]
]

{ #category : #accessing }
BrGlamorousComponentsButtons >> withLabelDisabled [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Default';
		disable
]

{ #category : #accessing }
BrGlamorousComponentsButtons >> withLabelHuge [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Huge';
		beHugeSize
]

{ #category : #accessing }
BrGlamorousComponentsButtons >> withLabelLarge [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Large';
		beLargeSize
]

{ #category : #accessing }
BrGlamorousComponentsButtons >> withLabelMini [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Mini';
		beMiniSize
]

{ #category : #accessing }
BrGlamorousComponentsButtons >> withLabelNormal [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Normal';
		beNormalSize
]

{ #category : #accessing }
BrGlamorousComponentsButtons >> withLabelSizes [
	<gtExample>
	<return: #BrHorizontalPane>
	^ BrHorizontalPane new
		fitContent;
		cellSpacing: 10;
		addChildren: {self withLabelMini.
				self withLabelTiny.
				self withLabelSmall.
				self withLabelNormal.
				self withLabelLarge.
				self withLabelHuge}
]

{ #category : #accessing }
BrGlamorousComponentsButtons >> withLabelSmall [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Small';
		beSmallSize
]

{ #category : #accessing }
BrGlamorousComponentsButtons >> withLabelTiny [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Tiny';
		beTinySize
]
