Extension { #name : #BlElement }

{ #category : #'*Brick-Editor' }
BlElement >> placeholderAlignment [
	^ self userData at: #brickPlaceholderAlignment ifAbsent: [ #alignMiddle ]
]

{ #category : #'*Brick-Editor' }
BlElement >> placeholderAlignment: aSymbol [
	self userData at: #brickPlaceholderAlignment put: aSymbol
]
