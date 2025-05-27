Extension { #name : #BrAptitude }

{ #category : #'*Brick-Theme' }
BrAptitude >> theme [
	^ widget ifNil: [ BlTheme default ] ifNotNil: #theme
]
