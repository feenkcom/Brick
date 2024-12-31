Extension { #name : #BrMenuPinnableAptitude }

{ #category : #'*Brick-Glamorous' }
BrMenuPinnableAptitude >> withResizers [
	self addPinningAction: (BrMenuPinAction new
		preEndPinBlock: [ :aContext |
			self add: BrGlamorousWithHorizontalResizerAptitude new beLeft.
			self add: BrGlamorousWithHorizontalResizerAptitude new beRight.
			self add: BrGlamorousWithVerticalResizerAptitude new beBottom ])
]
