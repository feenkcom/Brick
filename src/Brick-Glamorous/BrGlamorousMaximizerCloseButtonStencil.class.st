Class {
	#name : #BrGlamorousMaximizerCloseButtonStencil,
	#superclass : #BrStencil,
	#category : #'Brick-Glamorous-Maximizer'
}

{ #category : #'api - instantiation' }
BrGlamorousMaximizerCloseButtonStencil >> create [
	^ BrButton new
		aptitude: BrGlamorousButtonCircularAptitude + BrGlamorousButtonIconAptitude
				+ BrGlamorousButtonFlatExteriorAptitude + BrGlamorousButtonLayoutAptitude;
		icon: [ BrGlamorousVectorIcons close asElement
				outskirts: BlOutskirts centered;
				background: Color gray;
				border: (BlBorder paint: Color transparent width: 0.8) ] asStencil;
		beLargeSize;
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c ignored vertical alignTop.
			c margin: (BlInsets top: 5) ]
]
