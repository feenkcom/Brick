Class {
	#name : #BrCheckboxExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Checkbox'
}

{ #category : #'form-scripting' }
BrCheckboxExamples >> checkbox [
	<gtExample>
	<return: #BrCheckbox>
	| checkbox |
	checkbox := BrCheckbox new.
	self assert: checkbox isChecked not.
	^ checkbox
]

{ #category : #'form-scripting' }
BrCheckboxExamples >> checkboxWithLook [
	<gtExample>
	<return: #BrCheckbox>
	^ self checkbox aptitude: BrGlamorousCheckboxAptitude
]

{ #category : #'form-scripting' }
BrCheckboxExamples >> checkedCheckbox [
	<gtExample>
	<return: #BrCheckbox>
	| checkbox |
	checkbox := self checkbox.
	checkbox check.
	self assert: checkbox isChecked.
	^ checkbox
]

{ #category : #'form-scripting' }
BrCheckboxExamples >> checkedCheckboxWithLook [
	<gtExample>
	<return: #BrCheckbox>
	^ self checkedCheckbox aptitude: BrGlamorousCheckboxAptitude
]
