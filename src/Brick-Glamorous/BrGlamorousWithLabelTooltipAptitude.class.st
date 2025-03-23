"
Use {{gtClass:BrGlamorousWithExplicitTooltipAptitude}} instead.

I display a label tooltip of a given {{gtMethod:BrGlamorousWithLabelTooltipAptitude >> #text: | label=text}}. 
#Example
The following example shows a tooltip that it displayed to the left: {{gtExample: BrAnchoredByScripterExamples >> #tooltipLongLabelCenterLeft_AnchorMoreToTheRight | noCode | previewHeight=500 | previewShow=#gtAnchoredContainerOverviewFor:}}
#Hack Details
This section describes a **do-not-implement-it-this-way** code in the 
{{gtMethod: BrGlamorousWithLabelTooltipAptitude >> #newLabelWithText: | label=#selector }} method. 

**Introduction.** First, the current implementation of anchored widgets (tooltips, dropdowns, and context menus) was made with an assumption that its content is of fixed size. The practice shows that anchored content size is usually variable.

Second, there is no way to find a location in which the whole content is always visible. The anchor content may require to shrink.

**Posible future implementation.** A future implementation may follow the logic of the {{gtClass: BlGridLayout}} of the following steps:
	- First, it performs layout once to get an approximate size for each cell.
	- Second, based on the cell size, it finds a location for that cell.
	- Third, it computes a good enough distribution of sizes of cells.
	- Finally, it performs a final layout pass to finalize the layouts.
	
**The hack.** As we do not want to spend much time on this anchor widget missplacement issues (e.g., [feenkcom/gtoolkit#3170](https://github.com/feenkcom/gtoolkit/issues/3170)), we {{gtMethod: BrGlamorousWithLabelTooltipAptitude >> #newLabelWithText: | label=wrote}} a **do-not-implement-it-this-way** code that partially solved the anchored widget placement issue for this specific aptitude (the label tooltip). Please, **do not get inspired by this code**.

"
Class {
	#name : #BrGlamorousWithLabelTooltipAptitude,
	#superclass : #BrWithTooltipAptitude,
	#category : #'Brick-Glamorous-Buttons'
}

{ #category : #testing }
BrGlamorousWithLabelTooltipAptitude class >> isDeprecated [
	"Use BrGlamorousWithExplicitTooltipAptitude instead"

	^ true
]

{ #category : #'instance creation' }
BrGlamorousWithLabelTooltipAptitude class >> text: aTextOrString [
	^ self new text: aTextOrString
]

{ #category : #'instance creation' }
BrGlamorousWithLabelTooltipAptitude class >> text: aTextOrString keymap: aKeymap [
	^ self new text: aTextOrString keymap: aKeymap
]

{ #category : #'instance creation' }
BrGlamorousWithLabelTooltipAptitude >> newLabelWithText: aTextOrString [
	| anElement |
	anElement := BrLabel new
			aptitude: BrGlamorousLabelAptitude;
			text: aTextOrString;
			padding: (BlInsets all: 5).

	"This is a huge hack. Do not use it in other places!
	We use it to better estimate the preferredExtent value.
	Read more about it in the class comment."
	BlSpace new
		extent: preferredExtent;
		addChild: anElement;
		doLayout;
		removeChild: anElement.

	preferredExtent := anElement extent 
		+ (8 @ 8) "It is a handle size. Taken from
		{{gtMethod:BrAnchoredWithHandleAndContentAptitude>>#initialize}}".

	^ anElement
]

{ #category : #'instance creation' }
BrGlamorousWithLabelTooltipAptitude >> newLabelWithText: aTextOrString keymap: aKeymap [
	"Keymap can be:
		- a text, e.g., 'F5',
		- a BlKeyCombination instance, or
		- nil"

	| aContainer aLabel |
	aLabel := self newLabelWithText: aTextOrString.
	aLabel constraintsDo: [ :c | 
		c linear vertical alignCenter.
		c padding: (BlInsets all: 0). ].
	aContainer := BrHorizontalPane new
			fitContent;
			padding: (BlInsets all: 5);
			addChild: aLabel.

	aKeymap
		ifNotNil: [ aContainer
				addChild: (BrHorizontalPane new
						fitContent;
						constraintsDo: [ :c | 
							c linear vertical alignCenter ];
						geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
						border: (BlBorder paint: Color gray width: 1);
						padding: (BlInsets all: 1);
						margin: (BlInsets top: 2 left: 5);
						addChild: (BrLabel new
								aptitude: BrGlamorousLabelAptitude;
								text: (aKeymap asRopedText
										fontName: 'Source Code Pro';
										foreground: Color gray;
										fontSize: 10));
						yourself) ].
						
	"This is a huge hack. Do not use it in other places!
	We use it to better estimate the preferredExtent value.
	Read more about it in the class comment."
	BlSpace new
		extent: preferredExtent;
		addChild: aContainer;
		doLayout;
		removeChild: aContainer.
		
	preferredExtent := aContainer extent 
		+ (8 @ 8) "It is a handle size. Taken from
		{{gtMethod:BrAnchoredWithHandleAndContentAptitude>>#initialize}}".
						
	^ aContainer
]

{ #category : #accessing }
BrGlamorousWithLabelTooltipAptitude >> text: aTextOrString [
	self
		stencil: [ BrAnchoredElement new
				aptitude:
					(BrGlamorousTooltipAptitude new
						content: (self newLabelWithText: aTextOrString);
						yourself);
				yourself ]
]

{ #category : #accessing }
BrGlamorousWithLabelTooltipAptitude >> text: aTextOrString keymap: aKeymap [
	self
		stencil: [ BrAnchoredElement new
				aptitude:
					(BrGlamorousTooltipAptitude new
						content: (self newLabelWithText: aTextOrString keymap: aKeymap);
						yourself);
				yourself ]
]
