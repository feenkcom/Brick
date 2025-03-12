Class {
	#name : #BrMenuMouseEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'menuAptitude'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #testing }
BrMenuMouseEventHandler >> canHide [
	^ menuAptitude ifNotNil: #canHide ifNil: [ false ]
]

{ #category : #testing }
BrMenuMouseEventHandler >> canShow [
	^ menuAptitude ifNotNil: #canShow ifNil: [ false ]
]

{ #category : #'api - displaying' }
BrMenuMouseEventHandler >> hide [
	"Hide menu"

	menuAptitude ifNotNil: #hide
]

{ #category : #accessing }
BrMenuMouseEventHandler >> menuAptitude [
	<return: #BrWithExplicitMenuAptitude>
	^ menuAptitude
]

{ #category : #accessing }
BrMenuMouseEventHandler >> menuAptitude: aBrWithExplicitMenuAptitude [
	menuAptitude := aBrWithExplicitMenuAptitude
]

{ #category : #accessing }
BrMenuMouseEventHandler >> modifiersMatcher [
	^ menuAptitude ifNotNil: #modifiersMatcher
]

{ #category : #accessing }
BrMenuMouseEventHandler >> mouseButton [
	^ menuAptitude ifNotNil: #mouseButton
]

{ #category : #accessing }
BrMenuMouseEventHandler >> relocator [
	^ menuAptitude ifNotNil: #relocator
]

{ #category : #'api - displaying' }
BrMenuMouseEventHandler >> showDueTo: anEvent [
	"Show menu"

	menuAptitude ifNotNil: [ :anAptitude | anAptitude showDueTo: anEvent ]
]

{ #category : #accessing }
BrMenuMouseEventHandler >> widgetDo: aBlock [
	menuAptitude ifNotNil: [ :anAptitude | anAptitude widgetDo: aBlock ]
]
