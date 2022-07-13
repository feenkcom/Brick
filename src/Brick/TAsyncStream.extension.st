Extension { #name : #TAsyncStream }

{ #category : #'*Brick' }
TAsyncStream >> asBrItemsProvider [
	^ BrStreamItemsProvider forStream: self
]
