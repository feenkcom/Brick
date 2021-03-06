"
I define a link button that represents a link (in a text document).
"
Class {
	#name : #BrGlamorousLinkButtonWithLabelLook,
	#superclass : #BrLook,
	#category : #'Brick-Glamorous-Buttons'
}

{ #category : #initialization }
BrGlamorousLinkButtonWithLabelLook >> initialize [
	super initialize.
	
	self addAll: {
		BrGlamorousLinkButtonLabelLook new
			labelDo: [ :aLabelElement |
				aLabelElement padding: (BlInsets all: 0) ].
		BrGlamorousLinkButtonExteriorLook new.
	}
]
