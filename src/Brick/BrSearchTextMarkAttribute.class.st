Class {
	#name : #BrSearchTextMarkAttribute,
	#superclass : #BlTextHighlightAttribute,
	#instVars : [
		'index',
		'isSelected'
	],
	#category : #'Brick-List - Search Model'
}

{ #category : #comparing }
BrSearchTextMarkAttribute >> equals: anAnotherAttribute [
	^ (super equals: anAnotherAttribute)
		and: [ self index = anAnotherAttribute index
				and: [ self isSelected = anAnotherAttribute isSelected ] ]
]

{ #category : #accessing }
BrSearchTextMarkAttribute >> index [
	^ index
]

{ #category : #accessing }
BrSearchTextMarkAttribute >> index: anInteger [
	index := anInteger
]

{ #category : #initialization }
BrSearchTextMarkAttribute >> initialize [
	super initialize.

	index := 1.
	isSelected := false.
]

{ #category : #accessing }
BrSearchTextMarkAttribute >> isCurrent [
	self
		deprecated: 'Please use #isSelected instead.'
		transformWith: '`@receiver isCurrent' -> '`@receiver isSelected'.

	^ self isSelected
]

{ #category : #accessing }
BrSearchTextMarkAttribute >> isCurrent: aBoolean [
	self
		deprecated: 'Please use isSelected: instead.'
		transformWith: '`@receiver isCurrent: `@statements1' -> '`@receiver isSelected: `@statements1'.
	self isSelected: aBoolean
]

{ #category : #accessing }
BrSearchTextMarkAttribute >> isSelected [
	^ isSelected
]

{ #category : #accessing }
BrSearchTextMarkAttribute >> isSelected: aBoolean [
	isSelected := aBoolean
]
