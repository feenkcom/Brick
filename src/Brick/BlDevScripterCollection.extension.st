Extension { #name : #BlDevScripterCollection }

{ #category : #'*Brick' }
BlDevScripterCollection >> asBrItemsProvider [
	^ BrSequenceableCollectionItemsProvider forCollection: self
]
