Class {
	#name : #BrScrollToItemWish,
	#superclass : #BrScrollWish,
	#instVars : [
		'index',
		'offset'
	],
	#category : #'Brick-Scrollable - Events'
}

{ #category : #testing }
BrScrollToItemWish >> hasOffset [
	<return: #Boolean>
	
	^ offset ~= BlInfiniteLinearLayout invalidOffset
]

{ #category : #accessing }
BrScrollToItemWish >> index [
	^ index
]

{ #category : #accessing }
BrScrollToItemWish >> index: anObject [
	index := anObject
]

{ #category : #initialization }
BrScrollToItemWish >> initialize [
	super initialize.
	
	offset := BlInfiniteLinearLayout invalidOffset
]

{ #category : #accessing }
BrScrollToItemWish >> offset [
	^ offset
]

{ #category : #accessing }
BrScrollToItemWish >> offset: anObject [
	offset := anObject
]
