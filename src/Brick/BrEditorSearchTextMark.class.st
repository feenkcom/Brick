Class {
	#name : #BrEditorSearchTextMark,
	#superclass : #BlTextHighlightAttribute,
	#instVars : [
		'index',
		'isSelected'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #comparing }
BrEditorSearchTextMark >> equals: anAnotherAttribute [
	^ (super equals: anAnotherAttribute)
		and: [ self index = anAnotherAttribute index
				and: [ self isSelected = anAnotherAttribute isSelected ] ]
]

{ #category : #accessing }
BrEditorSearchTextMark >> index [
	^ index
]

{ #category : #accessing }
BrEditorSearchTextMark >> index: anInteger [
	index := anInteger
]

{ #category : #initialization }
BrEditorSearchTextMark >> initialize [
	super initialize.

	index := 1.
	isSelected := false.
]

{ #category : #accessing }
BrEditorSearchTextMark >> isCurrent [
	self
		deprecated: 'Please use #isSelected instead.'
		transformWith: '`@receiver isCurrent' -> '`@receiver isSelected'.

	^ self isSelected
]

{ #category : #accessing }
BrEditorSearchTextMark >> isCurrent: aBoolean [
	self
		deprecated: 'Please use isSelected: instead.'
		transformWith: '`@receiver isCurrent: `@statements1' -> '`@receiver isSelected: `@statements1'.
	self isSelected: aBoolean
]

{ #category : #accessing }
BrEditorSearchTextMark >> isSelected [
	^ isSelected
]

{ #category : #accessing }
BrEditorSearchTextMark >> isSelected: aBoolean [
	isSelected := aBoolean
]
