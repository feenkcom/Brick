Class {
	#name : #BrGlamorousMenuPinnableAptitude,
	#superclass : #BrMenuPinnableAptitude,
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #initialization }
BrGlamorousMenuPinnableAptitude >> newCloseButton [
	^ GtInspectorRoundButtonStencil small asElement
		icon: (BrPlusIconStencil close radius: 3) asElement;
		action: [ :aButton |
			self onCloseFrom: aButton ];
		zIndex: 10;
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored horizontal alignCenterAt: 1.0.
			c ignored vertical alignCenterAt: 0.0 ];
		addAptitude: (BrGlamorousWithLabelTooltipAptitude 
			text: 'Close').
]

{ #category : #initialization }
BrGlamorousMenuPinnableAptitude >> newHandleElement [
	^ super newHandleElement addAptitude: BrGlamorousHandleBarResizerAptitude new
]
