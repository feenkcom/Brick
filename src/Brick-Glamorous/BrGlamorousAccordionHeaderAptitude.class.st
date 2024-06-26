Class {
	#name : #BrGlamorousAccordionHeaderAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'labelLook'
	],
	#category : 'Brick-Glamorous-Accordion'
}

{ #category : #initialization }
BrGlamorousAccordionHeaderAptitude >> initialize [
	super initialize.
	self
		addChangeProperty: #(widget layout)
			with: [ BlLinearLayout horizontal ];
		addChangeProperty: #(widget constraints vertical resizer)
			with: [ BlLayoutResizer fitContent ];
		addChangeProperty: #(widget constraints horizontal resizer)
			with: [ BlLayoutResizer matchParent ].
	self
		addAll:
			{(labelLook := BrGlamorousTextLabelAptitude new).
			(BrInteractiveAptitude new
				style: [ :aStyler | 
					aStyler
						default: [ labelLook foreground: self theme header defaultTextColor ].
					aStyler
						disabled: [ labelLook foreground: self theme header disabledTextColor ] ])}.
	self addChangeProperty: #(widget padding) with: [ BlInsets all: 12 ]
]
