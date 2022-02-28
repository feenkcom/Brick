Class {
	#name : #BrLazyWidget,
	#superclass : #BrAsyncWidget,
	#category : #'Brick-Async-Widget'
}

{ #category : #accessing }
BrLazyWidget >> content: aBlock [

	| oldBlock |
	oldBlock := aBlock.

	self successBlock: aBlock.

	oldBlock ifNotNil: [ self setup ].

	self asyncFuture future: (AsyncCachedFuture
			 forFuture: [  ] asAsyncFuture
			 cache: AsyncFutureCache new)
]
