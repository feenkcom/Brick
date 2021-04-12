Extension { #name : #BrTheme }

{ #category : #'*Brick-Theme' }
BrTheme class >> default [
	^ default ifNil: [ default := self new ]
]
