Class {
	#name : #BrExplicitIdentityNormalizer,
	#superclass : #BrIdentityNormalizer,
	#instVars : [
		'candidates',
		'defaultCandidate'
	],
	#category : #'Brick-Glamorous-Normalizer'
}

{ #category : #'instance creation' }
BrExplicitIdentityNormalizer class >> startingWithBlue [
	^ self new
			setIndexTo: Color blue;
			yourself
]

{ #category : #'instance creation' }
BrExplicitIdentityNormalizer class >> startingWithRed [
	^ self new
			setIndexTo: Color red;
			yourself
]

{ #category : #'instance creation' }
BrExplicitIdentityNormalizer class >> withCommand: aBlock withColors: aCollection withDefaultColor: aColor [
	
	^(self withCommand: aBlock)
		colors: aCollection;
		defaultColor: aColor;
		yourself
]

{ #category : #accessing }
BrExplicitIdentityNormalizer >> candidates [
	^ candidates
]

{ #category : #accessing }
BrExplicitIdentityNormalizer >> candidates: aCollection [
	candidates := aCollection
]

{ #category : #accessing }
BrExplicitIdentityNormalizer >> colors: anObject [
	candidates := anObject
]

{ #category : #accessing }
BrExplicitIdentityNormalizer >> defaultCandidate: anObject [
	
	defaultCandidate := anObject
]

{ #category : #accessing }
BrExplicitIdentityNormalizer >> defaultColor [
	
	^defaultCandidate
]

{ #category : #accessing }
BrExplicitIdentityNormalizer >> defaultColor: anObject [
	
	defaultCandidate := anObject
]

{ #category : #private }
BrExplicitIdentityNormalizer >> nextResult [
	resultIndex := resultIndex + 1.
	^resultIndex > self candidates size
		ifTrue: [ self defaultColor ]
		ifFalse: [ self candidates at: resultIndex ]
]
