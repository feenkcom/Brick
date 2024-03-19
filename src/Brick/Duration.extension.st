Extension { #name : #Duration }

{ #category : #'*Brick' }
Duration >> roundDownTo: aDuration [
 	"e.g. if the receiver is 5 minutes, 37 seconds, and aDuration is 2 minutes, answer 6 minutes."
 
 	^ self class nanoSeconds: (self asNanoSeconds roundDownTo: aDuration asNanoSeconds)
]

{ #category : #'*Brick' }
Duration >> roundUpTo: aDuration [
 	"e.g. if the receiver is 5 minutes, 37 seconds, and aDuration is 2 minutes, answer 6 minutes."
 
 	^ self class nanoSeconds: (self asNanoSeconds roundUpTo: aDuration asNanoSeconds)
]
