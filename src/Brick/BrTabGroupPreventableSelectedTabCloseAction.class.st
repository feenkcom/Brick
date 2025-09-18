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
	self selectedTabShouldBeRetained ifTrue: [ ^ self ].
	self forceClose
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
	^ self preventors anySatisfy: [ :eachPreventor | 
		eachPreventor selectedTabShouldBeRetainedInTabGroup: self tabGroup ]
]

{ #category : #accessing }
BrTabGroupPreventableSelectedTabCloseAction >> tabGroup [
	^ tabGroup
]

{ #category : #accessing }
BrTabGroupPreventableSelectedTabCloseAction >> tabGroup: anObject [
	tabGroup := anObject
]
