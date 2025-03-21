"
I am a basic {{gtClass:BrMenuModel}}-related aptitude, holding the {{gtClass:BrMenuModel}} itself.
"
Class {
	#name : #BrMenuModelAptitude,
	#superclass : #BrAptitude,
	#traits : 'TBrMenuWithMenuModel',
	#classTraits : 'TBrMenuWithMenuModel classTrait',
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #testing }
BrMenuModelAptitude class >> isAbstract [
	^ self name = #BrMenuModelAptitude
]

{ #category : #initialization }
BrMenuModelAptitude >> initializeListeners [
	super initializeListeners.

	self when: BrMenuDetachWish do: [ :anEvent | 
		self onMenuDetachWish: anEvent ]
]

{ #category : #'event handling' }
BrMenuModelAptitude >> onMenuDetachWish: anEvent [
	self unsubscribeFromMenuModel
]
