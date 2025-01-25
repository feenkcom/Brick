Class {
	#name : #BrMenuElementBuilder,
	#superclass : #Object,
	#traits : 'TBrMenuModelVisitor',
	#classTraits : 'TBrMenuModelVisitor classTrait',
	#category : #'Brick-Menu - UI'
}

{ #category : #visiting }
BrMenuElementBuilder >> visitMenuExplicit: aMenuModel [
	| anElement |
	anElement := aMenuModel stencil
			menuModel: aMenuModel;
			asElement.

	anElement addAptitude: (BrMenuHideableAptitude new menuModel: aMenuModel).

	^ anElement
]

{ #category : #visiting }
BrMenuElementBuilder >> visitMenuExplicitHandle: aMenuModel [
	| anElement |
	anElement := aMenuModel handleStencil asElement.
	anElement addAptitude: (BrMenuHideableAptitude new menuModel: aMenuModel).
	
	"If a user clicks on a handle, we want to close its menu."
	anElement
		when: BlClickEvent
		do: [ :anEvent | anEvent currentTarget fireEvent: BrMenuHideAllWish new ].

	^ anElement
]

{ #category : #visiting }
BrMenuElementBuilder >> visitMenuModel: aMenuModel [
	^ BlElement new
		layout: BlLinearLayout vertical;
		background: Color paleRed;
		constraintsDo: [ :c | 
			c padding: (BlInsets all: 5).
			c horizontal fitContent.
			c vertical fitContent ];
		addChild: (BlTextElement new text: aMenuModel gtDisplayString asRopedText)
]
