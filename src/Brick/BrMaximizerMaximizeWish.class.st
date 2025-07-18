"
I notify a {{gtClass:BrMaximizerHostAptitude}} that an {{gtMethod:BrMaximizerMaximizeWish>>#elementToMaximize | label=element}} wishes to be maximized.
I am called from {{gtMethod:BrWithMaximizerAptitude>>#maximizeElement:in:}}. 
I am used internally to communicate wished between two maximizer aptitudes.
If you want to send a maximize wish from your code, please, use {{gtClass:BrWithMaximizerAptitudeMaximizeWish}}. 
"
Class {
	#name : #BrMaximizerMaximizeWish,
	#superclass : #BlEvent,
	#instVars : [
		'maximizerLook',
		'elementToMaximize',
		'preferredBackground'
	],
	#category : #'Brick-Maximizer - Event'
}

{ #category : #accessing }
BrMaximizerMaximizeWish >> elementToMaximize [
	^ elementToMaximize
]

{ #category : #accessing }
BrMaximizerMaximizeWish >> elementToMaximize: anObject [
	elementToMaximize := anObject
]

{ #category : #accessing }
BrMaximizerMaximizeWish >> maximizerAptitude [
	^ maximizerLook
]

{ #category : #accessing }
BrMaximizerMaximizeWish >> maximizerAptitude: anObject [
	maximizerLook := anObject
]

{ #category : #accessing }
BrMaximizerMaximizeWish >> preferredBackground [
	^ preferredBackground
]

{ #category : #accessing }
BrMaximizerMaximizeWish >> preferredBackground: anObject [
	preferredBackground := anObject
]
