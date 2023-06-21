Class {
	#name : #BrGlamorousScrollbarThumbAptitude,
	#superclass : #BrStyleCommonAptitude,
	#category : #'Brick-Glamorous-Scrollbar'
}

{ #category : #initialization }
BrGlamorousScrollbarThumbAptitude >> initialize [
	super initialize.
	self
		default: [ :aStyle | 
			aStyle geometry: (BlStadiumGeometry new) ].
	self
		add:
			(BrScrollbarOrientationAptitude new
				horizontal: [ :aStyle | 
					aStyle
						vExact: 6;
						hMatchParent ];
				vertical: [ :aStyle | 
					aStyle
						hExact: 6;
						vMatchParent ])
]
