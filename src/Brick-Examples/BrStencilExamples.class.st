Class {
	#name : #BrStencilExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Stencils'
}

{ #category : #'examples - instance creation' }
BrStencilExamples >> coloredElementStencil [
	<gtExample>
	<return: #BrExampleColoredElementStencil>
	^ BrExampleColoredElementStencil new
]

{ #category : #'examples - colored element stencil' }
BrStencilExamples >> coloredElementUsingBlock [
	<gtExample>
	<return: #BlElement>
	| aStencil anElement |
	aStencil := [ :aColor :aCornerRadius | 
		BlElement new
			size: 200 @ 200;
			background: aColor;
			geometry: (BlRoundedRectangleGeometry cornerRadius: aCornerRadius) ]
			asStencil.
	aStencil
		arguments: {Color blue alpha: 0.5.
				50}.

	anElement := aStencil create.

	self
		assert: anElement background
		equals: (Color blue alpha: 0.5) asBlBackground.
	self assert: anElement geometry cornerRadii equals: (BlCornerRadii radius: 50).

	^ anElement
]

{ #category : #'examples - list' }
BrStencilExamples >> createMaterialSimpleListUsingBlock [
	<gtExample>
	<return: #BrSimpleList>
	| aStencil aList |
	aStencil := [ BrSimpleList new ] asStencil.
	aList := aStencil create.
	aList items: (1 to: 100).
	^ aList
]

{ #category : #'examples - colored element stencil' }
BrStencilExamples >> customizedColoredElementUsingStencil [
	<gtExample>
	<return: #BlElement>
	| aStencil anElement |
	aStencil := self coloredElementStencil.
	aStencil color: (Color blue alpha: 0.5).
	aStencil cornerRadius: 50.

	anElement := aStencil create.

	self
		assert: anElement background
		equals: (Color blue alpha: 0.5) asBlBackground.
	self assert: anElement geometry cornerRadii equals: (BlCornerRadii radius: 50).

	^ anElement
]

{ #category : #'examples - colored element stencil' }
BrStencilExamples >> defaultColoredElementUsingStencil [
	<gtExample>
	<return: #BlElement>
	| aStencil anElement |
	aStencil := self coloredElementStencil.
	anElement := aStencil create.

	self assert: anElement background equals: Color gray asBlBackground.
	self assert: anElement geometry cornerRadii equals: (BlCornerRadii radius: 20).

	^ anElement
]

{ #category : #'examples - colored element stencil' }
BrStencilExamples >> defaultElementUsingBlock [
	<gtExample>
	<return: #BlElement>
	| aStencil anElement |
	aStencil := [ BlElement new
			size: 200 @ 200;
			background: Color gray;
			geometry: (BlRoundedRectangleGeometry cornerRadius: 20) ] asStencil.

	anElement := aStencil create.

	self assert: anElement background equals: Color gray asBlBackground.
	self assert: anElement geometry cornerRadii equals: (BlCornerRadii radius: 20).

	^ anElement
]

{ #category : #converting }
BrStencilExamples >> elementToStencil [
	<gtExample>
	<return: #BlElement>
	| anElement aStencil aSecondElement |
	anElement := BlElement new.
	aStencil := anElement asStencil.
	aSecondElement := aStencil asElement.
	self assert: anElement == aStencil.
	self assert: aSecondElement == anElement.
	^ anElement
]

{ #category : #converting }
BrStencilExamples >> elementToStencilBuilder [
	<gtExample>
	<return: #BrStencilBuilder>
	| anElement aStencilBuilder aSecondElement |
	anElement := BlElement new.
	aStencilBuilder := anElement asStencilBuilder.
	aSecondElement := aStencilBuilder asElement.
	self assert: (anElement == aStencilBuilder) not.
	self assert: (aStencilBuilder isKindOf: BrStencilBuilder).
	self assert: aSecondElement == anElement.
	^ aStencilBuilder
]
