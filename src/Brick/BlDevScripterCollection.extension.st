Extension { #name : #BlDevScripterCollection }

{ #category : #'*Brick' }
BlDevScripterCollection >> asBrItemsProvider [
	^ BrListSequenceableCollectionItemsProvider forCollection: self
]
