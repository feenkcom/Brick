Extension { #name : 'SequenceableCollection' }

{ #category : '*Brick' }
SequenceableCollection >> asBrItemsProvider [
	^ BrListSequenceableCollectionItemsProvider forCollection: self
]
