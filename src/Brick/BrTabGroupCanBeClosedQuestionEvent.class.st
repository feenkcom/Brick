Class {
	#name : #BrTabGroupCanBeClosedQuestionEvent,
	#superclass : #BlEvent,
	#instVars : [
		'isPrevented'
	],
	#category : #'Brick-Tabs - Support'
}

{ #category : #'api - preventors' }
BrTabGroupCanBeClosedQuestionEvent >> bePrevented [
	isPrevented := true
]

{ #category : #initialization }
BrTabGroupCanBeClosedQuestionEvent >> initialize [
	super initialize.

	isPrevented := false
]

{ #category : #'api - testing' }
BrTabGroupCanBeClosedQuestionEvent >> isPrevented [
	^ isPrevented
]

{ #category : #'api - preventors' }
BrTabGroupCanBeClosedQuestionEvent >> prevented: aBoolean [
	"Do not allow to override the prevention."

	aBoolean ifFalse: [ ^ self ].

	isPrevented := aBoolean
]
