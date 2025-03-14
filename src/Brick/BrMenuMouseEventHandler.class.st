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
	self
		assert: [ menuAptitude isNil ]
		description: [ 'Menu aptitude can be initialized only once' ].
	self
		assert: [ aBrWithExplicitMenuAptitude isNotNil ]
		description: [ 'Menu aptitude must be non-nil' ].

	menuAptitude := aBrWithExplicitMenuAptitude.
	self onMenuAptitudeInitialized
]

{ #category : #accessing }
BrMenuMouseEventHandler >> modifiersMatcher [
	^ menuAptitude ifNotNil: #modifiersMatcher
]

{ #category : #accessing }
BrMenuMouseEventHandler >> mouseButton [
	^ menuAptitude ifNotNil: #mouseButton
]

{ #category : #'api - hooks' }
BrMenuMouseEventHandler >> onInstalledIn: anObject [
	super onInstalledIn: anObject.

	self
		assert: [ menuAptitude isNotNil ]
		description: [ 'Menu aptitude must be initialized first' ]
]

{ #category : #initialization }
BrMenuMouseEventHandler >> onMenuAptitudeInitialized [
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
