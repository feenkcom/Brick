Class {
	#name : #BlGlamorousExpanderShadowAptitude,
	#superclass : #BrLazyStyleCommonAptitude,
	#category : #'Brick-Glamorous-Expander'
}

{ #category : #initialization }
BlGlamorousExpanderShadowAptitude >> initialize [
	super initialize.

	self
		when: (self state focused)
			style: [ :aStyle | aStyle effect: BrGlamorousFocusedShadowEffect new ];
		when: (self state hovered and: self state unfocused)
			style: [ :aStyle | aStyle effect: BrGlamorousShadowEffect new ]
]
