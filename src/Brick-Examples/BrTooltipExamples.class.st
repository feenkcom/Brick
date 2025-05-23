Class {
	#name : #BrTooltipExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Tooltip'
}

{ #category : #accessing }
BrTooltipExamples >> aptitude [
	<gtExample>
	<return: #BrWithTooltipAptitude>
	| look |
	look := BrWithTooltipAptitude new.
	self assert: look visible equals: false.
	self assert: (look stencil asElement isKindOf: BlElement).
	^ look
]

{ #category : #accessing }
BrTooltipExamples >> element [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		background: Color red;
		yourself
]

{ #category : #accessing }
BrTooltipExamples >> elementWithModelAndLook [
	<gtExample>
	<return: #BlElement>
	| element look |
	element := self element.
	look := self aptitude.

	element aptitude: look.	"self assert: look stencil equals: model stencil."
	^ element
]

{ #category : #accessing }
BrTooltipExamples >> removingAnchor [
	"Removing an anchor with a tooltip while the tooltip is scheduled to show later, but an expensive task is running during before the removal effectively finishing after the show later delay lead to an assertion failure due to the assertion being too weak, assuming the widget of the look being still attached to the scene. This example exercises the race condition, yet there is now no assertion failure anymore."

	<gtExample>
	<return: #BlElement>
	| container1 container2 button |
	container1 := BlElement new
			layout: BlLinearLayout horizontal;
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ];
			padding: (BlInsets all: 20);
			aptitude: BrShadowAptitude;
			background: Color white;
			yourself.
	container2 := BlElement new
			layout: BlLinearLayout horizontal;
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ];
			padding: (BlInsets all: 20);
			aptitude: BrShadowAptitude;
			background: Color white;
			yourself.
	button := BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousVectorIcons remove;
			label: 'Click to remove me';
			action: [  "this task takes more than 1000ms, the default show delay on a tooltip"500000
					timesRepeat: [ BlElement new ].
				container1 removeFromParent ];
			yourself.
	container1 addChild: container2.
	container2 addChild: button.
	^ container1
]
