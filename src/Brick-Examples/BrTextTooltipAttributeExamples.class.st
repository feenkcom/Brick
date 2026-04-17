Class {
	#name : #BrTextTooltipAttributeExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Editor'
}

{ #category : #examples }
BrTextTooltipAttributeExamples >> textWithTooltipAttribute [
	<gtExample>
	| tooltipAttribute text |
	tooltipAttribute := BrTextTooltipAttribute new
			stencil: [ :aContext | 
				BrMenuExplicitHandle new
					menu: (BrMenuActionItem new
							label: ('Hover me' asRopedText fontSize: 32);
							action: [ :anElement :aButtonModel :anEvent |  ]) ].


	text := 'hover me' asRopedText.
	text fontSize: 48.

	(text from: 7 to: 8)
		italic;
		highlight: Color veryVeryLightGray;
		attribute: tooltipAttribute.

	^ text
]
