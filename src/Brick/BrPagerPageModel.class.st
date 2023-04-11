Class {
	#name : #BrPagerPageModel,
	#superclass : #BrWidgetModel,
	#instVars : [
		'embellisher',
		'futurePromises'
	],
	#category : #'Brick-Pager - Model'
}

{ #category : #'api - futures' }
BrPagerPageModel >> cancelPendingFuturePromises [
	futurePromises asArray do: [ :eachFuturePromise | eachFuturePromise cancelHard ]
]

{ #category : #initialization }
BrPagerPageModel >> defaultEmbellisher [
	^ BrPagerPageEmbellisher new
]

{ #category : #accessing }
BrPagerPageModel >> embellisher [
	^ embellisher
]

{ #category : #accessing }
BrPagerPageModel >> embellisher: aPagerPageEmbellisher [
	embellisher := aPagerPageEmbellisher
]

{ #category : #initialization }
BrPagerPageModel >> initialize [
	super initialize.

	embellisher := self defaultEmbellisher.
	futurePromises := AsyncSharedOrderedCollection new
]

{ #category : #initialization }
BrPagerPageModel >> initializeListeners [
	super initializeListeners.
	
	self when: BrAsyncElementFutureScheduledEvent do: [ :anEvent | self onFutureScheduled: anEvent ]
]

{ #category : #'api - futures' }
BrPagerPageModel >> onFutureScheduled: anEvent [
	self
		registerFuturePromise: anEvent futurePromise
		comingFrom: anEvent target
]

{ #category : #hooks }
BrPagerPageModel >> onRemovedFromPager: aBrPagerModel [
	"Is sent when a page is removed from a pager.
	Page should perform necessary cleanups"
	
	self cancelPendingFuturePromises
]

{ #category : #'api - futures' }
BrPagerPageModel >> pendingFuturePromises [
	^ futurePromises
]

{ #category : #'api - futures' }
BrPagerPageModel >> registerFuturePromise: aFuturePromise comingFrom: anElement [
	futurePromises add: aFuturePromise.
	
	aFuturePromise
		then: [ self unregisterFuturePromise: aFuturePromise ]
		otherwise: [ self unregisterFuturePromise: aFuturePromise ]
]

{ #category : #'api - futures' }
BrPagerPageModel >> unregisterFuturePromise: aFuturePromise [
	futurePromises remove: aFuturePromise
]
