Extension { #name : #Character }

{ #category : #'*Brick-Classifiers' }
Character >> isIdentifierish [
	^ self isAlphaNumeric | (self = $_)
]
