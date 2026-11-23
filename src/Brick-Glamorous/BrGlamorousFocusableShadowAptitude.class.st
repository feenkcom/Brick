Class {
	#name : #BrGlamorousFocusableShadowAptitude,
	#superclass : #BrShadowAptitude,
	#category : #'Brick-Glamorous-Shadow'
}

{ #category : #initialization }
BrGlamorousFocusableShadowAptitude >> initialize [
	super initialize.
	self
		add:
			(BrLazyStyleCommonAptitude new
				focused: [ :aStyle | 
					aStyle
						do: [ self color: (self theme default primaryShadowColor) ]
						after: [ self color: (self theme default defaultShadowColor) ] ])
]
