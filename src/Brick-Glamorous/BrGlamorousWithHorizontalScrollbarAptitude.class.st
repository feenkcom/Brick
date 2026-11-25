Class {
	#name : #BrGlamorousWithHorizontalScrollbarAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'scrollbar'
	],
	#category : #'Brick-Glamorous-Scrollbar'
}

{ #category : #initialization }
BrGlamorousWithHorizontalScrollbarAptitude >> initialize [
	super initialize.

	scrollbar := BrScrollbar new
			beHorizontal;
			thumb: [ BlElement new aptitude: BrGlamorousScrollbarThumbAptitude new ];
			track: [ BlElement new aptitude: BrGlamorousScrollbarTrackAptitude new ];
			aptitude: BrScrollbarAptitude new + (self scrollBarHoverAptitude // #track)
					+ (self scrollBarHoverAptitude // #thumb);
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c margin: (BlInsets right: 2).
				c ignored horizontal alignRight.
				c ignored vertical alignBottom ].

	self
		addChangeAddChildAs: #(content horizontalScrollbar)
		with: [ self updateScrollable.
			scrollbar ]
]

{ #category : #initialization }
BrGlamorousWithHorizontalScrollbarAptitude >> scrollBarHoverAptitude [
	^ BrLazyStyleCommonAptitude new
		default: [ :s :aTheme | s background: aTheme button fadedBackgroundColor ];
		hovered: [ :s :aTheme | s background: aTheme button hoveredBorderColor ]
]

{ #category : #'private - accessing' }
BrGlamorousWithHorizontalScrollbarAptitude >> scrollable [
	^ self widget childNamed: #scrollable
]

{ #category : #'private - updating' }
BrGlamorousWithHorizontalScrollbarAptitude >> updateScrollable [
	scrollbar scrollable: self scrollable.
]
