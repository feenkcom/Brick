"
# Dropdown
Use Glamorous dropdowns to show a contextual popup associated with a UI element on click.
This can be achieved by adding {{gtClass:BrGlamorousWithDropdownAptitude}} look to any visual component, such as {{gtClass:BrButton|label=Button}}
#### Dropdown for a button with a label
{{gtExample:BrGlamorousComponentsDropdowns>>#buttonWithLabel|previewShow=#gtLiveFor:|previewHeight=66|previewExpanded=true|codeExpanded=false}}
#### Dropdown for a button with an icon
{{gtExample:BrGlamorousComponentsDropdowns>>#buttonWithIcon|previewShow=#gtLiveFor:|previewHeight=66|previewExpanded=true|codeExpanded=false}}
#### Programmatically hide a dropdown
Sometimes it is necessary to hide a dropdown due to some user action, this can be achieved by firing {{gtClass:BrDropdownHideWish}} wish: 
{{gtExample:BrGlamorousComponentsDropdowns>>#hideDropdown|previewShow=#gtLiveFor:|previewHeight=66|previewExpanded=true|codeExpanded=false}}

"
Class {
	#name : #BrGlamorousComponentsDropdowns,
	#superclass : #BrGlamorousComponents,
	#category : #'Brick-Examples-! Glamorous components'
}

{ #category : #button }
BrGlamorousComponentsDropdowns >> buttonWithIcon [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude
				+ (BrGlamorousWithExplicitDropdownAptitude
						handle: [ BrButton new
								aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonIconAptitude;
								icon: BrGlamorousIcons menu ]
						content: [ BlElement new
								background: (Color gray alpha: 0.2);
								size: 100 @ 100;
								margin: (BlInsets all: 10) ]);
		icon: BrGlamorousIcons menu;
		label: 'Click me'
]

{ #category : #button }
BrGlamorousComponentsDropdowns >> buttonWithLabel [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude
				+ (BrGlamorousWithExplicitDropdownAptitude
						handle: [ BrButton new
								aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonLabelAptitude;
								label: 'Click me' ]
						content: [ BlElement new
								background: (Color gray alpha: 0.2);
								size: 100 @ 100;
								margin: (BlInsets all: 10) ]);
		label: 'Click me'
]

{ #category : #button }
BrGlamorousComponentsDropdowns >> hideDropdown [
	<gtExample>
	<return: #BrButton>
	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude
				+ (BrGlamorousWithExplicitDropdownAptitude
						handle: [ BrButton new
								aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonIconAptitude;
								icon: BrGlamorousIcons menu ]
						content: [ BrFrame new
								fitContent;
								addChild: (BrButton new
										aptitude: BrGlamorousButtonWithLabelAptitude;
										margin: (BlInsets all: 20);
										label: 'Close';
										action: [ :aButton | aButton fireEvent: BrDropdownHideWish new ]) ]);
		icon: BrGlamorousIcons menu;
		label: 'Click me'
]
