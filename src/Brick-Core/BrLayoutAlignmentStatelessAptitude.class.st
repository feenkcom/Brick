Class {
	#name : #BrLayoutAlignmentStatelessAptitude,
	#superclass : #BrStatelessStyleAptitude,
	#classVars : [
		'Styles'
	],
	#category : #'Brick-Core-Layout Alignment'
}

{ #category : #initialization }
BrLayoutAlignmentStatelessAptitude class >> initialize [	
	Styles := BrLayoutAlignmentStyles new
		none: [ :aStyle | aStyle alignNone ];
		topLeft: [ :aStyle | aStyle alignTopLeft ];
		topCenter: [ :aStyle | aStyle alignTopCenter ];
		topRight: [ :aStyle | aStyle alignTopRight ];
		centerLeft: [ :aStyle | aStyle alignCenterLeft ];
		center: [ :aStyle | aStyle alignCenter ];
		centerRight: [ :aStyle | aStyle alignCenterRight ];
		bottomLeft: [ :aStyle | aStyle alignBottomLeft ];
		bottomCenter: [ :aStyle | aStyle alignBottomCenter ];
		bottomRight: [ :aStyle | aStyle alignBottomRight ]
]

{ #category : #initialization }
BrLayoutAlignmentStatelessAptitude >> statelessStyles [
	^ Styles
]
