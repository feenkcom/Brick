Extension { #name : #SequenceableCollection }

{ #category : #'*Brick' }
SequenceableCollection >> asBrItemsProvider [
	^ BrSequenceableCollectionItemsProvider forCollection: self
]
