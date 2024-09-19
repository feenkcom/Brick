Class {
	#name : #BrDropdownContentStencil,
	#superclass : #BrAnchoredAptitudeStencilBuilder,
	#instVars : [
		'contentStencil',
		'decorator'
	],
	#category : #'Brick-Dropdown - Look'
}

{ #category : #'as yet unclassified' }
BrDropdownContentStencil >> buildDefault [
	| aContentElement |

	aContentElement := contentStencil
		widget: self widget;
		asElement.

	decorator value: aContentElement.
	^ aContentElement
]

{ #category : #accessing }
BrDropdownContentStencil >> contentStencil: aValuable [
	contentStencil := aValuable asStencilBuilder: BrAnchoredAptitudeStencilBuilder
]

{ #category : #accessing }
BrDropdownContentStencil >> decorator: aBlockWithOneArgument [
	decorator := aBlockWithOneArgument
]
