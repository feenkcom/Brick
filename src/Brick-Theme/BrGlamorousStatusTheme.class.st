Class {
	#name : #BrGlamorousStatusTheme,
	#superclass : #BrTheme,
	#instVars : [
		'successBackgroundColor',
		'successBorderColor',
		'neutralBackgroundColor',
		'errorBorderColor',
		'errorBackgroundColor',
		'failureBorderColor',
		'paleErrorBackgroundColor',
		'failureBackgroundColor'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #accessing }
BrGlamorousStatusTheme >> errorBackgroundColor [
	^ errorBackgroundColor
]

{ #category : #accessing }
BrGlamorousStatusTheme >> errorBackgroundColor: anObject [
	errorBackgroundColor := anObject
]

{ #category : #accessing }
BrGlamorousStatusTheme >> errorBorderColor [
	^ errorBorderColor
]

{ #category : #accessing }
BrGlamorousStatusTheme >> errorBorderColor: anObject [
	errorBorderColor := anObject
]

{ #category : #accessing }
BrGlamorousStatusTheme >> failureBackgroundColor [
	^ failureBackgroundColor
]

{ #category : #accessing }
BrGlamorousStatusTheme >> failureBackgroundColor: anObject [
	failureBackgroundColor := anObject
]

{ #category : #accessing }
BrGlamorousStatusTheme >> failureBorderColor [
	^ failureBorderColor
]

{ #category : #accessing }
BrGlamorousStatusTheme >> failureBorderColor: anObject [
	failureBorderColor := anObject
]

{ #category : #initialization }
BrGlamorousStatusTheme >> initialize [
	super initialize.
	successBackgroundColor := BrGlamorousColors successBackgroundColor.
	successBorderColor := BrGlamorousColors successBorderColor.
	neutralBackgroundColor := BrGlamorousColors neutralBackgroundColor.
	errorBorderColor := BrGlamorousColors errorBorderColor.
	errorBackgroundColor := BrGlamorousColors errorBackgroundColor.
	failureBorderColor := BrGlamorousColors failureBorderColor.
	paleErrorBackgroundColor := BrGlamorousColors
		paleErrorBackgroundColor.
	failureBackgroundColor := BrGlamorousColors failureBackgroundColor
]

{ #category : #accessing }
BrGlamorousStatusTheme >> neutralBackgroundColor [
	^ neutralBackgroundColor
]

{ #category : #accessing }
BrGlamorousStatusTheme >> neutralBackgroundColor: anObject [
	neutralBackgroundColor := anObject
]

{ #category : #accessing }
BrGlamorousStatusTheme >> paleErrorBackgroundColor [
	^ paleErrorBackgroundColor
]

{ #category : #accessing }
BrGlamorousStatusTheme >> paleErrorBackgroundColor: anObject [
	paleErrorBackgroundColor := anObject
]

{ #category : #accessing }
BrGlamorousStatusTheme >> successBackgroundColor [
	^ successBackgroundColor
]

{ #category : #accessing }
BrGlamorousStatusTheme >> successBackgroundColor: anObject [
	successBackgroundColor := anObject
]

{ #category : #accessing }
BrGlamorousStatusTheme >> successBorderColor [
	^ successBorderColor
]

{ #category : #accessing }
BrGlamorousStatusTheme >> successBorderColor: anObject [
	successBorderColor := anObject
]
