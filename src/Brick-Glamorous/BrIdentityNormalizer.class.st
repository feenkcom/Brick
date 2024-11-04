Class {
	#name : #BrIdentityNormalizer,
	#superclass : #BrGlamorousNormalizer,
	#instVars : [
		'dictionary',
		'resultIndex'
	],
	#category : #'Brick-Glamorous-Normalizer'
}

{ #category : #'instance creation' }
BrIdentityNormalizer class >> withCommand: aBlock [
	
	^(self new)
		command: aBlock;
		yourself
]

{ #category : #'initialize-release' }
BrIdentityNormalizer >> candidates [
	^ BrGlamorousColors distinctTenStrongColors
]

{ #category : #'initialize-release' }
BrIdentityNormalizer >> initialize [
	
	super initialize.
	resultIndex := 0.
	dictionary := Dictionary new.
	command := #yourself
]

{ #category : #private }
BrIdentityNormalizer >> nextResult [
	
	resultIndex := resultIndex \\ self candidates size + 1.
	^self candidates at: resultIndex
]

{ #category : #private }
BrIdentityNormalizer >> setIndexTo: aCandidate [
	"The method set the current index to the candidate given in parameter"
	
	resultIndex := (self candidates indexOf: aCandidate) - 1
]

{ #category : #accessing }
BrIdentityNormalizer >> value: anEntity [
	
	^ dictionary
		at: (command cull: anEntity)
		ifAbsentPut: [ self nextResult ]
]
