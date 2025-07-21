"
I notify a {{gtClass:BrMaximizerHostAptitude}}'s container element that a maximized element is wished to obtain.
If you want to know which element is maximized, I am the right candidate for this task.

"
Class {
	#name : #BrMaximizerHostMaximizedElementWish,
	#superclass : #BlEvent,
	#instVars : [
		'maximizedElement'
	],
	#category : #'Brick-Maximizer - Event'
}

{ #category : #accessing }
BrMaximizerHostMaximizedElementWish >> maximizedElement [
	^ maximizedElement
]

{ #category : #accessing }
BrMaximizerHostMaximizedElementWish >> maximizedElement: anObject [
	maximizedElement := anObject
]

{ #category : #accessing }
BrMaximizerHostMaximizedElementWish >> maximizedElementDo: aBlock [
	maximizedElement ifNotNil: aBlock
]
