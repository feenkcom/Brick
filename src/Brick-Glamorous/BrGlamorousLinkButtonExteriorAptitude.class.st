"
I define the rectangular exterior of the link button.
"
Class {
	#name : #BrGlamorousLinkButtonExteriorAptitude,
	#superclass : #BrLazyStyleCommonAptitude,
	#instVars : [
		'backgroundPaint'
	],
	#category : #'Brick-Glamorous-Buttons - Support'
}

{ #category : #accessing }
BrGlamorousLinkButtonExteriorAptitude >> backgroundPaint [
	^ backgroundPaint ifNil: [ backgroundPaint := self theme button disabledBackgroundColor ]
]

{ #category : #accessing }
BrGlamorousLinkButtonExteriorAptitude >> backgroundPaint: anObject [
	backgroundPaint := anObject
]

{ #category : #initialization }
BrGlamorousLinkButtonExteriorAptitude >> initialize [
	super initialize.

	self
		addChangeProperty: #(widgetContent layout)
		with: [ BlLinearLayout horizontal alignCenter ].
	self
		addChangeProperty: #(widgetContent geometry)
		with: [ BlRoundedRectangleGeometry cornerRadius: 4 ].
	self
		addChangeProperty: #(widgetContent constraints vertical resizer)
		with: BlLayoutResizer fitContent.
	self
		addChangeProperty: #(widgetContent constraints horizontal resizer)
		with: BlLayoutResizer fitContent.
	self
		addChangeProperty: #(widgetContent padding)
		with: [ BlInsets all: 3 ].
	
	self default: [ :aStyle | aStyle background: self backgroundPaint ].
	self hovered: [ :aStyle | aStyle background: self theme button hoveredTextColor ].
	self pressed: [ :aStyle | aStyle background: self theme button pressedTextColor ].
	self disabled: [ :aStyle | aStyle background: self theme button disabledTextColor ]
]
