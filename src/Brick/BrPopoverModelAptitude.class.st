"
I am a basic {{gtClass:BrMenuModel}}-related aptitude, holding the {{gtClass:BrMenuModel}} itself.
"
Class {
	#name : #BrPopoverModelAptitude,
	#superclass : #BrAptitude,
	#traits : 'TBrMenuWithMenuModel',
	#classTraits : 'TBrMenuWithMenuModel classTrait',
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #testing }
BrPopoverModelAptitude class >> isAbstract [
	^ self name = #BrPopoverModelAptitude
]

{ #category : #initialization }
BrPopoverModelAptitude >> initializeListeners [
	super initializeListeners.

	self when: BrPopoverDetachWish do: [ :anEvent | 
		self onMenuDetachWish: anEvent ]
]

{ #category : #'event handling' }
BrPopoverModelAptitude >> onMenuDetachWish: anEvent [
	self unsubscribeFromMenuModel
]
