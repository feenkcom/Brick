Class {
	#name : #BrWithDropdownAptitudeStencil,
	#superclass : #BrWithAnchoredAptitudeWithHandleAndContentStencil,
	#category : #'Brick-Dropdown - Look'
}

{ #category : #accessing }
BrWithDropdownAptitudeStencil >> contentStencil: aStencil [
	"Decorate user's content stencil to add a resizer"
	contentStencil := BrDropdownResizableContentStencil new contentStencil: aStencil
]
