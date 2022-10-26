"
# Glamorous vertical scrollbar look
Is designed to add a vertical {{gtClass:BrScrollbar}} to a widget with a {{gtClass:TBlScrollable}} content. Due to the fact that the scrollbar should be above the scrollable content it should be added **after** a look that adds a scrollable content.

"
Class {
	#name : #BrGlamorousWithVerticalScrollbarAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'scrollbar'
	],
	#category : #'Brick-Glamorous-Scrollbar'
}

{ #category : #initialization }
BrGlamorousWithVerticalScrollbarAptitude >> initialize [
	super initialize.

	scrollbar := BrScrollbar new
			thumb: (BrScrollbarThumb new aptitude: BrGlamorousScrollbarThumbAptitude new);
			track: (BrScrollbarTrack new aptitude: BrGlamorousScrollbarTrackAptitude new);
			aptitude: BrScrollbarAptitude new + (self scrollBarHoverAptitude // #track)
					+ (self scrollBarHoverAptitude // #thumb);
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c margin: (BlInsets right: 2).
				c ignored horizontal alignRight.
				c ignored vertical alignBottom ].

	self
		addChangeAddChildAs: #(content verticalScrollbar)
		with: [ self updateScrollable.
			scrollbar ]
]

{ #category : #initialization }
BrGlamorousWithVerticalScrollbarAptitude >> scrollBarHoverAptitude [
	^ BrStyleCommonAptitude new
		default: [ :s | s background: self theme header defaultBackgroundColor ];
		hovered: [ :s | s background: BrGlamorousColors hoveredButtonBorderColor ]
]

{ #category : #'private - accessing' }
BrGlamorousWithVerticalScrollbarAptitude >> scrollable [
	^ self widget childNamed: #scrollable
]

{ #category : #'private - updating' }
BrGlamorousWithVerticalScrollbarAptitude >> updateScrollable [
	scrollbar scrollable: self scrollable.
]
