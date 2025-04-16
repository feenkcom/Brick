Extension { #name : #BrPopoverPinnableAptitude }

{ #category : #'*Brick-Glamorous' }
BrPopoverPinnableAptitude >> withResizers [
	self addPinningAction: (BrMenuPinAction new
		preEndPinBlock: [ :aContext |
			self add: BrGlamorousWithHorizontalResizerAptitude new beLeft.
			self add: BrGlamorousWithHorizontalResizerAptitude new beRight.
			self add: BrGlamorousWithVerticalResizerAptitude new beBottom ])
]
