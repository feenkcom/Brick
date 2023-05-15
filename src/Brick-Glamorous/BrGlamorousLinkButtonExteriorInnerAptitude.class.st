"
I am a copy of class BrGlamorousLinkButtonExteriorLook. This comment is copied from there, and might not be entirely accurate

I define the rectangular exterior of the link button.
"
Class {
	#name : #BrGlamorousLinkButtonExteriorInnerAptitude,
	#superclass : #BrLazyStyleCommonAptitude,
	#instVars : [
		'backgroundPaint'
	],
	#category : #'Brick-Glamorous-Buttons - Support'
}

{ #category : #accessing }
BrGlamorousLinkButtonExteriorInnerAptitude >> backgroundPaint [
	^ backgroundPaint ifNil: [ backgroundPaint := self theme button disabledBackgroundColor ]
]

{ #category : #accessing }
BrGlamorousLinkButtonExteriorInnerAptitude >> backgroundPaint: anObject [
	backgroundPaint := anObject
]

{ #category : #initialization }
BrGlamorousLinkButtonExteriorInnerAptitude >> initialize [
	super initialize.

	self
		default: [ :aStyle | aStyle background: self backgroundPaint ];
		hovered: [ :aStyle | aStyle background: self theme button hoveredTextColor ];
		pressed: [ :aStyle | aStyle background: self theme button pressedTextColor ];
		disabled: [ :aStyle | aStyle background: self theme button disabledTextColor ].

	self
		addChangeProperty: #(widgetContent layout)
		with: [ BlLinearLayout horizontal alignCenter ].
	self
		addChangeProperty: #(widgetContent geometry)
		with: [ BlRectangleGeometry new ].
	self
		addChangeProperty: #(widgetContent constraints vertical resizer)
		with: BlLayoutResizer fitContent.
	self
		addChangeProperty: #(widgetContent constraints horizontal resizer)
		with: BlLayoutResizer fitContent.
	self
		addChangeProperty: #(widgetContent padding)
		with: [ BlInsets top: 3 bottom: 3 ]
]
