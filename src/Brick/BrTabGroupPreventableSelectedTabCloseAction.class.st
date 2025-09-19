Class {
	#name : #BrTabGroupPreventableSelectedTabCloseAction,
	#superclass : #Object,
	#instVars : [
		'tabGroup',
		'preventors'
	],
	#category : #'Brick-Tabs - Support'
}

{ #category : #'api - preventors' }
BrTabGroupPreventableSelectedTabCloseAction >> addPreventor: aPreventor [
	self preventors: (self preventors copyWith: aPreventor)
]

{ #category : #'api - actions' }
BrTabGroupPreventableSelectedTabCloseAction >> close [
	self tabGroup ifNil: [ ^ self ].
	self preventionReason
		ifReason: [ :aReason | aReason feedbackOnPreventedClose ]
		ifNone: [ self forceClose ]
]

{ #category : #'api - actions' }
BrTabGroupPreventableSelectedTabCloseAction >> cull: aShortcutEvent cull: aShortcut [
	"I am API for `BlShortcutWithAction`.
	In other words, I can be added as `BlShortcutWithAction>>#action:`"

	self close
]

{ #category : #'api - actions' }
BrTabGroupPreventableSelectedTabCloseAction >> forceClose [
	self tabGroup removeSelectedTab
]

{ #category : #initialization }
BrTabGroupPreventableSelectedTabCloseAction >> initialize [
	super initialize.
	preventors := Array empty.
	tabGroup := nil
]

{ #category : #'api - preventors' }
BrTabGroupPreventableSelectedTabCloseAction >> inquire [
	"Ask BrGroupTab>>#content's children whether they can be closed"

	self addPreventor: BrTabGroupActionInquiringPreventor new
]

{ #category : #'api - preventors' }
BrTabGroupPreventableSelectedTabCloseAction >> keepContentElement: aContentElement [
	self addPreventor: (BrTabGroupActionContentElementPreventor new 
		contentElement: aContentElement)
]

{ #category : #testing }
BrTabGroupPreventableSelectedTabCloseAction >> preventionReason [
	<return: #BrTabGroupActionPreventionReason>
	self preventors do: [ :eachPreventor | 
		| aReason |
		aReason := eachPreventor retainReasonInTabGroup: self tabGroup.
		aReason isReason ifTrue: [ ^ aReason ] ].
		
	^ BrTabGroupActionPreventionReason noReason
]

{ #category : #'api - preventors' }
BrTabGroupPreventableSelectedTabCloseAction >> preventors [
	^ preventors
]

{ #category : #'api - preventors' }
BrTabGroupPreventableSelectedTabCloseAction >> preventors: aCollection [
	preventors := aCollection
]

{ #category : #testing }
BrTabGroupPreventableSelectedTabCloseAction >> selectedTabShouldBeRetained [
	<return: #Boolean>
	^ self preventionReason isReason
]

{ #category : #accessing }
BrTabGroupPreventableSelectedTabCloseAction >> tabGroup [
	^ tabGroup
]

{ #category : #accessing }
BrTabGroupPreventableSelectedTabCloseAction >> tabGroup: anObject [
	tabGroup := anObject
]
