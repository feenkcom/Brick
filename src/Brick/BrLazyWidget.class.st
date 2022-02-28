Class {
	#name : #BrLazyWidget,
	#superclass : #BrAsyncWidget,
	#category : #'Brick-Async-Widget'
}

{ #category : #accessing }
BrLazyWidget >> content: aBlock [

	(self successBlock: aBlock) asyncFuture future: (AsyncCachedFuture
			 forFuture: [  ] asAsyncFuture
			 cache: AsyncFutureCache new)
]
