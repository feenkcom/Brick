"
I notify a {{gtClass:BrWithMaximizerAptitude}} that an element wishes to be minimized.
I am called from {{gtMethod:BrGlamorousMaximizerSwitcher>>#switch}}. 
I am used internally to communicate wished between two maximizer aptitudes.
If you want to send a minimize wish from your code, please, use {{gtClass:BrMaximizerHostMinimizeWish}}. 
"
Class {
	#name : #BrMaximizerMinimizeWish,
	#superclass : #BlEvent,
	#instVars : [
		'elementToMinimize',
		'hostElement'
	],
	#category : #'Brick-Maximizer - Event'
}

{ #category : #accessing }
BrMaximizerMinimizeWish >> elementToMinimize [
	^ elementToMinimize
]

{ #category : #accessing }
BrMaximizerMinimizeWish >> elementToMinimize: anObject [
	elementToMinimize := anObject
]

{ #category : #accessing }
BrMaximizerMinimizeWish >> hostElement [
	^ hostElement
]

{ #category : #accessing }
BrMaximizerMinimizeWish >> hostElement: anObject [
	hostElement := anObject
]
