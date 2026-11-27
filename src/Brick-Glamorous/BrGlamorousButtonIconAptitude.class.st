Class {
	#name : #BrGlamorousButtonIconAptitude,
	#superclass : #BrIconAptitude,
	#category : #'Brick-Glamorous-Buttons - Support'
}

{ #category : #'instance creation' }
BrGlamorousButtonIconAptitude class >> newVectorIconColorAptitudeFor: anIconBlock [
	^ BrLazyStyleCommonAptitude new
		@ anIconBlock;
		@ [ :anIcon | anIcon geometry isKindOf: BlSvgPath ];
		default: [ :aStyle :aTheme | aStyle background: aTheme button defaultTextForeground ];
		hovered: [ :aStyle :aTheme | aStyle background: aTheme button hoveredTextColor ];
		pressed: [ :aStyle :aTheme | aStyle background: aTheme button pressedTextColor ];
		disabled: [ :aStyle :aTheme | aStyle background: aTheme button disabledTextColor ];
		selected: [ :aStyle :aTheme | aStyle background: aTheme button hoveredTextColor ];
		yourself
]

{ #category : #initialization }
BrGlamorousButtonIconAptitude >> initialize [
	super initialize.

	self
		add: (BrSizeAdjustmentAptitude new
				@ [ self icon ];
				huge: [ :aStyle | aStyle scaleBy: 2 ];
				large: [ :aStyle | aStyle scaleBy: 1.5 ];
				normal: [ :aStyle | aStyle scaleBy: 1 ];
				small: [ :aStyle | aStyle scaleBy: 0.75 ];
				tiny: [ :aStyle | aStyle scaleBy: 0.75 ];
				mini: [ :aStyle | aStyle scaleBy: 0.5 ]).
	self add: (self class newVectorIconColorAptitudeFor: [ self icon ])
]

{ #category : #private }
BrGlamorousButtonIconAptitude >> updateIcon [
	super updateIcon.
	(self icon geometry isKindOf: BlSvgPath) ifTrue: [ ^ self ].
	self
		widgetDo: [ :aButton | 
			self class
				replaceBlackPaintIn: self icon
				with: aButton theme button defaultTextForeground
				matching: [ :anElement | 
					(anElement geometry isKindOf: BlSvgPath)
						or: [ anElement isKindOf: BlTextElement ] ] ]
]
