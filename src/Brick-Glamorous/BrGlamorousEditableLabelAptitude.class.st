Class {
	#name : #BrGlamorousEditableLabelAptitude,
	#superclass : #BrGlamorousEditorAptitude,
	#instVars : [
		'defaultBackground',
		'defaultForeground',
		'minWidth',
		'styleLook',
		'focusedBackground',
		'defaultBorderColor',
		'focusedBorderColor'
	],
	#category : #'Brick-Glamorous-Editor'
}

{ #category : #'instance creation' }
BrGlamorousEditableLabelAptitude class >> background: aDefaultBackgrounds focused: aFocusedBackground [
	^ self basicNew
		setDefaultBackground: aDefaultBackgrounds;
		setFocusedBackground: aFocusedBackground;
		initialize;
		yourself
]

{ #category : #'instance creation' }
BrGlamorousEditableLabelAptitude class >> background: aDefaultBackgrounds focused: aFocusedBackground border: aDefaultBorderColor focused: aFocusedBorderColor [
	^ self basicNew
		setDefaultBackground: aDefaultBackgrounds;
		setFocusedBackground: aFocusedBackground;
		setDefaultBorderColor: aDefaultBorderColor;
		setFocusedBorderColor: aFocusedBorderColor;
		initialize;
		yourself
]

{ #category : #accessing }
BrGlamorousEditableLabelAptitude >> defaultBackground [
	^ defaultBackground
]

{ #category : #accessing }
BrGlamorousEditableLabelAptitude >> defaultBackground: anObject [
	defaultBackground := anObject.
	styleLook 
		default: [ :aStyle |
			aStyle background: self defaultBackground ];
		when: [ :aState | aState hovered and: BrEditorModeState readOnly ]
			style: [ :aStyle | aStyle background: self defaultBackground darker ].
]

{ #category : #accessing }
BrGlamorousEditableLabelAptitude >> defaultBorder: aBlBorder [
	styleLook default: [ :aStyle | aStyle border: aBlBorder ]
]

{ #category : #accessing }
BrGlamorousEditableLabelAptitude >> defaultForeground [
	^ defaultForeground
]

{ #category : #accessing }
BrGlamorousEditableLabelAptitude >> defaultForeground: anObject [
	defaultForeground := anObject
]

{ #category : #initialization }
BrGlamorousEditableLabelAptitude >> initialize [
	super initialize.

	defaultBackground ifNil: [ defaultBackground := self theme status neutralBackgroundColor ].
	focusedBackground ifNil: [ focusedBackground := self theme editor focusedBorderColor ].
	defaultBorderColor ifNil: [ defaultBorderColor := self theme editor borderColor ].
	focusedBorderColor ifNil: [ focusedBorderColor := self theme editor focusedBorderColor ].
	
	defaultForeground := Color black.
	minWidth := 20.
	self
		addChangeProperty: #(widget constraints minWidth)
		with: [ self minWidth ].
	self
		add:
			(styleLook := BrStyleCommonAptitude new
				default: [ :aStyle | 
					aStyle geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
					aStyle background: defaultBackground.
					aStyle border: BlBorder empty ];
				when: BrEditorModeState editable
					style: [ :aStyle | aStyle background: Color white ];
				when: [ :aState | aState focused not and: BrEditorModeState editable ]
					style: [ :aStyle | 
					aStyle
						border: (BlBorder paint: defaultBorderColor width: 1) ];
				when: [ :aState | aState focused and: BrEditorModeState editable ]
					style: [ :aStyle | 
					aStyle
						border: (BlBorder paint: focusedBorderColor width: 1) ];
				when: [ :aState | aState hovered and: BrEditorModeState readOnly ]
					style: [ :aStyle | aStyle background: defaultBackground darker ];
				when: [ :aState | aState focused and: BrEditorModeState readOnly ]
					style: [ :aStyle | 
					aStyle background: focusedBackground.
					aStyle
						do: [ self foreground: Color white ]
						after: [ self foreground: self defaultForeground ] ])
]

{ #category : #initialization }
BrGlamorousEditableLabelAptitude >> initializeListeners [
	super initializeListeners.
	
	self when: BlClickEvent do: [ :anEvent | anEvent currentTarget dispatchEvent: (BlElementSelectedStateWish selected: true) ]
]

{ #category : #accessing }
BrGlamorousEditableLabelAptitude >> minWidth [
	^ minWidth
]

{ #category : #accessing }
BrGlamorousEditableLabelAptitude >> minWidth: anObject [
	minWidth := anObject
]

{ #category : #initialization }
BrGlamorousEditableLabelAptitude >> setDefaultBackground: aBackground [
	defaultBackground := aBackground
]

{ #category : #initialization }
BrGlamorousEditableLabelAptitude >> setDefaultBorderColor: aBorderColor [
	defaultBorderColor := aBorderColor
]

{ #category : #initialization }
BrGlamorousEditableLabelAptitude >> setFocusedBackground: aBackground [
	focusedBackground := aBackground
]

{ #category : #initialization }
BrGlamorousEditableLabelAptitude >> setFocusedBorderColor: aBorderColor [
	focusedBorderColor := aBorderColor
]
