Class {
	#name : #BrProportionalHorizontalPagerLook,
	#superclass : #BrPagerLook,
	#instVars : [
		'pagesListElement',
		'resizers'
	],
	#category : #'Brick-Pager - Look'
}

{ #category : #initialization }
BrProportionalHorizontalPagerLook >> initialize [
	super initialize.

	resizers := OrderedDictionary new.

	pagesListElement := BlElement new.
	pagesListElement layout: BlLinearLayout horizontal.
	pagesListElement
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].

	self addChangeAddChildAs: #(content list) with: [ pagesListElement ]
]

{ #category : #hooks }
BrProportionalHorizontalPagerLook >> onPage: aPageModel elementAttached: aPageElement [

	aPageElement
		constraintsDo: [ :c | c horizontal matchParent ].

	pagesListElement hasChildren
		ifTrue: [
			| aResizerTarget aResizer |
			aResizerTarget := pagesListElement children last.
			
			aResizer := BrResizer new
				look: BrGlamorousResizerLook;
				target: pagesListElement children last;
				beRight;
				when: BlResizerResizedEvent
					do: [ :anEvent | self onResized: aResizerTarget to: anEvent extent and: aPageElement ].
			resizers at: aResizerTarget put: aResizer.
			pagesListElement addChild: aResizer ].

	pagesListElement addChild: aPageElement
]

{ #category : #hooks }
BrProportionalHorizontalPagerLook >> onPage: aPageModel elementDetached: aPageElement [
	pagesListElement removeChild: aPageElement
]

{ #category : #hooks }
BrProportionalHorizontalPagerLook >> onResized: aLeftPageElement to: anExtent and: aRightPageElement [
	| availableSize availableWeight aLeftWeight aRightWeight |
	
	aLeftPageElement constraintsDo: [ :c | c horizontal matchParent ].
	aRightPageElement constraintsDo: [ :c | c horizontal matchParent ].

	availableSize := aLeftPageElement width + aRightPageElement width.
	
	availableWeight := aLeftPageElement constraints linear weight + aRightPageElement constraints linear weight.

	aLeftWeight := (anExtent x / availableSize) asFloat min: 0.95 max: 0.05.
	aRightWeight := 1.0 - aLeftWeight.

	aLeftPageElement constraintsDo: [ :c | c linear weight: availableWeight * aLeftWeight ].
	aRightPageElement constraintsDo: [ :c | c linear weight: availableWeight * aRightWeight ].
]
