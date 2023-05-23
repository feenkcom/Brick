Extension { #name : #TGtStreamGroup }

{ #category : #'*Brick' }
TGtStreamGroup >> asBrItemsProvider [
	^ BrStreamItemsProvider forStream: self stream
]
