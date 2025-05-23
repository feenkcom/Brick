Class {
	#name : #BrEditorSearchTextElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TBrLayoutAlignable',
	#classTraits : 'TBrLayoutResizable classTrait + TBrLayoutAlignable classTrait',
	#instVars : [
		'search',
		'index',
		'previousItem',
		'nextItem'
	],
	#category : #'Brick-Glamorous-Editor'
}

{ #category : #initialization }
BrEditorSearchTextElement >> defaultLayout [
	^ BlLinearLayout horizontal
]

{ #category : #'api - accessing' }
BrEditorSearchTextElement >> editorDo: aBlock [
	aBlock cull: search
]

{ #category : #'api - accessing' }
BrEditorSearchTextElement >> index: anIndex total: aCount [
	(anIndex isNil or: [ aCount isNil or: [ aCount isZero ] ])
		ifTrue: [ index text: '0'.
			^ self ].

	index
		text: ('{1}/{2}'
				format: {anIndex.
						aCount})
]

{ #category : #initialization }
BrEditorSearchTextElement >> initialize [
	super initialize.

	self initializeInputFieldElement.
	self initializeIndexElement.
	self initializePreviousItemElement.
	self initializeNextItemElement.

	self addChild: search as: #pattern.
	self addChild: previousItem as: #previous.
	self addChild: index as: #index.
	self addChild: nextItem as: #next.

	self
		addAptitude: (BrStyleCommonAptitude new
				default: [ :aStyle | aStyle border: BlBorder empty ];
				hovered: [ :aStyle | 
					aStyle
						border: (BlBorder paint: BrGlamorousColors disabledButtonBorderColor width: 1) ];
				focused: [ :aStyle | 
					aStyle
						border: (BlBorder paint: BrGlamorousColors focusedEditorBorderColor width: 1) ]).

	self hMatchParent.
	self vFitContent.
	self alignCenter
]

{ #category : #initialization }
BrEditorSearchTextElement >> initializeIndexElement [
	index := BrLabel new
			beTinySize;
			aptitude: BrGlamorousLabelAptitude;
			text: '0';
			constraintsDo: [ :c | 
				c linear vertical alignCenter ]
]

{ #category : #initialization }
BrEditorSearchTextElement >> initializeInputFieldElement [
	search := BrEditor new
			hMatchParent;
			vFitContent;
			inputFilter: BrTextEditorNoLineBreakInputFilter new;
			aptitude: BrGlamorousRegularEditorAptitude new;
			constraintsDo: [ :c | 
				c linear vertical alignCenter ].

	search editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | 
			self onSearchPatternModifiedEvent: anEvent ].
			
	search
		addShortcut: (BlShortcutWithAction new
				name: 'Find previous occurence';
				description: 'Find previous occurence of the find text';
				combination: BlKeyCombination primaryReturn;
				action: [ :anEvent | self onFindPreviousOccurenceEvent: anEvent ]);
		addShortcut: (BlShortcutWithAction new
				name: 'Find next occurence';
				description: 'Find next occurence of the find text';
				combination: BlKeyCombination return;
				action: [ :anEvent | self onFindNextOccurenceEvent: anEvent ]);
		addShortcut: (BlShortcutWithAction new
				name: 'End search';
				description: 'End search activity, e.g., close dialog, select text';
				combination: BlKeyCombination escape;
				action: [ :anEvent | self onEndSearchEvent: anEvent ]).
]

{ #category : #initialization }
BrEditorSearchTextElement >> initializeNextItemElement [
	nextItem := BrButton new
			beTinySize;
			aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude2;
			addAptitude: (BrGlamorousWithExplicitTooltipAptitude text: 'Find next occurence of the find text' shortcut: BlKeyCombination return);
			margin: (BlInsets right: 3);
			label: 'Find next occurence of the find text';
			icon: BrGlamorousVectorIcons right;
			action: [ :aButton :aButtonModel :anEvent | self onFindNextOccurenceEvent: anEvent ];
			constraintsDo: [ :c | c linear vertical alignCenter ]
]

{ #category : #initialization }
BrEditorSearchTextElement >> initializePreviousItemElement [
	previousItem := BrButton new
			beTinySize;
			aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude2;
			addAptitude: (BrGlamorousWithExplicitTooltipAptitude text: 'Find previous occurence of the find text' shortcut: BlKeyCombination builder primary return build);
			icon: BrGlamorousVectorIcons left;
			label: 'Find previous occurence of the find text';
			action: [ :aButton :aButtonModel :anEvent | self onFindPreviousOccurenceEvent: anEvent ];
			constraintsDo: [ :c | c linear vertical alignCenter ]
]

{ #category : #'api - notifying' }
BrEditorSearchTextElement >> notifySearchText: aText [
	aText size isZero
		ifTrue: [ 
			self index: nil total: nil.
			self dispatchEvent: BrEditorSearchTextNoPatternWish new ]
		ifFalse: [ 
			self progressIndex: nil total: 0.
			self
				dispatchEvent: (BrEditorSearchTextPatternWish new
						pattern: (BrEditorSearchTextSubstringPattern new text: aText copy)) ]
]

{ #category : #'event handling' }
BrEditorSearchTextElement >> onEndSearchEvent: anEvent [
	self dispatchEvent: BrEditorSearchTextEndWish new
]

{ #category : #'event handling' }
BrEditorSearchTextElement >> onFindNextOccurenceEvent: anEvent [
	self dispatchEvent: BrEditorSearchTextNextOccurenceWish new
]

{ #category : #'event handling' }
BrEditorSearchTextElement >> onFindPreviousOccurenceEvent: anEvent [
	self dispatchEvent: BrEditorSearchTextPreviousOccurenceWish new
]

{ #category : #'event handling' }
BrEditorSearchTextElement >> onSearchPatternModifiedEvent: anEvent [
	| aText |
	aText := anEvent text.
	self notifySearchText: aText
]

{ #category : #'api - accessing' }
BrEditorSearchTextElement >> pattern: aBlTextOrNil [
	aBlTextOrNil ifNil: [ ^ self ].
	search text characters = aBlTextOrNil asRopedText characters ifTrue: [ ^ self ].
	search text: aBlTextOrNil asRopedText
]

{ #category : #'api - accessing' }
BrEditorSearchTextElement >> progressIndex: anIndex total: aCount [
	"Possible inputs:
	- anything, nil or 0 => display 0+
	- nil     , integer  => display ?/integer+
	- integer , integer  => display integer/integer+"

	(aCount isNil or: [ aCount isZero ])
		ifTrue: [ index text: '0+'.
			^ self ].

	(anIndex isNil and: [ aCount isNotNil ])
		ifTrue: [ index text: ('{1}+' format: {aCount}).
			^ self ].

	index
		text: ('{1}/{2}+'
				format: {anIndex.
						aCount})
]

{ #category : #'api - search' }
BrEditorSearchTextElement >> styler: aStyler [
	"Convenience method to set counter.
	Must be called from a UI process."

	| anIndex aCount |
	anIndex := aStyler currentItem.
	aCount := aStyler currentCount.
	
	self index: anIndex total: aCount.
	self pattern: aStyler subtext
]
