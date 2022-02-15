Class {
	#name : #BrGlamorousTaggerEditableDropdownAptitude,
	#superclass : #BrGlamorousTaggerEditableAptitude,
	#instVars : [
		'content'
	],
	#category : #'Brick-Glamorous-Tagger'
}

{ #category : #accessing }
BrGlamorousTaggerEditableDropdownAptitude >> content [
	^ content
]

{ #category : #accessing }
BrGlamorousTaggerEditableDropdownAptitude >> content: aBlock [
	content := aBlock
]

{ #category : #accessing }
BrGlamorousTaggerEditableDropdownAptitude >> handleAcceptError: anError from: aTagCreatorElement [
	anError description traceCr
]

{ #category : #accessing }
BrGlamorousTaggerEditableDropdownAptitude >> newAddTagButton [

	| button acceptAction|
	acceptAction := [:aValue | 
			self
				requestAddTag: (BrTaggerTag named: aValue)
				from: button ].
	
	button := BrButton new
		          aptitude: BrGlamorousButtonRectangularAptitude new
			          + BrGlamorousButtonIconAptitude new
			          + BrGlamorousButtonWithLabelTooltipAptitude new
			          + (BrInteractiveCommonAptitude new
					           default: [ :aWidget | 
						           aWidget
							           border: BlBorder empty;
							           background: self theme status neutralBackgroundColor ];
					           hovered: [ :aWidget | 
						           aWidget background:
							           self theme status neutralBackgroundColor darker ];
					           pressed: [ :aWidget | 
						           aWidget background:
							           self theme status neutralBackgroundColor darker
								           darker ];
					           focused: [ :aWidget | 
						           aWidget border:
							           (BlBorder
								            paint: self theme editor focusedBorderColor
								            width: 1) ]) + (BrGlamorousWithDropdownAptitude
				           handle: [ 
					           BrButton new
						           aptitude: BrGlamorousButtonRectangularAptitude new
							           + BrGlamorousButtonIconAptitude new
							           + BrGlamorousButtonWithLabelTooltipAptitude new
							           + (BrInteractiveCommonAptitude new
									            default: [ :aWidget | 
										            aWidget
											            border: BlBorder empty;
											            background:
												            self theme status neutralBackgroundColor ];
									            hovered: [ :aWidget | 
										            aWidget background:
											            self theme status neutralBackgroundColor darker ];
									            pressed: [ :aWidget | 
										            aWidget background:
											            self theme status neutralBackgroundColor darker
												            darker ];
									            focused: [ :aWidget | 
										            aWidget border:
											            (BlBorder
												             paint: self theme editor focusedBorderColor
												             width: 1) ])
							           - BrGlamorousButtonExteriorAptitude;
						           icon: BrGlamorousVectorIcons add;
						           label: 'Add';
						           beSmallSize;
						           hExact: 20;
						           margin: margin;
						           constraintsDo: [ :c | c flow vertical alignCenter ] ]
				           content: [ self content value: button value: acceptAction ]);
		          icon: BrGlamorousVectorIcons add;
		          label: 'Add';
		          beSmallSize;
		          hExact: 20;
		          margin: margin;
		          constraintsDo: [ :c | c flow vertical alignCenter ];
		          addShortcut: (BlShortcutWithAction new
				           combination: BlKeyCombination arrowLeft;
				           action: [ :anEvent | 
					           anEvent currentTarget previousSiblingDo: [ :anElement | 
							           anElement requestFocus ] ]).
	^ button
]

{ #category : #accessing }
BrGlamorousTaggerEditableDropdownAptitude >> requestAddTag: aTaggerTag from: aTagCreatorElement [

	"I request the tagger to add a new tag while handling possible errors"

	[ 
	self dispatchEvent: (BrTaggerAddTagRequest new tag: aTaggerTag).
	aTagCreatorElement enqueueTask: (BlTaskAction new action: [ 
			 aTagCreatorElement dispatchEvent:
				 (BrDropdownHideWish new anchor: aTagCreatorElement) ]) ]
		on: Error
		do: [ :anError | 
		self handleAcceptError: anError from: aTagCreatorElement ]
]
