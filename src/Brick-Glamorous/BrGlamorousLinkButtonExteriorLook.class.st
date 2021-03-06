"
I define the rectangular exterior of the link button.
"
Class {
	#name : #BrGlamorousLinkButtonExteriorLook,
	#superclass : #BrStyleCommonLook,
	#instVars : [
		'backgroundPaint'
	],
	#category : #'Brick-Glamorous-Buttons - Support'
}

{ #category : #accessing }
BrGlamorousLinkButtonExteriorLook >> backgroundPaint [
	^ backgroundPaint
]

{ #category : #accessing }
BrGlamorousLinkButtonExteriorLook >> backgroundPaint: anObject [
	backgroundPaint := anObject.
	
	self default background: self backgroundPaint.
]

{ #category : #initialization }
BrGlamorousLinkButtonExteriorLook >> initialize [
	super initialize.
	backgroundPaint := BrGlamorousColors disabledButtonBackgroundColor.

	self default background: self backgroundPaint.
	self hovered background: BrGlamorousColors hoveredButtonTextColor.
	self pressed background: BrGlamorousColors pressedButtonTextColor.
	self disabled background: BrGlamorousColors disabledButtonTextColor.

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
		with: [ BlInsets all: 3 ]
]
