Extension { #name : #TAsyncStream }

{ #category : #'*Brick' }
TAsyncStream >> asBrItemsProvider [
	^ BrListStreamItemsProvider forStream: self
]
