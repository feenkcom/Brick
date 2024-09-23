Class {
	#name : #BrDropdownResizableContentStencil,
	#superclass : #BrWithAnchoredAptitudeStencil,
	#instVars : [
		'contentStencil'
	],
	#category : #'Brick-Dropdown - Look'
}

{ #category : #accessing }
BrDropdownResizableContentStencil class >> stencilProperties [
	^ #(contentStencil)
]

{ #category : #accessing }
BrDropdownResizableContentStencil >> buildDefault [
	| aContentElement |

	aContentElement := contentStencil
		widget: self widget;
		aptitude: self aptitude;
		asElement.

	self aptitude createResizerOn: aContentElement.
	
	^ aContentElement
]

{ #category : #accessing }
BrDropdownResizableContentStencil >> contentStencil: aValuable [
	contentStencil := aValuable asStencilBuilder: BrWithAnchoredAptitudeStencil
]
