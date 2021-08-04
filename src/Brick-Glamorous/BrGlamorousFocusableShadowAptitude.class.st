Class {
	#name : #BrGlamorousFocusableShadowAptitude,
	#superclass : #BrShadowAptitude,
	#category : 'Brick-Glamorous-Shadow'
}

{ #category : #initialization }
BrGlamorousFocusableShadowAptitude >> initialize [
	super initialize.
	self
		add:
			(BrStyleCommonAptitude new
				focused: [ :aStyle | 
					aStyle
						do: [ self color: (self theme default primaryBorderColor alpha: 0.75) ]
						after: [ self color: (self theme default darkBorderColor alpha: 0.5) ] ])
]
