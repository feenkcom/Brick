Class {
	#name : #BrGlamorousSpaceTabGroupAptitude,
	#superclass : #BrAptitude,
	#category : #'Brick-Glamorous-Tabs - Space'
}

{ #category : #initialization }
BrGlamorousSpaceTabGroupAptitude >> initialize [
	super initialize.

	self add: (BrGlamorousTabGroupHeaderAptitude new headerDo: [ :e | e padding: ((BlInsets all: 10) withBottom: 0) ]).
	self add: BrTabGroupContentAptitude new.

	self
		addChangeProperty: #(widget layout)
		with: [ BlLinearLayout vertical ].

	self
		addChange:
			(BrLookChange new
				up: [ :e | 
					self
						widgetDo:
							[ :aWidget | aWidget background: self theme header defaultBackgroundColor ] ];
				down: [ :e |  ];
				yourself)
]
