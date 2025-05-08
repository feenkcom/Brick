Class {
	#name : #BrPopoverMouseEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'menuAptitude'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #testing }
BrPopoverMouseEventHandler >> canHide [
	^ menuAptitude ifNotNil: #canHide ifNil: [ false ]
]

{ #category : #testing }
BrPopoverMouseEventHandler >> canShow [
	^ menuAptitude ifNotNil: #canShow ifNil: [ false ]
]

{ #category : #'api - displaying' }
BrPopoverMouseEventHandler >> hide [
	"Hide menu"

	menuAptitude ifNotNil: #hide
]

{ #category : #accessing }
BrPopoverMouseEventHandler >> menuAptitude [
	<return: #BrWithExplicitPopoverAptitude>
	^ menuAptitude
]

{ #category : #accessing }
BrPopoverMouseEventHandler >> menuAptitude: aBrWithExplicitMenuAptitude [
	self
		assert: [ aBrWithExplicitMenuAptitude isNotNil ]
		description: [ 'Menu aptitude must be non-nil' ].

	menuAptitude == aBrWithExplicitMenuAptitude ifTrue: [ ^ self ].
	self
		assert: [ menuAptitude isNil ]
		description: [ 'Menu aptitude can be initialized only once' ].

	menuAptitude := aBrWithExplicitMenuAptitude.
	self onMenuAptitudeInitialized
]

{ #category : #accessing }
BrPopoverMouseEventHandler >> modifiersMatcher [
	^ menuAptitude ifNotNil: #modifiersMatcher
]

{ #category : #accessing }
BrPopoverMouseEventHandler >> mouseButton [
	^ menuAptitude ifNotNil: #mouseButton
]

{ #category : #'api - hooks' }
BrPopoverMouseEventHandler >> onInstalledIn: anObject [
	super onInstalledIn: anObject.

	self
		assert: [ menuAptitude isNotNil ]
		description: [ 'Menu aptitude must be initialized first' ]
]

{ #category : #initialization }
BrPopoverMouseEventHandler >> onMenuAptitudeInitialized [
]

{ #category : #accessing }
BrPopoverMouseEventHandler >> relocator [
	^ menuAptitude ifNotNil: #relocator
]

{ #category : #'api - displaying' }
BrPopoverMouseEventHandler >> showDueTo: anEvent [
	"Show menu"

	menuAptitude ifNotNil: [ :anAptitude | anAptitude showDueTo: anEvent ]
]

{ #category : #accessing }
BrPopoverMouseEventHandler >> widgetDo: aBlock [
	menuAptitude ifNotNil: [ :anAptitude | anAptitude widgetDo: aBlock ]
]
