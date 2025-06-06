"
# Checkbox
{{gtClass:BrCheckbox|label=Checkbox}} permits the user to make a binary choice, i.e. a choice between one of two possible mutually exclusive options. If needed it is possible to use checkboxes that allow an indeterminate state in addition to the two provided by a normal checkbox. See {{gtClass:BrCustomCheckboxLookHowToGuide|label=How to build a custom checkbox look}}
#### Unchecked
{{gtExample:BrGlamorousComponentsCheckboxes>>#unchecked|previewShow=#gtLiveFor:|previewHeight=60|previewExpanded=true|codeExpanded=false}}
#### Checked
{{gtExample:BrGlamorousComponentsCheckboxes>>#checked|previewShow=#gtLiveFor:|previewHeight=60|previewExpanded=true|codeExpanded=false}}
#### Indeterminate
{{gtExample:BrGlamorousComponentsCheckboxes>>#indeterminate|previewShow=#gtLiveFor:|previewHeight=60|previewExpanded=true|codeExpanded=false}}

"
Class {
	#name : #BrGlamorousComponentsCheckboxes,
	#superclass : #BrGlamorousComponents,
	#category : #'Brick-Examples-! Glamorous components'
}

{ #category : #'instance creation' }
BrGlamorousComponentsCheckboxes >> checked [
	<gtExample>
	<return: #BrCheckbox>
	^ BrCheckbox new
		aptitude: BrGlamorousCheckboxAptitude;
		check
]

{ #category : #'instance creation' }
BrGlamorousComponentsCheckboxes >> indeterminate [
	<gtExample>
	<return: #BrCheckbox>
	^ BrCheckbox new
		aptitude: BrGlamorousCheckboxAptitude;
		indeterminate
]

{ #category : #'instance creation' }
BrGlamorousComponentsCheckboxes >> unchecked [
	<gtExample>
	<return: #BrCheckbox>
	^ BrCheckbox new
		aptitude: BrGlamorousCheckboxAptitude;
		uncheck
]
