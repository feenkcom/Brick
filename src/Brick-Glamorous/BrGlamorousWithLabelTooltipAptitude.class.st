Class {
	#name : #BrGlamorousWithLabelTooltipAptitude,
	#superclass : #BrWithTooltipAptitude,
	#category : #'Brick-Glamorous-Buttons'
}

{ #category : #'instance creation' }
BrGlamorousWithLabelTooltipAptitude >> newLabelWithText: aTextOrString [
	^ BrLabel new
		text: aTextOrString;
		padding: (BlInsets all: 5)
]

{ #category : #accessing }
BrGlamorousWithLabelTooltipAptitude >> text: aTextOrString [
	self
		stencil: [ BrAnchoredElement new
				aptitude:
					(BrGlamorousTooltipAptitude new
						content: (self newLabelWithText: aTextOrString);
						yourself);
				yourself ]
]
