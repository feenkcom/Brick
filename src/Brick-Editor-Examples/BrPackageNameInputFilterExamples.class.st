Class {
	#name : #BrPackageNameInputFilterExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples-Model'
}

{ #category : #accessing }
BrPackageNameInputFilterExamples >> simpleInputFilter [
	<gtExample>
	| filter |
	filter := BrPackageNameInputFilter new.

	self assert: (filter filter: 'AValidPackage') equals: 'AValidPackage'.
	self
		assert: (filter filter: 'A Valid Package With Spaces')
		equals: 'A Valid Package With Spaces'.
	self
		assert: (filter filter: 'A-Valid_Package-With Separators')
		equals: 'A-Valid_Package-With Separators'.
	self
		assert: (filter filter: 'Α Ωαλιδ Θνιψοδε Παψκαγε')
		equals: 'Α Ωαλιδ Θνιψοδε Παψκαγε'.
	self assert: (filter filter: '$AnInvalid%
	Pαckage$') equals: 'AnInvalidPαckage'.

	^ filter
]
