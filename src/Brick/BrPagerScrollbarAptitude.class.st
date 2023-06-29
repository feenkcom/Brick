Class {
	#name : #BrPagerScrollbarAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'pageModelsAndElements',
		'pagesElement',
		'scrollbarElement'
	],
	#category : #'Brick-Pager - Look'
}

{ #category : #private }
BrPagerScrollbarAptitude >> buildPreviewOfThePage: aPageContentElement model: aPageModel [
	| aPreviewElement |

	aPageContentElement removeEventHandlersSuchThat: [ :each | each isKindOf: BrPagerPagePreviewResizeListener ].
	aPageContentElement removeEventHandlersSuchThat: [ :each | each isKindOf: BrPagerPagePreviewFocusListener ].

	aPreviewElement := BrButton new
		margin: (BlInsets all: 3);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
		aptitude: BrGlamorousFadedButtonExteriourAptitude.

	aPageContentElement addEventHandler: (BrPagerPagePreviewResizeListener new previewElement: aPreviewElement).
	aPageContentElement addEventHandler: (BrPagerPagePreviewFocusListener new previewElement: aPreviewElement).

	aPreviewElement action: [
		| aFocusTarget |
		self widget smoothScrollTo: (self pageIndexOf: aPageModel).
		aFocusTarget := aPreviewElement userData
			at: #previousFocusedElement
			ifPresent: [ :aWeakReference |
				(aWeakReference at: 1)
					ifNotNil: [ :aPreviouslyFocusedElement |
						(aPreviouslyFocusedElement hasParent: aPageContentElement)
							ifTrue: [ aPreviouslyFocusedElement ]
							ifFalse: [ aPageContentElement ] ]
					ifNil: [ aPageContentElement ] ]
			ifAbsent: [ aPageContentElement ].

		aFocusTarget requestFocus ].

	^ aPreviewElement
]

{ #category : #initialization }
BrPagerScrollbarAptitude >> initialize [
	| wrapperElement containerElement |
	super initialize.

	pageModelsAndElements := OrderedCollection new.

	pagesElement := BrHorizontalPane new.
	pagesElement
		alignCenter;
		fitContent.

	scrollbarElement := BlHorizontalScrollbarElement new
		disableClickToScroll;
		beAlwaysVisible;
		constraintsDo: [ :c | c vertical exact: 6 ];
		track: (BlElement new size: 0@0);
		thumb: (BlElement new
			geometry: (BlStadiumGeometry new beHorizontal);
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent.
				c frame horizontal weight: 0.25.
				c frame vertical alignCenter ];
			aptitude: BrGlamorousFadedButtonExteriourAptitude).

	wrapperElement := BrVerticalPane new
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

	pageModelsAndElements add: (aPageModel -> nil).

	aPageModel whenAttachedDo: [ :aPageContentElement |
		pageModelsAndElements
			detect: [ :eachAssociation | eachAssociation key = aPageModel ]
			ifFound: [ :anAssociation |
				self
					pageIndexOf: aPageModel
					ifFound: [ :anIndex |
						| aPreviewElement |
						
						aPreviewElement := self buildPreviewOfThePage: aPageContentElement model: aPageModel.
						anAssociation value: { aPageContentElement . aPreviewElement }.
						pagesElement addChild: aPreviewElement at: anIndex ] ] ]
]

{ #category : #hooks }
BrPagerScrollbarAptitude >> onPageRemoved: aPageModel [
	self
		assert: [ self isAttachedToWidget ]
		description: [ 'I can not receive the page removed event without being attached to a widget' ].
	
	self
		pageElementAndPreviewOf: aPageModel
		ifFound: [ :aPageElement :aPreviewElement |
			aPageElement removeEventHandlersSuchThat: [ :each | each isKindOf: BrPagerPagePreviewResizeListener ].
			aPageElement removeEventHandlersSuchThat: [ :each | each isKindOf: BrPagerPagePreviewFocusListener ].

			aPreviewElement removeFromParent.

			self
				pageIndexOf: aPageModel
				ifFound: [ :anIndex | pageModelsAndElements removeIndex: anIndex ] ]
]

{ #category : #hooks }
BrPagerScrollbarAptitude >> onPagesChanged: aCollectionOfModels [

	pageModelsAndElements copy
		do: [ :eachAssociation | self onPageRemoved: eachAssociation key ].
		
	aCollectionOfModels do: [ :eachPageModel | self onPageAdded: eachPageModel ]
]

{ #category : #private }
BrPagerScrollbarAptitude >> pageElementAndPreviewOf: aPageModel ifFound: aBlock [
	pageModelsAndElements
		detect: [ :eachAssociation | eachAssociation key = aPageModel ]
		ifFound: [ :anAssociation |
			anAssociation value ifNotNil: [ :anArray |
				aBlock value: anArray first value: anArray second ] ]
]

{ #category : #accessing }
BrPagerScrollbarAptitude >> pageElements [
	^ pageModelsAndElements
		collect: [ :eachAssociation | eachAssociation value ]
		thenSelect: #isNotNil
]

{ #category : #private }
BrPagerScrollbarAptitude >> pageIndexOf: aPageModel [
	^ pageModelsAndElements
		detectIndex: [ :eachAssociation | eachAssociation key = aPageModel ]
		ifNone: [ 0 ]
]

{ #category : #private }
BrPagerScrollbarAptitude >> pageIndexOf: aPageModel ifFound: aBlock [
	| anIndex |
	anIndex := self pageIndexOf: aPageModel.
	anIndex > 0
		ifTrue: [ aBlock value: anIndex ]
]

{ #category : #hooks }
BrPagerScrollbarAptitude >> scrollableChanged: aScrollable [
	scrollbarElement attachTo: aScrollable
]
