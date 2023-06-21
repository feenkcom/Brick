Class {
	#name : #BrPagerScrollbarAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'pages',
		'pagesElement',
		'scrollbarElement'
	],
	#category : #'Brick-Pager - Look'
}

{ #category : #'instance creation' }
BrPagerScrollbarAptitude >> buildPreviewOfThePage: aPageContentElement [
	| aPreviewElement |

	aPageContentElement removeEventHandlersSuchThat: [ :each | each isKindOf: BrPagerPagePreviewResizeListener ].
	aPageContentElement removeEventHandlersSuchThat: [ :each | each isKindOf: BrPagerPagePreviewFocusListener ].

	aPreviewElement := BrButton new
		margin: (BlInsets all: 3);
		aptitude: (BrLazyStyleCommonAptitude new
			default: [ :aStyle | aStyle border: (BlBorder paint: Color gray width: 2) ];
			selected: [ :aStyle | aStyle border: (BlBorder paint: self theme editor focusedBorderColor width: 2) ]).

	aPageContentElement addEventHandler: (BrPagerPagePreviewResizeListener new previewElement: aPreviewElement).
	aPageContentElement addEventHandler: (BrPagerPagePreviewFocusListener new previewElement: aPreviewElement).
	
	aPreviewElement when: BlClickEvent do: [ :anEvent |
		anEvent consumed: true.
		self widget smoothScrollTo: (self pageElements indexOf: aPageContentElement) ].
	
	^ aPreviewElement
]

{ #category : #initialization }
BrPagerScrollbarAptitude >> initialize [
	| wrapperElement containerElement |
	super initialize.

	pages := OrderedDictionary new.

	pagesElement := BrHorizontalPane new.
	pagesElement
		alignCenter;
		fitContent.

	scrollbarElement := BlHorizontalScrollbarElement new
		disableClickToScroll;
		beAlwaysVisible;
		constraintsDo: [ :c | c vertical matchParent ];
		track: (BlElement new size: 0@0);
		thumb: (BlElement new
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent.
				c frame horizontal weight: 0.25.
				c frame vertical alignCenter ];
			background: (Color gray alpha: 0.35)).

	wrapperElement := BrFrame new
		fitContent;
		addChild: pagesElement;
		addChild: scrollbarElement.

	containerElement := BrHorizontalPane new
		margin: (BlInsets top: 5);
		alignCenter;
		hMatchParent;
		vFitContent;
		addChild: wrapperElement.

	self
		addChangeAddChildAs: #(content preview)
		with: [ containerElement ]
]

{ #category : #initialization }
BrPagerScrollbarAptitude >> initializeListeners [
	super initializeListeners.

	self when: BrPagerPagesChanged do: [ :anEvent | self onPagesChanged: anEvent pages ].
	self when: BrPagerPageAddedEvent do: [ :anEvent | self onPageAdded: anEvent page ].
	self when: BrPagerPageRemovedEvent do: [ :anEvent | self onPageRemoved: anEvent page ].
	self when: BrScrollbarScrollableChanged do: [ :anEvent |
		"by default is not assigned in the model"
		anEvent scrollableElement
			ifNotNil: [ :aScrollable | self scrollableChanged: aScrollable ] ]
]

{ #category : #initialization }
BrPagerScrollbarAptitude >> initializeRequests [
	super initializeRequests.
	
	self request: BrPagerPagesRequest new
]

{ #category : #hooks }
BrPagerScrollbarAptitude >> onPageAdded: aPageModel [
	self
		assert: [ self isAttachedToWidget ]
		description: [ 'I can not receive the page added event without being attached to a widget' ].

	self pages at: aPageModel put: nil.

	aPageModel whenAttachedDo: [ :aPageContentElement |
		self pages at: aPageModel put: aPageContentElement.
		self updatePagePreviews ]
]

{ #category : #hooks }
BrPagerScrollbarAptitude >> onPageRemoved: aPageModel [
	self
		assert: [ self isAttachedToWidget ]
		description: [ 'I can not receive the page removed event without being attached to a widget' ].
	
	(self pages at: aPageModel) removeEventHandlersSuchThat: [ :each | each isKindOf: BrPagerPagePreviewResizeListener ].
	self pages removeKey: aPageModel.
	self updatePagePreviews
]

{ #category : #hooks }
BrPagerScrollbarAptitude >> onPagesChanged: aCollectionOfModels [

	self pages removeAll.
	aCollectionOfModels do: [ :aPageModel |
		self pages at: aPageModel put: nil ].

	aCollectionOfModels do: [ :aPageModel |
		aPageModel whenAttachedDo: [ :aPageElement |
			self pages at: aPageModel put: aPageElement.
			self updatePagePreviews ] ]
]

{ #category : #accessing }
BrPagerScrollbarAptitude >> pageElements [
	^ self pages values select: #isNotNil
]

{ #category : #accessing }
BrPagerScrollbarAptitude >> pages [
	^ pages
]

{ #category : #hooks }
BrPagerScrollbarAptitude >> scrollableChanged: aScrollable [
	scrollbarElement attachTo: aScrollable
]

{ #category : #'as yet unclassified' }
BrPagerScrollbarAptitude >> updatePagePreviews [

	pagesElement removeChildren.

	self pageElements do: [ :aPageContentElement |
		pagesElement addChild: (self buildPreviewOfThePage: aPageContentElement) ]
]
