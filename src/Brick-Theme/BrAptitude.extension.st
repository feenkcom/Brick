Extension { #name : #BrAptitude }

{ #category : #'*Brick-Theme' }
BrAptitude >> theme [
	^ widget ifNil: [ BrTheme default ] ifNotNil: #theme
]
