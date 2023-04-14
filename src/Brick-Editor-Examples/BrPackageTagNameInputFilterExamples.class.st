Class {
	#name : #BrPackageTagNameInputFilterExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples-Model'
}

{ #category : #accessing }
BrPackageTagNameInputFilterExamples >> simpleInputFilter [
	<gtExample>
	| filter |
	filter := BrPackageTagNameInputFilter new.

	self assert: (filter filter: 'AValidTag') equals: 'AValidTag'.
	self
		assert: (filter filter: 'A Valid Tag With Spaces')
		equals: 'A Valid Tag With Spaces'.
	self
		assert: (filter filter: 'A-Valid_Tag-With Separators!')
		equals: 'A-Valid_Tag-With Separators!'.
	self
		assert: (filter filter: 'Α Ωαλιδ Θνιψοδε Ταγ')
		equals: 'Α Ωαλιδ Θνιψοδε Ταγ'.
	self assert: (filter filter: '$AnInvalid%
	Tαg$') equals: 'AnInvalidTαg'.

	^ filter
]
