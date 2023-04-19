Trait {
	#name : #TBrScrollable,
	#category : #'Brick-Scrollable - UI'
}

{ #category : #'api - scrolling' }
TBrScrollable >> scrollBy: aDeltaPoint [
	"Request a scrollable widget to scroll by a given amount of points (pixels)"

	self dispatchEvent: (BrScrollByWish new delta: aDeltaPoint)
]

{ #category : #'api - scrolling' }
TBrScrollable >> scrollToIndex: anIndex [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index"

	self dispatchEvent: (BrScrollToItemWish new index: anIndex)
]

{ #category : #'api - scrolling' }
TBrScrollable >> scrollToIndex: anIndex offset: anOffset [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index.
	The item should be visible with a given offset from resolved layout start.
	See {{gtMethod:BlInfiniteLinearLayout>>#scrollToPosition:offset:}}"

	self dispatchEvent: (BrScrollToItemWish new 
		index: anIndex;
		offset: anOffset)
]
